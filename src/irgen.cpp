#include "irgen.h"
#include <sstream>
#include <set>
#include <cstring>

/* The load/store width suffix for a type: b = 1 byte (char), w = 4-byte
   integer or pointer, s = 4-byte float, d = 8-byte double.  s and w move the
   same number of bytes but name different register files, which is why the
   floating forms exist at all. */
static const char* widthSuffix(const Type* t) {
    if (!t) return "w";
    if (t->kind == TY_FLOAT)  return "s";
    if (t->kind == TY_DOUBLE) return "d";
    return typeSize(t) == 1 ? "b" : "w";
}

/* "+.d", "<.s" and so on: an operator that works on floating values carries
   the width of the values it works on. */
static std::string fop(const std::string& op, const Type* t) {
    return op + "." + std::string(1, floatSuffix(t));
}

/* ================= emission helpers ================= */

std::string IrGen::newLabel() {
    std::ostringstream os; os << ".L" << (++labelCounter);
    return os.str();
}

int IrGen::newTemp(Type* t) {
    RegInfo r;
    std::ostringstream os; os << "t" << F->regs.size();
    r.name = os.str();
    r.named = false;
    r.ctype = typeName(t);
    r.tag = irTypeTag(t);
    F->regs.push_back(r);
    return (int)F->regs.size() - 1;
}

int IrGen::newNamedReg(const std::string& name, Type* t) {
    RegInfo r;
    r.name  = name;
    r.named = true;
    r.ctype = typeName(t);
    r.tag   = irTypeTag(t);
    F->regs.push_back(r);
    return (int)F->regs.size() - 1;
}

/* Semantic analysis laid out every user object below ctx->frameSize, so the
   frame can be grown here without disturbing them, and both tools read the
   final size from the function header.  The name begins with a dot, which no
   source identifier can contain, so it cannot collide with a user's variable. */
std::string IrGen::newTempSlot(const char* why, Type* t) {
    int align = typeAlign(t);
    if (align < 1) align = 1;
    int off = (F->frameSize + align - 1) / align * align;
    F->frameSize = off + typeSize(t);

    Slot sl;
    { std::ostringstream os; os << "." << why << (tmpSlots++); sl.name = os.str(); }
    sl.ctype  = typeName(t);
    sl.tag    = irTypeTag(t);
    sl.size   = typeSize(t);
    sl.align  = align;
    sl.offset = off;
    F->slots.push_back(sl);
    return sl.name;
}

Opnd IrGen::slotAddr(const std::string& name, Type* t) {
    int d = newTemp(T.ptrTo(t));
    Instr in; in.op = IR_ADDR_LOCAL; in.dst = d; in.label = name; in.line = curLine;
    emit(in);
    return Opnd::r(d);
}

int IrGen::regOf(Sym* s) {
    std::map<Sym*,int>::iterator it = symReg.find(s);
    if (it != symReg.end()) return it->second;
    RegInfo r;
    /* Anonymous temporaries are called t<index>, so a user variable literally
       named t7 would print as the same text as a different register.  Prefix
       such a name so that every register's printed name is unique. */
    r.name = s->uniq;
    {
        bool looksLikeTemp = r.name.size() > 1 && r.name[0] == 't';
        for (size_t i = 1; looksLikeTemp && i < r.name.size(); ++i)
            if (r.name[i] < '0' || r.name[i] > '9') looksLikeTemp = false;
        if (looksLikeTemp) r.name = "v." + r.name;
    }
    r.named = true;
    r.ctype = typeName(s->type);
    r.tag = irTypeTag(s->type);
    F->regs.push_back(r);
    int idx = (int)F->regs.size() - 1;
    symReg[s] = idx;
    return idx;
}

void IrGen::emit(const Instr& in) { F->code.push_back(in); }

/* Emitting a label drops an immediately preceding `goto` to it, which keeps
   the generated code readable without needing a separate peephole pass. */
void IrGen::emitLabel(const std::string& l) {
    if (!F->code.empty() && F->code.back().op == IR_GOTO && F->code.back().label == l)
        F->code.pop_back();
    Instr in; in.op = IR_LABEL; in.label = l; in.line = 0;
    emit(in);
}

Opnd IrGen::imm(long long v) { return Opnd::c(v); }

Type* IrGen::common(Type* a, Type* b) {
    int r = arithRank(a) > arithRank(b) ? arithRank(a) : arithRank(b);
    if (r == 3) return T.tyDouble();
    if (r == 2) return T.tyFloat();
    return T.tyInt();
}

/* Returns an operand for a floating-point constant.  The IR has no float
   immediates, so the value is placed in a read-only global (one per distinct
   bit pattern and width, shared through fconstPool) and loaded from there. */
Opnd IrGen::floatConst(double v, Type* t) {
    bool single = (t && t->kind == TY_FLOAT);
    int w = single ? 4 : 8;
    unsigned long long bits = 0;
    if (single) { float f = (float)v; unsigned int u = 0; memcpy(&u, &f, 4); bits = u; }
    else        { memcpy(&bits, &v, 8); }

    std::pair<unsigned long long,int> key(bits, w);
    std::map<std::pair<unsigned long long,int>, std::string>::iterator it = fconstPool.find(key);
    std::string name;
    if (it != fconstPool.end()) {
        name = it->second;
    } else {
        std::ostringstream os; os << ".fc" << fconstPool.size();
        name = os.str();
        fconstPool[key] = name;
        DataObj d;
        d.name  = name;
        d.ctype = single ? "float" : "double";
        d.tag   = single ? "float" : "double";
        d.size  = w;
        d.align = w;                /* a double constant is 8-byte aligned */
        DataObj::Piece p;
        p.width = w; p.isFloat = true;
        p.fval = single ? (double)(float)v : v;
        d.init.push_back(p);
        M->data.push_back(d);
    }

    int ad = newTemp(T.ptrTo(t));
    { Instr in; in.op = IR_ADDR_GLOBAL; in.dst = ad; in.label = name; in.line = curLine; emit(in); }
    int dr = newTemp(t);
    { Instr in; in.op = IR_LOAD; in.dst = dr; in.a = Opnd::r(ad);
      in.sop = single ? "s" : "d"; in.line = curLine; emit(in); }
    return Opnd::r(dr);
}

int IrGen::toReg(const Opnd& o, Type* t) {
    if (o.kind == Opnd::REG) return o.reg;
    int d = newTemp(t ? t : T.tyInt());
    Instr in; in.op = IR_COPY; in.dst = d; in.a = o; in.line = curLine;
    emit(in);
    return d;
}

/* The type of the OBJECT an expression designates.  For a node whose array
   type has decayed to a pointer this is still the array type, which is what
   determines the stride of an enclosing subscript (a[i][j]) and the size of a
   memcpy. */
static Type* objType(Node* e) {
    return (e->decayed && e->origType) ? e->origType : e->type;
}

/* ================= addresses ================= */

/* Returns a register holding the address of lvalue e: a local slot or a
   global for a name, the literal's data object for a string, the pointer
   itself for *p, base + index*size for a[i], base + member offset for s.m
   and p->m.  A cast or comma passes the address of its operand through. */
Opnd IrGen::addrOf(Node* e) {
    switch (e->kind) {
        case N_ID: {
            Sym* s = e->sym;
            int d = newTemp(T.ptrTo(s->type));
            Instr in;
            in.dst = d; in.line = curLine;
            /* The address of a function is a code address, not a data one, so
               it gets its own instruction; `uniq' is never rewritten for a
               function, so the IR's @name is the linker's name. */
            if (s->kind == SK_FUNC)        { in.op = IR_FADDR;       in.label = s->name; }
            else if (s->kind == SK_GLOBAL) { in.op = IR_ADDR_GLOBAL; in.label = s->uniq; }
            else                           { in.op = IR_ADDR_LOCAL;  in.label = s->uniq; }
            emit(in);
            return Opnd::r(d);
        }
        case N_SCONST: {
            int d = newTemp(T.ptrTo(T.tyChar()));
            Instr in; in.op = IR_ADDR_GLOBAL; in.dst = d; in.label = e->aux; in.line = curLine;
            emit(in);
            return Opnd::r(d);
        }
        case N_DEREF:
            return rvalue(e->kid(0));
        case N_INDEX: {
            Opnd base = rvalue(e->kid(0));
            Node* idx = e->kid(1);
            int elem = typeSize(objType(e));
            if (elem == 0) elem = 1;
            Opnd off = scaleIndex(rvalue(idx), elem);
            if (base.kind == Opnd::IMM && off.kind == Opnd::IMM)
                return imm(base.imm + off.imm);
            int d = newTemp(T.ptrTo(e->type));
            Instr in; in.op = IR_BIN; in.dst = d; in.a = base; in.b = off; in.sop = "+";
            in.line = curLine;
            emit(in);
            return Opnd::r(d);
        }
        case N_MEMBER: {
            Opnd base = addrOf(e->kid(0));
            int off = e->member ? e->member->offset : 0;
            if (off == 0) return base;
            int d = newTemp(T.ptrTo(e->type));
            Instr in; in.op = IR_BIN; in.dst = d; in.a = base; in.b = imm(off); in.sop = "+";
            in.line = curLine;
            emit(in);
            return Opnd::r(d);
        }
        case N_ARROW: {
            Opnd base = rvalue(e->kid(0));
            int off = e->member ? e->member->offset : 0;
            if (off == 0) return base;
            int d = newTemp(T.ptrTo(e->type));
            Instr in; in.op = IR_BIN; in.dst = d; in.a = base; in.b = imm(off); in.sop = "+";
            in.line = curLine;
            emit(in);
            return Opnd::r(d);
        }
        case N_CAST:
            return addrOf(e->kid(1));
        case N_COMMA:
            rvalue(e->kid(0));
            return addrOf(e->kid(1));
        default:
            /* Should be unreachable: semantic analysis rejects every other
               expression in lvalue position. */
            return rvalue(e);
    }
}

/* An lvalue reduced to a single place, evaluated exactly once. */
IrGen::LV IrGen::lvalue(Node* e) {
    LV lv;
    lv.type = e->type;
    if (e->kind == N_ID && e->sym && !e->sym->inMemory &&
        (e->sym->kind == SK_VAR || e->sym->kind == SK_PARAM)) {
        lv.isReg = true;
        lv.reg = regOf(e->sym);
        return lv;
    }
    lv.isReg = false;
    lv.reg = -1;
    lv.addr = addrOf(e);
    return lv;
}

Opnd IrGen::loadLV(const LV& lv) {
    if (lv.isReg) return Opnd::r(lv.reg);
    int d = newTemp(lv.type);
    Instr in; in.op = IR_LOAD; in.dst = d; in.a = lv.addr;
    in.sop = widthSuffix(lv.type);
    in.line = curLine;
    emit(in);
    return Opnd::r(d);
}

void IrGen::storeLV(const LV& lv, Opnd v) {
    if (lv.isReg) {
        Instr in; in.op = IR_COPY; in.dst = lv.reg; in.a = v; in.line = curLine;
        emit(in);
        /* a register-resident char must keep the sign-extended 8-bit value */
        if (lv.type && lv.type->kind == TY_CHAR) {
            Instr sx; sx.op = IR_SEXTB; sx.dst = lv.reg; sx.a = Opnd::r(lv.reg); sx.line = curLine;
            emit(sx);
        }
        return;
    }
    Instr in; in.op = IR_STORE; in.a = lv.addr; in.b = v;
    in.sop = widthSuffix(lv.type);
    in.line = curLine;
    emit(in);
}

/* ================= conversions ================= */

/* Converts value v from type `from' to type `to' and returns the result.
   Floating conversions use cvt.<to>.<from> and trunc.w.<from> (toward
   zero); a narrowing to char sign-extends the low byte (sextb); integer and
   pointer conversions of the same width need no instruction. */
Opnd IrGen::convert(Opnd v, Type* from, Type* to) {
    if (!from || !to) return v;

    /* ---- conversions involving a floating type ----
       The mnemonics are MIPS's own: cvt.<to>.<from> for the exact ones, and
       trunc.w.<from> for floating -> integer, which must truncate toward zero
       as C requires (plain cvt.w.* would honour the rounding mode instead). */
    bool ff = isFloat(from), tf = isFloat(to);
    if (ff || tf) {
        if (tf && !ff) {                            /* integer -> floating */
            if (!isInteger(from)) return v;         /* already reported */
            if (v.kind == Opnd::IMM) return floatConst((double)v.imm, to);
            int d = newTemp(to);
            Instr in; in.op = IR_CVT; in.dst = d; in.a = v;
            in.sop = std::string("cvt.") + floatSuffix(to) + ".w";
            in.line = curLine;
            emit(in);
            return Opnd::r(d);
        }
        if (ff && !tf) {                            /* floating -> integer */
            if (!isInteger(to)) return v;           /* already reported */
            int d = newTemp(T.tyInt());
            Instr in; in.op = IR_CVT; in.dst = d; in.a = v;
            in.sop = std::string("trunc.w.") + floatSuffix(from);
            in.line = curLine;
            emit(in);
            if (to->kind != TY_CHAR) return Opnd::r(d);
            int c = newTemp(to);                    /* then narrow to char */
            Instr sx; sx.op = IR_SEXTB; sx.dst = c; sx.a = Opnd::r(d); sx.line = curLine;
            emit(sx);
            return Opnd::r(c);
        }
        if (from->kind == to->kind) return v;       /* float <-> double */
        int d = newTemp(to);
        Instr in; in.op = IR_CVT; in.dst = d; in.a = v;
        in.sop = std::string("cvt.") + floatSuffix(to) + "." + floatSuffix(from);
        in.line = curLine;
        emit(in);
        return Opnd::r(d);
    }

    if (to->kind == TY_CHAR && from->kind != TY_CHAR) {
        if (v.kind == Opnd::IMM) return imm((long long)(signed char)v.imm);
        int d = newTemp(to);
        Instr in; in.op = IR_SEXTB; in.dst = d; in.a = v; in.line = curLine;
        emit(in);
        return Opnd::r(d);
    }
    return v;   /* int/pointer conversions are bit-preserving on this target */
}

Opnd IrGen::scaleIndex(Opnd idx, int elemSize) {
    if (elemSize == 1) return idx;
    if (idx.kind == Opnd::IMM) return imm(idx.imm * elemSize);
    int d = newTemp(T.tyInt());
    Instr in; in.op = IR_BIN; in.dst = d; in.a = idx; in.b = imm(elemSize); in.sop = "*";
    in.line = curLine;
    emit(in);
    return Opnd::r(d);
}

/* ================= binary operators ================= */

/* Generates a binary arithmetic or comparison operator on two already
   analysed operands.  Floating operations convert both sides to the common
   type and use one typed instruction; pointer +/- integer scales the
   integer by the element size; pointer - pointer divides the byte
   difference by it; integer operators pick the signed or unsigned form
   from inType. */
Opnd IrGen::binop(const std::string& op, Node* ln, Node* rn, Type* result, Type* inType) {
    Type* lt = ln->type;
    Type* rt = rn->type;

    /* Floating arithmetic and floating comparison.  Both operands are brought
       to the common type first, then one typed instruction does the work; a
       comparison still produces an integer 0/1. */
    if (isFloat(inType) && isArith(lt) && isArith(rt)) {
        Opnd a = convert(rvalue(ln), lt, inType);
        Opnd b = convert(rvalue(rn), rt, inType);
        int d = newTemp(result);
        Instr in; in.op = IR_BIN; in.dst = d; in.a = a; in.b = b;
        in.sop = fop(op, inType); in.line = curLine;
        emit(in);
        return Opnd::r(d);
    }

    /* pointer + integer / integer + pointer / pointer - integer */
    if ((op == "+" || op == "-") && isPointer(lt) && isInteger(rt)) {
        Opnd p = rvalue(ln);
        Opnd i = scaleIndex(rvalue(rn), typeSize(lt->base));
        int d = newTemp(lt);
        Instr in; in.op = IR_BIN; in.dst = d; in.a = p; in.b = i; in.sop = op; in.line = curLine;
        emit(in);
        return Opnd::r(d);
    }
    if (op == "+" && isInteger(lt) && isPointer(rt)) {
        Opnd i = scaleIndex(rvalue(ln), typeSize(rt->base));
        Opnd p = rvalue(rn);
        int d = newTemp(rt);
        Instr in; in.op = IR_BIN; in.dst = d; in.a = p; in.b = i; in.sop = "+"; in.line = curLine;
        emit(in);
        return Opnd::r(d);
    }
    /* pointer - pointer: byte difference divided by the element size */
    if (op == "-" && isPointer(lt) && isPointer(rt)) {
        Opnd a = rvalue(ln);
        Opnd b = rvalue(rn);
        int diff = newTemp(T.tyInt());
        Instr in; in.op = IR_BIN; in.dst = diff; in.a = a; in.b = b; in.sop = "-"; in.line = curLine;
        emit(in);
        int es = typeSize(lt->base);
        if (es <= 1) return Opnd::r(diff);
        int d = newTemp(T.tyInt());
        Instr dv; dv.op = IR_BIN; dv.dst = d; dv.a = Opnd::r(diff); dv.b = imm(es);
        dv.sop = "/"; dv.line = curLine;
        emit(dv);
        return Opnd::r(d);
    }

    Opnd a = rvalue(ln);
    Opnd b = rvalue(rn);
    int d = newTemp(result);
    Instr in; in.op = IR_BIN; in.dst = d; in.a = a; in.b = b; in.sop = op; in.line = curLine;
    emit(in);
    return Opnd::r(d);
}

/* ================= calls ================= */

/* Generates a call: evaluates an indirect callee first, then the
   arguments left to right (with default promotions for variadic ones and
   struct arguments passed as an address the callee copies from), emits
   the param instructions -- a hidden first one for a struct result, which
   is built in a caller-owned slot -- and the call.  Returns the result
   register, or none for void. */
Opnd IrGen::callExpr(Node* e) {
    Node* callee = e->kid(0);
    Node* args   = e->kid(1);
    size_t n = args ? args->kids.size() : 0;

    /* A plain name that denotes a function is called directly; anything else
       is an expression yielding a pointer to a function, and the call goes
       through that pointer.  Semantic analysis uses the same test. */
    bool direct = (callee->kind == N_ID && callee->sym && callee->sym->kind == SK_FUNC);
    Type* ft = 0;
    if (direct) ft = callee->sym->type;
    else if (callee->type && isPointer(callee->type)) ft = callee->type->base;

    /* A struct or union result is built in storage the CALLER owns; its
       address travels as a hidden first argument and comes back as the call's
       value, which is why `f().x' needs nothing special. */
    bool sret = isAggregate(e->type);
    Opnd retAddr;
    if (sret) retAddr = slotAddr(newTempSlot("ret", e->type), e->type);

    /* The callee of an indirect call is evaluated before the arguments, so a
       target like ops[i++] is read before anything else can change i. */
    Opnd target;
    if (!direct) target = Opnd::r(toReg(rvalue(callee), callee->type));

    /* Argument evaluation order: strictly LEFT TO RIGHT.  C leaves this
       unspecified; this generator fixes it so the IR is reproducible. */
    std::vector<Opnd> vals(n);
    std::vector<std::string> tags(n);
    std::vector<long long> sizes(n), aligns(n);
    for (size_t i = 0; i < n; ++i) {
        Node* a = args->kids[i];
        Type* pt;
        if (ft && i < ft->params.size()) {
            pt = ft->params[i];
        } else if (isFloat(a->type)) {
            /* Default argument promotion: a float passed in a variadic
               position becomes a double, which is why printf's %f reads eight
               bytes whatever the argument was declared as. */
            pt = T.tyDouble();
        } else {
            pt = a->type;
        }
        sizes[i] = typeSize(pt);
        aligns[i] = typeAlign(pt);
        if (isAggregate(pt)) {
            /* Passed by value, but what travels is an address: the callee's
               prologue makes the copy (see docs/IR-DESIGN.md), so the caller's
               object is never written to and exactly one copy is made. */
            vals[i] = Opnd::r(toReg(rvalue(a), T.ptrTo(pt)));
            tags[i] = "agg";
            continue;
        }
        Opnd v = convert(rvalue(a), a->type, pt);
        /* keep every argument in a register: `param` must name a value that
           still exists after later arguments have been evaluated */
        vals[i] = Opnd::r(toReg(v, pt));
        tags[i] = irTypeTag(pt);
    }

    long long nparam = (long long)n;
    if (sret) {
        Instr in; in.op = IR_PARAM; in.a = retAddr; in.tag = "ptr"; in.sret = true;
        in.n = typeSize(e->type); in.align = typeAlign(e->type);
        in.line = curLine;
        emit(in);
        ++nparam;
    }
    for (size_t i = 0; i < n; ++i) {
        Instr in; in.op = IR_PARAM; in.a = vals[i]; in.tag = tags[i];
        in.n = sizes[i]; in.align = aligns[i]; in.line = curLine;
        emit(in);
    }
    Instr c; c.op = IR_CALL; c.n = nparam; c.line = curLine;
    if (direct) c.label = callee->sym->name;
    else { c.indirect = true; c.a = target; }
    if (sret)                                       c.dst = newTemp(T.ptrTo(e->type));
    else if (!isVoid(e->type) && !isError(e->type)) c.dst = newTemp(e->type);
    emit(c);
    return c.dst >= 0 ? Opnd::r(c.dst) : Opnd::none();
}

/* A value used as a truth value.  The IR's branches test an integer register,
   so a floating value is first compared against 0.0 -- which is exactly what C
   says a floating condition means. */
Opnd IrGen::toTruth(Node* e) {
    Opnd v = rvalue(e);
    if (!isFloat(e->type)) return v;
    Opnd z = floatConst(0.0, e->type);
    int d = newTemp(T.tyInt());
    Instr in; in.op = IR_BIN; in.dst = d; in.a = v; in.b = z;
    in.sop = fop("!=", e->type); in.line = curLine;
    emit(in);
    return Opnd::r(d);
}

/* ================= conditions (jumping code) =================
 * Exactly one branch instruction is emitted per leaf, and && / || never
 * evaluate their right operand when the left one already decides.
 *
 * Stage 4 fix: in Stage 3 the left operand of && was given the WHOLE
 * condition's true label, so in `(a || b) && c` a true `a` jumped straight
 * to the true label without testing c (and symmetrically, in `(a && b) || c`
 * a false `a` skipped c).  The left operand of && now goes to a label in
 * front of the right operand when it is true (and that of || when it is
 * false).  The label is only created when the left operand can actually
 * jump there, so code that was correct before is unchanged, label numbers
 * included.
 */
static bool jumpsToFalse(Node* e, bool fallThroughIsTrue);

/* Whether cond(e, lt, lf, fallThroughIsTrue) can emit a branch to lt. */
static bool jumpsToTrue(Node* e, bool fallThroughIsTrue) {
    if (!e) return false;
    if (e->isConst) return !fallThroughIsTrue && e->constVal;
    if (e->kind == N_BINOP && e->sval == "&&") return jumpsToTrue(e->kid(1), fallThroughIsTrue);
    if (e->kind == N_BINOP && e->sval == "||")
        return jumpsToTrue(e->kid(0), false) || jumpsToTrue(e->kid(1), fallThroughIsTrue);
    if (e->kind == N_UNOP && e->sval == "!") return jumpsToFalse(e->kid(0), !fallThroughIsTrue);
    if (e->kind == N_COMMA) return jumpsToTrue(e->kid(1), fallThroughIsTrue);
    return !fallThroughIsTrue;
}

/* Whether cond(e, lt, lf, fallThroughIsTrue) can emit a branch to lf. */
static bool jumpsToFalse(Node* e, bool fallThroughIsTrue) {
    if (!e) return false;
    if (e->isConst) return fallThroughIsTrue && !e->constVal;
    if (e->kind == N_BINOP && e->sval == "&&")
        return jumpsToFalse(e->kid(0), true) || jumpsToFalse(e->kid(1), fallThroughIsTrue);
    if (e->kind == N_BINOP && e->sval == "||") return jumpsToFalse(e->kid(1), fallThroughIsTrue);
    if (e->kind == N_UNOP && e->sval == "!") return jumpsToTrue(e->kid(0), !fallThroughIsTrue);
    if (e->kind == N_COMMA) return jumpsToFalse(e->kid(1), fallThroughIsTrue);
    return fallThroughIsTrue;
}

/* Generates the jumping code for a condition: control reaches `lt' when e
   is true and `lf' when it is false.  fallThroughIsTrue says which label
   directly follows, so only one branch is emitted where possible.  && and ||
   short-circuit, ! swaps the targets, relational operators become a single
   `if' and anything else is compared against zero. */
void IrGen::cond(Node* e, const std::string& lt, const std::string& lf, bool fallThroughIsTrue) {
    if (!e) return;
    curLine = e->line;

    if (e->isConst) {
        /* a constant condition still has to branch somewhere */
        if (e->constVal) { if (!fallThroughIsTrue) { Instr g; g.op = IR_GOTO; g.label = lt; g.line = curLine; emit(g); } }
        else             { if (fallThroughIsTrue)  { Instr g; g.op = IR_GOTO; g.label = lf; g.line = curLine; emit(g); } }
        return;
    }

    if (e->kind == N_BINOP && e->sval == "&&") {
        if (jumpsToTrue(e->kid(0), true)) {     /* true left -> right operand */
            std::string mid = newLabel();
            cond(e->kid(0), mid, lf, true);
            emitLabel(mid);
        } else cond(e->kid(0), lt, lf, true);   /* ifFalse left goto lf */
        cond(e->kid(1), lt, lf, fallThroughIsTrue);
        return;
    }
    if (e->kind == N_BINOP && e->sval == "||") {
        if (jumpsToFalse(e->kid(0), false)) {   /* false left -> right operand */
            std::string mid = newLabel();
            cond(e->kid(0), lt, mid, false);
            emitLabel(mid);
        } else cond(e->kid(0), lt, lf, false);  /* if left goto lt */
        cond(e->kid(1), lt, lf, fallThroughIsTrue);
        return;
    }
    if (e->kind == N_UNOP && e->sval == "!") {
        cond(e->kid(0), lf, lt, !fallThroughIsTrue);
        return;
    }
    if (e->kind == N_COMMA) {
        rvalue(e->kid(0));
        cond(e->kid(1), lt, lf, fallThroughIsTrue);
        return;
    }

    Opnd v = toTruth(e);
    Instr in;
    in.line = curLine;
    if (fallThroughIsTrue) { in.op = IR_IFFALSE; in.a = v; in.label = lf; }
    else                   { in.op = IR_IF;      in.a = v; in.label = lt; }
    emit(in);
}

/* && / || / ! used for their value rather than for control flow */
Opnd IrGen::materializeBool(Node* e) {
    int d = newTemp(T.tyInt());
    std::string lt = newLabel(), lf = newLabel(), le = newLabel();
    cond(e, lt, lf, true);
    emitLabel(lt);
    { Instr in; in.op = IR_COPY; in.dst = d; in.a = imm(1); in.line = curLine; emit(in); }
    { Instr g; g.op = IR_GOTO; g.label = le; g.line = curLine; emit(g); }
    emitLabel(lf);
    { Instr in; in.op = IR_COPY; in.dst = d; in.a = imm(0); in.line = curLine; emit(in); }
    emitLabel(le);
    return Opnd::r(d);
}

/* ================= rvalues ================= */

/* Generates code for e used as a value and returns the operand holding it.
   Constants become immediates (floating ones a pooled global), names load
   from their register or slot, arrays and functions decay to addresses,
   and each operator kind (assignment, compound assignment, ++/--, &&/||
   as values, ?:, casts, calls, member access) has its own case. */
Opnd IrGen::rvalue(Node* e) {
    if (!e) return imm(0);
    curLine = e->line;

    if (e->isConst) return imm(e->constVal);
    /* A floating constant expression -- a literal, or something folded from
       literals -- comes out of the data section. */
    if (e->isFConst) return floatConst(e->fconstVal, e->type);

    switch (e->kind) {
    case N_ID: {
        Sym* s = e->sym;
        if (!s) return imm(0);
        if (s->kind == SK_FUNC) return addrOf(e);      /* a function decays to its address */
        /* An array decays to its address; a struct or union in rvalue position
           is likewise represented by its address, because every use of one --
           assignment, passing it by value, returning it -- is a block copy
           from that address rather than a value in a register. */
        if (isArray(s->type) || isAggregate(s->type)) return addrOf(e);
        if (!s->inMemory && (s->kind == SK_VAR || s->kind == SK_PARAM))
            return Opnd::r(regOf(s));
        LV lv; lv.isReg = false; lv.reg = -1; lv.type = s->type; lv.addr = addrOf(e);
        return loadLV(lv);
    }

    case N_SCONST:
        return addrOf(e);

    case N_BINOP: {
        const std::string& o = e->sval;
        if (o == "&&" || o == "||") return materializeBool(e);
        return binop(o, e->kid(0), e->kid(1), e->type,
                     e->cmpType ? e->cmpType : e->type);
    }

    case N_UNOP: {
        const std::string& o = e->sval;
        if (o == "+") return rvalue(e->kid(0));
        Node* a0 = e->kid(0);
        /* !x on a floating value is x == 0.0 */
        if (o == "!" && isFloat(a0->type)) {
            Opnd v = rvalue(a0);
            Opnd z = floatConst(0.0, a0->type);
            int d = newTemp(T.tyInt());
            Instr in; in.op = IR_BIN; in.dst = d; in.a = v; in.b = z;
            in.sop = fop("==", a0->type); in.line = curLine;
            emit(in);
            return Opnd::r(d);
        }
        Opnd a = rvalue(a0);
        int d = newTemp(e->type);
        Instr in; in.op = IR_UN; in.dst = d; in.a = a;
        in.sop = isFloat(e->type) ? fop(o, e->type) : o;
        in.line = curLine;
        emit(in);
        return Opnd::r(d);
    }

    case N_ADDR:
        return addrOf(e->kid(0));

    case N_DEREF: case N_INDEX: case N_MEMBER: case N_ARROW: {
        /* an array or aggregate in rvalue position yields its address */
        if (isArray(e->type) || isAggregate(e->type) || e->decayed) return addrOf(e);
        LV lv; lv.isReg = false; lv.reg = -1; lv.type = e->type; lv.addr = addrOf(e);
        return loadLV(lv);
    }

    case N_ASSIGN: {
        Node* l = e->kid(0); Node* r = e->kid(1);
        if (isAggregate(l->type)) {
            Opnd dst = addrOf(l);
            Opnd src = addrOf(r);
            Instr in; in.op = IR_BLKCOPY; in.a = dst; in.b = src;
            in.n = typeSize(l->type); in.align = typeAlign(l->type);
            in.line = curLine;
            emit(in);
            return dst;
        }
        LV lv = lvalue(l);
        if (e->sval == "=") {
            Opnd v = rvalue(r);
            v = convert(v, r->type, l->type);
            storeLV(lv, v);
            if (lv.isReg) return Opnd::r(lv.reg);
            /* the value of the assignment is what was actually stored */
            if (l->type->kind == TY_CHAR) return convert(v, T.tyInt(), T.tyChar());
            return v;
        }
        /* compound assignment: the address in `lv` was computed only once */
        std::string bo = e->sval.substr(0, e->sval.size() - 1);
        Opnd old = loadLV(lv);
        Opnd rhs = rvalue(r);
        Opnd res;
        if (isPointer(l->type)) {
            Opnd scaled = scaleIndex(rhs, typeSize(l->type->base));
            int d = newTemp(l->type);
            Instr in; in.op = IR_BIN; in.dst = d; in.a = old; in.b = scaled; in.sop = bo;
            in.line = curLine;
            emit(in);
            res = Opnd::r(d);
        } else if (isFloat(l->type) || isFloat(r->type)) {
            /* x += y on floating values: combine in the common type, then
               convert back to the type of x, exactly as C specifies. */
            Type* ct = common(l->type, r->type);
            Opnd a = convert(old, l->type, ct);
            Opnd b = convert(rhs, r->type, ct);
            int d = newTemp(ct);
            Instr in; in.op = IR_BIN; in.dst = d; in.a = a; in.b = b;
            in.sop = isFloat(ct) ? fop(bo, ct) : bo;
            in.line = curLine;
            emit(in);
            res = convert(Opnd::r(d), ct, l->type);
        } else {
            int d = newTemp(T.tyInt());
            Instr in; in.op = IR_BIN; in.dst = d; in.a = old; in.b = rhs; in.sop = bo;
            in.line = curLine;
            emit(in);
            res = convert(Opnd::r(d), T.tyInt(), l->type);
        }
        storeLV(lv, res);
        if (lv.isReg) return Opnd::r(lv.reg);
        return res;
    }

    case N_PREINC: case N_PREDEC: case N_POSTINC: case N_POSTDEC: {
        Node* a = e->kid(0);
        bool isInc = (e->kind == N_PREINC || e->kind == N_POSTINC);
        bool isPre = (e->kind == N_PREINC || e->kind == N_PREDEC);
        LV lv = lvalue(a);
        Opnd old = loadLV(lv);
        /* The old value must survive the store.  toReg() would hand back the
           variable's OWN register when the target is register-resident, and the
           store below would then clobber the value we are about to return, so
           copy unconditionally into a fresh temporary. */
        int oldReg = newTemp(a->type);
        { Instr cp; cp.op = IR_COPY; cp.dst = oldReg; cp.a = old; cp.line = curLine; emit(cp); }
        int d = newTemp(a->type);
        Instr in; in.op = IR_BIN; in.dst = d; in.a = Opnd::r(oldReg);
        in.line = curLine;
        if (isFloat(a->type)) {           /* the step is 1.0, not 1 */
            in.b = floatConst(1.0, a->type);
            in.sop = fop(isInc ? "+" : "-", a->type);
        } else {
            in.b = imm(isPointer(a->type) ? typeSize(a->type->base) : 1);
            in.sop = isInc ? "+" : "-";
        }
        emit(in);
        Opnd nv = isFloat(a->type) ? Opnd::r(d)
                                   : convert(Opnd::r(d), T.tyInt(), a->type);
        storeLV(lv, nv);
        if (isPre) return lv.isReg ? Opnd::r(lv.reg) : nv;
        return Opnd::r(oldReg);
    }

    case N_COND: {
        int d = newTemp(e->type);
        std::string lt = newLabel(), lf = newLabel(), le = newLabel();
        cond(e->kid(0), lt, lf, true);
        emitLabel(lt);
        { Opnd v = rvalue(e->kid(1));
          v = convert(v, e->kid(1)->type, e->type);
          Instr in; in.op = IR_COPY; in.dst = d; in.a = v; in.line = curLine; emit(in); }
        { Instr g; g.op = IR_GOTO; g.label = le; g.line = curLine; emit(g); }
        emitLabel(lf);
        { Opnd v = rvalue(e->kid(2));
          v = convert(v, e->kid(2)->type, e->type);
          Instr in; in.op = IR_COPY; in.dst = d; in.a = v; in.line = curLine; emit(in); }
        emitLabel(le);
        return Opnd::r(d);
    }

    case N_COMMA:
        rvalue(e->kid(0));
        return rvalue(e->kid(1));

    case N_CALL:
        return callExpr(e);

    case N_CAST: {
        Opnd v = rvalue(e->kid(1));
        return convert(v, e->kid(1)->type, e->type);
    }

    default:
        return imm(0);
    }
}

/* ================= statements ================= */

void IrGen::block(Node* s) {
    for (size_t i = 0; i < s->kids.size(); ++i) {
        Node* it = s->kids[i];
        if (it->kind == N_DECL) localDecl(it);
        else stmt(it);
    }
}

void IrGen::localDecl(Node* d) {
    for (size_t i = 1; i < d->kids.size(); ++i) {
        Node* idl = d->kids[i];
        Sym* s = idl->sym;
        if (!s || (s->kind != SK_VAR && s->kind != SK_PARAM)) continue;
        if (idl->kid(1)) initLocal(s, idl->kid(1));
    }
}

/* Initialises a local variable from its declaration's initializer.  A
   register-held scalar is assigned the converted value; an object in memory
   (array, struct, address-taken scalar) gets its address taken; an array
   or struct is first zero-filled with memzero, then initLocalAt stores the
   initializer's elements into it. */
void IrGen::initLocal(Sym* s, Node* init) {
    curLine = init->line;

    /* `int x = {5};' -- a scalar may be initialised with a brace-enclosed list
       holding one element (C99 6.7.8p11).  Unwrap it, because a scalar held in
       a register is initialised by evaluating the initializer as an
       expression, and an initializer LIST is not one.  (An empty list, which
       ISO C does not allow, falls through and yields zero.) */
    while (init->kind == N_INIT_LIST && init->kids.size() == 1 &&
           !isArray(s->type) && !isAggregate(s->type))
        init = init->kids[0];

    if (!s->inMemory) {
        /* scalar in a register */
        Opnd v = rvalue(init);
        v = convert(v, init->type, s->type);
        int r = regOf(s);
        Instr in; in.op = IR_COPY; in.dst = r; in.a = v; in.line = curLine;
        emit(in);
        if (s->type->kind == TY_CHAR) {
            Instr sx; sx.op = IR_SEXTB; sx.dst = r; sx.a = Opnd::r(r); sx.line = curLine;
            emit(sx);
        }
        return;
    }
    /* in a frame slot */
    int d = newTemp(T.ptrTo(s->type));
    { Instr in; in.op = IR_ADDR_LOCAL; in.dst = d; in.label = s->uniq; in.line = curLine; emit(in); }
    Opnd base = Opnd::r(d);

    bool aggregate = isArray(s->type) || isAggregate(s->type);
    if (aggregate) {
        /* C zero-fills the parts of a partially initialised aggregate */
        Instr z; z.op = IR_MEMZERO; z.a = base; z.n = typeSize(s->type); z.line = curLine;
        emit(z);
    }
    initLocalAt(base, 0, s->type, init);
}

/* Stores initializer `init' into the object of type t at base+offset:
   a string literal into a char array byte by byte, a brace list recursively
   matching list entries to elements or members by position, and a scalar
   or whole-struct expression with one store or block copy.  An aggregate
   has already been zero-filled by the caller. */
void IrGen::initLocalAt(Opnd base, int offset, Type* t, Node* init) {
    if (!init) return;
    curLine = init->line;

    /* char buf[N] = "text" */
    if (isArray(t) && t->base && t->base->kind == TY_CHAR && init->kind == N_SCONST) {
        const std::string& b = init->sval;
        for (size_t i = 0; i < b.size(); ++i) {
            Opnd a = base;
            if (offset + (int)i != 0) {
                int d = newTemp(T.ptrTo(T.tyChar()));
                Instr in; in.op = IR_BIN; in.dst = d; in.a = base; in.b = imm(offset + (long long)i);
                in.sop = "+"; in.line = curLine;
                emit(in);
                a = Opnd::r(d);
            }
            Instr st; st.op = IR_STORE; st.sop = "b"; st.a = a;
            st.b = imm((long long)(signed char)b[i]); st.line = curLine;
            emit(st);
        }
        return;   /* the terminating NUL is already there from memzero */
    }

    if (init->kind == N_INIT_LIST) {
        if (isArray(t)) {
            int es = typeSize(t->base);
            for (size_t i = 0; i < init->kids.size(); ++i)
                initLocalAt(base, offset + (int)i * es, t->base, init->kids[i]);
        } else if (isAggregate(t)) {
            for (size_t i = 0; i < init->kids.size() && t->tag && i < t->tag->members.size(); ++i)
                initLocalAt(base, offset + t->tag->members[i].offset,
                            t->tag->members[i].type, init->kids[i]);
        } else if (!init->kids.empty()) {
            initLocalAt(base, offset, t, init->kids[0]);
        }
        return;
    }

    /* a scalar element, or a whole struct copied from another struct */
    if (isAggregate(t)) {
        Opnd dst = base;
        if (offset) {
            int d = newTemp(T.ptrTo(t));
            Instr in; in.op = IR_BIN; in.dst = d; in.a = base; in.b = imm(offset);
            in.sop = "+"; in.line = curLine;
            emit(in);
            dst = Opnd::r(d);
        }
        Opnd src = addrOf(init);
        Instr mc; mc.op = IR_BLKCOPY; mc.a = dst; mc.b = src;
        mc.n = typeSize(t); mc.align = typeAlign(t); mc.line = curLine;
        emit(mc);
        return;
    }

    Opnd v = rvalue(init);
    v = convert(v, init->type, t);
    Opnd a = base;
    if (offset) {
        int d = newTemp(T.ptrTo(t));
        Instr in; in.op = IR_BIN; in.dst = d; in.a = base; in.b = imm(offset);
        in.sop = "+"; in.line = curLine;
        emit(in);
        a = Opnd::r(d);
    }
    Instr st; st.op = IR_STORE; st.sop = widthSuffix(t);
    st.a = a; st.b = v; st.line = curLine;
    emit(st);
}

/* Generates IR for one statement.  Loops and switch push break/continue
   targets; a switch evaluates its expression once, dispatches with a chain
   of equality compares (one `if' per case, then a jump to default or the
   end), and emits the body in source order so fall-through is preserved. */
void IrGen::stmt(Node* s) {
    if (!s) return;
    curLine = s->line;
    switch (s->kind) {
    case N_COMPOUND: block(s); break;
    case N_EMPTY: break;
    case N_DECL: localDecl(s); break;
    case N_EXPRSTMT: if (s->kid(0)) rvalue(s->kid(0)); break;

    case N_IF: {
        std::string lthen = newLabel(), lelse = newLabel();
        bool hasElse = s->kid(2) != 0;
        cond(s->kid(0), lthen, lelse, true);
        emitLabel(lthen);
        stmt(s->kid(1));
        if (hasElse) {
            std::string lend = newLabel();
            { Instr g; g.op = IR_GOTO; g.label = lend; g.line = curLine; emit(g); }
            emitLabel(lelse);
            stmt(s->kid(2));
            emitLabel(lend);
        } else {
            emitLabel(lelse);
        }
        break;
    }

    case N_WHILE: {
        std::string lcond = newLabel(), lbody = newLabel(), lbrk = newLabel();
        emitLabel(lcond);
        cond(s->kid(0), lbody, lbrk, true);
        emitLabel(lbody);
        breakStack.push_back(lbrk);
        contStack.push_back(lcond);
        stmt(s->kid(1));
        contStack.pop_back();
        breakStack.pop_back();
        { Instr g; g.op = IR_GOTO; g.label = lcond; g.line = curLine; emit(g); }
        emitLabel(lbrk);
        break;
    }

    case N_UNTIL: {
        /* until (c) S  ==  while (!c) S : a PRE-check loop */
        std::string lcond = newLabel(), lbody = newLabel(), lbrk = newLabel();
        emitLabel(lcond);
        cond(s->kid(0), lbrk, lbody, false);     /* if c goto break; else fall into body */
        emitLabel(lbody);
        breakStack.push_back(lbrk);
        contStack.push_back(lcond);
        stmt(s->kid(1));
        contStack.pop_back();
        breakStack.pop_back();
        { Instr g; g.op = IR_GOTO; g.label = lcond; g.line = curLine; emit(g); }
        emitLabel(lbrk);
        break;
    }

    case N_DO: {
        std::string lbody = newLabel(), lcont = newLabel(), lbrk = newLabel();
        emitLabel(lbody);
        breakStack.push_back(lbrk);
        contStack.push_back(lcont);
        stmt(s->kid(0));
        contStack.pop_back();
        breakStack.pop_back();
        emitLabel(lcont);
        cond(s->kid(1), lbody, lbrk, false);     /* continue lands on the test */
        emitLabel(lbrk);
        break;
    }

    case N_FOR: {
        if (s->kid(0)) { if (s->kid(0)->kind == N_DECL) localDecl(s->kid(0)); else stmt(s->kid(0)); }
        std::string lcond = newLabel(), lbody = newLabel(), lcont = newLabel(), lbrk = newLabel();
        emitLabel(lcond);
        if (s->kid(1)) cond(s->kid(1), lbody, lbrk, true);
        emitLabel(lbody);
        breakStack.push_back(lbrk);
        contStack.push_back(lcont);     /* continue goes to the increment */
        stmt(s->kid(3));
        contStack.pop_back();
        breakStack.pop_back();
        emitLabel(lcont);
        if (s->kid(2)) rvalue(s->kid(2));
        { Instr g; g.op = IR_GOTO; g.label = lcond; g.line = curLine; emit(g); }
        emitLabel(lbrk);
        break;
    }

    case N_SWITCH: {
        /* The controlling expression is evaluated exactly once, then a chain
           of equality comparisons dispatches to the matching case. */
        Opnd v = rvalue(s->kid(0));
        int vr = toReg(v, s->kid(0)->type);
        std::string lbrk = newLabel();
        std::map<Node*, std::string> labels;
        std::string ldefault;
        for (size_t i = 0; i < s->extra.size(); ++i) {
            Node* c = s->extra[i];
            labels[c] = newLabel();
            if (c->kind == N_DEFAULT) ldefault = labels[c];
        }
        for (size_t i = 0; i < s->extra.size(); ++i) {
            Node* c = s->extra[i];
            if (c->kind != N_CASE) continue;
            int t = newTemp(T.tyInt());
            Instr cmp; cmp.op = IR_BIN; cmp.dst = t; cmp.a = Opnd::r(vr);
            cmp.b = imm(c->ival); cmp.sop = "=="; cmp.line = c->line;
            emit(cmp);
            Instr br; br.op = IR_IF; br.a = Opnd::r(t); br.label = labels[c]; br.line = c->line;
            emit(br);
        }
        { Instr g; g.op = IR_GOTO; g.label = ldefault.empty() ? lbrk : ldefault; g.line = curLine;
          emit(g); }
        breakStack.push_back(lbrk);
        caseLabels.push_back(labels);
        stmt(s->kid(1));
        caseLabels.pop_back();
        breakStack.pop_back();
        emitLabel(lbrk);
        break;
    }

    case N_CASE: case N_DEFAULT: {
        if (!caseLabels.empty()) {
            std::map<Node*,std::string>& m = caseLabels.back();
            std::map<Node*,std::string>::iterator it = m.find(s);
            if (it != m.end()) emitLabel(it->second);
        }
        stmt(s->kid(s->kind == N_CASE ? 1 : 0));
        break;
    }

    case N_LABEL: {
        std::map<std::string,std::string>::iterator it = gotoLabels.find(s->sval);
        if (it == gotoLabels.end()) { gotoLabels[s->sval] = newLabel(); it = gotoLabels.find(s->sval); }
        emitLabel(it->second);
        stmt(s->kid(0));
        break;
    }

    case N_GOTO: {
        std::map<std::string,std::string>::iterator it = gotoLabels.find(s->sval);
        if (it == gotoLabels.end()) { gotoLabels[s->sval] = newLabel(); it = gotoLabels.find(s->sval); }
        Instr g; g.op = IR_GOTO; g.label = it->second; g.line = curLine;
        emit(g);
        break;
    }

    case N_BREAK:
        if (!breakStack.empty()) {
            Instr g; g.op = IR_GOTO; g.label = breakStack.back(); g.line = curLine; emit(g);
        }
        break;

    case N_CONTINUE:
        if (!contStack.empty()) {
            Instr g; g.op = IR_GOTO; g.label = contStack.back(); g.line = curLine; emit(g);
        }
        break;

    case N_RETURN: {
        Instr r; r.op = IR_RETURN; r.line = curLine;
        if (s->kid(0)) {
            if (isAggregate(curRetType) && sretReg >= 0) {
                /* Copy the result into the caller's storage, then hand that
                   same pointer back so the caller need not remember it. */
                Opnd src = addrOf(s->kid(0));
                Instr cp; cp.op = IR_BLKCOPY; cp.a = Opnd::r(sretReg); cp.b = src;
                cp.n = typeSize(curRetType); cp.align = typeAlign(curRetType);
                cp.line = curLine;
                emit(cp);
                r.a = Opnd::r(sretReg);
            } else {
                Opnd v = rvalue(s->kid(0));
                r.a = convert(v, s->kid(0)->type, curRetType);
            }
        }
        emit(r);
        break;
    }

    default:
        rvalue(s);
        break;
    }
}

/* ================= functions ================= */

/* Generates one function: its parameter list (with the hidden sret
   pointer first for a struct result and by-value struct copies), its frame
   slots and promoted register locals, the body, and a final return when
   control can fall off the end.  Unreferenced labels are dropped and the
   frame size is recomputed after temporaries were added. */
void IrGen::genFunc(FuncCtx* ctx) {
    M->funcs.push_back(IrFunc());
    F = &M->funcs.back();
    symReg.clear();
    gotoLabels.clear();
    breakStack.clear();
    contStack.clear();
    caseLabels.clear();

    Sym* s = ctx->sym;
    F->name = s->name;
    F->retTag = irTypeTag(s->type->base);
    F->retCType = typeName(s->type->base);
    F->frameSize = ctx->frameSize;
    curRetType = s->type->base;
    F->line = s->line;
    tmpSlots = 0;

    /* A function that returns a struct or union by value takes a hidden extra
       first parameter: a pointer to storage the caller owns.  It is declared
       before the source parameters so that it is parameter 0, which is what
       the caller's first `param ... sret' matches. */
    sretReg = -1;
    if (isAggregate(curRetType)) {
        Type* rp = T.ptrTo(curRetType);
        F->sret     = true;
        F->retSize  = typeSize(curRetType);
        F->retAlign = typeAlign(curRetType);
        sretReg = newNamedReg("sret.ptr", rp);
        ParamInfo pi;
        pi.name  = "sret.ptr";
        pi.ctype = typeName(rp);
        pi.tag   = "ptr";
        pi.size  = typeSize(rp);
        pi.align = typeAlign(rp);
        pi.reg   = sretReg;
        pi.sret  = true;
        F->params.push_back(pi);
    }

    /* parameters, in declaration order */
    for (size_t i = 0; i < ctx->order.size(); ++i) {
        Sym* p = ctx->order[i];
        if (p->kind != SK_PARAM) continue;
        ParamInfo pi;
        pi.name = p->uniq;
        pi.ctype = typeName(p->type);
        pi.tag = irTypeTag(p->type);
        pi.size = typeSize(p->type);
        pi.align = typeAlign(p->type);
        pi.inSlot = p->inMemory;
        pi.slotOffset = p->offset;
        if (isAggregate(p->type)) {
            /* By value: the caller hands over an address, in a register of its
               own, and the prologue copies the object into this parameter's
               frame slot.  The callee therefore owns its copy and cannot write
               through to the caller's variable. */
            pi.byVal = true;
            pi.reg   = newNamedReg(p->uniq + ".ptr", T.ptrTo(p->type));
        } else {
            pi.reg = p->inMemory ? -1 : regOf(p);
        }
        F->params.push_back(pi);
    }
    /* frame slots */
    for (size_t i = 0; i < ctx->order.size(); ++i) {
        Sym* v = ctx->order[i];
        if (v->kind != SK_VAR && v->kind != SK_PARAM) continue;
        if (!v->inMemory) continue;
        Slot sl;
        sl.name = v->uniq;
        sl.ctype = typeName(v->type);
        sl.tag = irTypeTag(v->type);
        sl.size = typeSize(v->type);
        sl.align = typeAlign(v->type);
        sl.offset = v->offset;
        F->slots.push_back(sl);
    }
    /* registers for the promoted locals, allocated in declaration order so the
       IR reads in the same order as the source */
    for (size_t i = 0; i < ctx->order.size(); ++i) {
        Sym* v = ctx->order[i];
        if ((v->kind != SK_VAR && v->kind != SK_PARAM) || v->inMemory) continue;
        regOf(v);
    }

    curLine = s->line;
    stmt(ctx->body);

    /* Every function ends in a return, even when the source falls off the end. */
    bool endsWithReturn = !F->code.empty() && F->code.back().op == IR_RETURN;
    if (!endsWithReturn) {
        Instr r; r.op = IR_RETURN; r.line = 0;
        if (F->sret)                     r.a = Opnd::r(sretReg);
        else if (!isVoid(s->type->base)) r.a = imm(0);
        emit(r);
    }

    /* drop labels that nothing jumps to, to keep the IR readable */
    std::set<std::string> used;
    for (size_t i = 0; i < F->code.size(); ++i) {
        const Instr& in = F->code[i];
        if (in.op == IR_GOTO || in.op == IR_IF || in.op == IR_IFFALSE) used.insert(in.label);
    }
    std::vector<Instr> kept;
    kept.reserve(F->code.size());
    for (size_t i = 0; i < F->code.size(); ++i) {
        if (F->code[i].op == IR_LABEL && !used.count(F->code[i].label)) continue;
        kept.push_back(F->code[i]);
    }
    F->code.swap(kept);
    /* Stage 4 fix: newTempSlot grows the frame after sema rounded it, so a
       function whose last temporary slot ends off an 8-byte boundary used to
       report e.g. `frame 252', contradicting IR-DESIGN.md ("already rounded up
       to a multiple of 8").  Round again once every slot exists. */
    F->frameSize = (F->frameSize + 7) / 8 * 8;
    F = 0;
}

/* ================= the data section ================= */

void IrGen::padTo(DataObj& d, int target, int& pos) {
    if (target > pos) {
        DataObj::Piece p; p.width = target - pos; p.value = 0; p.zero = true;
        d.init.push_back(p);
        pos = target;
    }
}

/* Appends the static initializer `init' for an object of type t, at byte
   offset `at' within global d, as data pieces; `pos' is how far d has been
   filled so far and gaps are padded with zeros.  Address constants
   (&g, an array name, &a[i], &s.m) become init.addr pieces with an offset. */
void IrGen::emitInitData(DataObj& d, Type* t, Node* init, int at, int& pos) {
    if (!init) return;

    if (isArray(t) && t->base && t->base->kind == TY_CHAR && init->kind == N_SCONST) {
        padTo(d, at, pos);
        const std::string& b = init->sval;
        for (size_t i = 0; i < b.size(); ++i) {
            DataObj::Piece p; p.width = 1; p.value = (long long)(signed char)b[i]; p.zero = false;
            d.init.push_back(p);
            ++pos;
        }
        return;
    }

    if (init->kind == N_INIT_LIST) {
        if (isArray(t)) {
            int es = typeSize(t->base);
            for (size_t i = 0; i < init->kids.size(); ++i)
                emitInitData(d, t->base, init->kids[i], at + (int)i * es, pos);
        } else if (isAggregate(t) && t->tag) {
            for (size_t i = 0; i < init->kids.size() && i < t->tag->members.size(); ++i)
                emitInitData(d, t->tag->members[i].type, init->kids[i],
                             at + t->tag->members[i].offset, pos);
        } else if (!init->kids.empty()) {
            emitInitData(d, t, init->kids[0], at, pos);
        }
        return;
    }

    padTo(d, at, pos);
    int w = typeSize(t);

    if (isFloat(t)) {
        DataObj::Piece p;
        p.width = w; p.isFloat = true;
        /* An integer constant initializer converts here, at translation time:
           `double x = 3;` stores 3.0, not the bit pattern of the integer 3. */
        double v = init->hasFConst() ? init->fvalue() : 0.0;
        p.fval = (t->kind == TY_FLOAT) ? (double)(float)v : v;
        d.init.push_back(p);
        pos += w;
        return;
    }

    DataObj::Piece p; p.width = (w == 1 ? 1 : 4); p.value = 0; p.zero = false;

    /* A function's address.  `init.faddr' rather than `init.addr' because a
       code address and a data address need not come from the same section, and
       the MIPS stage emits them differently. */
    Node* fn = 0;
    if (init->kind == N_ID && init->sym && init->sym->kind == SK_FUNC) fn = init;
    else if (init->kind == N_ADDR && init->kid(0) && init->kid(0)->kind == N_ID &&
             init->kid(0)->sym && init->kid(0)->sym->kind == SK_FUNC) fn = init->kid(0);

    if (fn) {
        p.sym = fn->sym->name;
        p.isFunc = true;
    } else if (init->kind == N_SCONST) {
        p.sym = init->aux;                       /* char *msg = "..."; */
    } else if (addressConstant(init, &p.sym, &p.symOff)) {
        /* int *q = &g;  int *r = &a[2];  char *s = buf; ... */
    } else if (init->isConst) {
        p.value = (w == 1) ? (long long)(signed char)init->constVal : (long long)(int)init->constVal;
    } else {
        /* semantic analysis has already reported this */
        p.value = 0;
    }
    d.init.push_back(p);
    pos += p.width;
}

void IrGen::genGlobal(Sym* s, Node* init, AnalysisResult& ar) {
    (void)ar;
    DataObj d;
    d.name = s->uniq;
    d.ctype = typeName(s->type);
    d.tag = irTypeTag(s->type);
    d.size = typeSize(s->type);
    d.align = typeAlign(s->type);
    if (d.size == 0) d.size = 4;
    int pos = 0;
    if (init) emitInitData(d, s->type, init, 0, pos);
    padTo(d, d.size, pos);        /* C zero-initialises the rest of a global */
    M->data.push_back(d);
}

/* ================= driver ================= */

/* The IR generator's entry point: fills `out' with the string literals,
   the globals and their static initializers, the extern declarations the
   program uses, and one IrFunc per function definition. */
void IrGen::run(Node* program, AnalysisResult& ar, IrModule& out) {
    M = &out;

    for (size_t i = 0; i < ar.strings.size(); ++i) {
        DataObj d;
        d.name = ar.strings[i].first;
        d.isString = true;
        d.bytes = ar.strings[i].second;
        d.size = (int)d.bytes.size() + 1;
        d.align = 1;
        d.ctype = "char []";
        d.tag = "str";
        M->data.push_back(d);
    }
    for (size_t i = 0; i < ar.globals.size(); ++i) {
        Sym* g = ar.globals[i];
        std::map<Sym*,Node*>::iterator it = ar.globalInit.find(g);
        genGlobal(g, it == ar.globalInit.end() ? 0 : it->second, ar);
    }
    for (size_t i = 0; i < ar.externsUsed.size(); ++i) {
        Sym* e = ar.externsUsed[i];
        ExternFunc ef;
        ef.name = e->name;
        ef.retTag = irTypeTag(e->type->base);
        ef.nparams = (int)e->type->params.size();
        ef.variadic = e->type->variadic;
        M->externs.push_back(ef);
    }
    for (size_t i = 0; i < ar.funcs.size(); ++i) genFunc(ar.funcs[i]);
    (void)program;
}
