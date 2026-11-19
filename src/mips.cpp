/* mips.cpp -- lowering of the IR to SPIM assembly.  See docs/MIPS-DESIGN.md.
 *
 * Summary of the conventions implemented here (the design document has the
 * reasons):
 *   - $fp = the caller's $sp at entry.  0..15($fp) is the home area for
 *     $a0-$a3, stack arguments start at 16($fp); -4($fp) holds $ra, -8($fp)
 *     the caller's $fp; then the callee-saved registers this function uses
 *     (-O1 only), the IR locals, the IR registers' stack homes, and the
 *     outgoing-argument area at 0($sp).  The frame size is a multiple of 8 and
 *     every caller's $sp is 8-byte aligned at a call.
 *   - Arguments are laid out like a struct (4-byte words, a double 8-aligned);
 *     the first 16 bytes travel in $a0-$a3, the rest at 16($sp) onwards of the
 *     caller.  Struct arguments are passed as the caller's address (the IR has
 *     the callee copy them); results come back in $v0 (int, pointer, sret
 *     address) or $f0/$f0:$f1 (float/double).
 *   - Callee-saved: $s0-$s7, $fp, $ra, $f20-$f31.  Scratch: $t0-$t2 operands,
 *     $t3-$t6 block copies, $t7 big-offset addresses, $t9 indirect calls,
 *     $f4/$f6/$f8 floating operands.
 */
#include "mips.h"

#include <algorithm>
#include <cctype>
#include <cmath>
#include <cstdint>
#include <cstdio>
#include <cstring>
#include <map>
#include <set>
#include <sstream>
#include <vector>

namespace {

const char* const kSimulatorLine =
    "SPIM Version 8.0 of January 8, 2010 (Debian/Ubuntu package spim 8.0+dfsg-7)";

bool fits16(long long v) { return v >= -32768 && v <= 32767; }
bool fitsU16(long long v) { return v >= 0 && v <= 65535; }
int  i32(long long v) { return (int)(int32_t)(uint32_t)(unsigned long long)v; }
int  alignUp(int v, int a) { return (v + a - 1) / a * a; }
std::string num(long long v) { std::ostringstream o; o << v; return o.str(); }

/* Register class of an IR register or parameter, from its type tag. */
enum RClass { RC_INT, RC_FLOAT, RC_DOUBLE };
RClass classOfTag(const std::string& tag) {
    if (tag == "float")  return RC_FLOAT;
    if (tag == "double") return RC_DOUBLE;
    return RC_INT;
}

/* ------------------------------------------------------------------------- */
/* -O1 register allocation: liveness over basic blocks, one live interval per
   IR register, linear scan into the callee-saved registers. */

struct Interval { int reg; int start; int end; };

std::vector<int> usesOf(const Instr& in) {
    std::vector<int> u;
    if (in.a.kind == Opnd::REG) u.push_back(in.a.reg);
    if (in.b.kind == Opnd::REG) u.push_back(in.b.reg);
    return u;
}

/* Computes, for every IR register of `f`, the smallest range of instruction
   positions that covers every point where it is live, defined or used.  Uses a
   standard backward dataflow over basic blocks; parameters held in registers
   are live from position 0, where the prologue defines them. */
std::vector<Interval> liveIntervals(const IrFunc& f) {
    const std::vector<Instr>& c = f.code;
    int n = (int)c.size(), R = (int)f.regs.size();
    std::map<std::string, int> labelAt;
    for (int i = 0; i < n; ++i)
        if (c[i].op == IR_LABEL) labelAt[c[i].label] = i;

    /* blocks: leaders are position 0, labels, and the instruction after a jump */
    std::vector<int> start;
    for (int i = 0; i < n; ++i) {
        bool leader = i == 0 || c[i].op == IR_LABEL ||
            c[i-1].op == IR_GOTO || c[i-1].op == IR_IF || c[i-1].op == IR_IFFALSE ||
            c[i-1].op == IR_RETURN;
        if (leader) start.push_back(i);
    }
    int B = (int)start.size();
    std::vector<int> blockOf(n);
    for (int b = 0; b < B; ++b) {
        int e = b + 1 < B ? start[b+1] : n;
        for (int i = start[b]; i < e; ++i) blockOf[i] = b;
    }
    std::vector<std::vector<int> > succ(B);
    for (int b = 0; b < B; ++b) {
        int last = (b + 1 < B ? start[b+1] : n) - 1;
        const Instr& in = c[last];
        if (in.op == IR_GOTO || in.op == IR_IF || in.op == IR_IFFALSE) {
            std::map<std::string, int>::iterator it = labelAt.find(in.label);
            if (it != labelAt.end()) succ[b].push_back(blockOf[it->second]);
        }
        if (in.op != IR_GOTO && in.op != IR_RETURN && b + 1 < B) succ[b].push_back(b + 1);
    }
    typedef std::vector<bool> Set;
    std::vector<Set> liveIn(B, Set(R, false)), liveOut(B, Set(R, false));
    bool changed = true;
    while (changed) {
        changed = false;
        for (int b = B - 1; b >= 0; --b) {
            Set out(R, false);
            for (size_t s = 0; s < succ[b].size(); ++s) {
                const Set& in = liveIn[succ[b][s]];
                for (int r = 0; r < R; ++r) if (in[r]) out[r] = true;
            }
            Set live = out;
            int e = b + 1 < B ? start[b+1] : n;
            for (int i = e - 1; i >= start[b]; --i) {
                if (c[i].dst >= 0) live[c[i].dst] = false;
                std::vector<int> u = usesOf(c[i]);
                for (size_t k = 0; k < u.size(); ++k) live[u[k]] = true;
            }
            if (out != liveOut[b] || live != liveIn[b]) {
                liveOut[b] = out; liveIn[b] = live; changed = true;
            }
        }
    }
    std::vector<int> lo(R, -1), hi(R, -1);
    auto touch = [&](int r, int p) {
        if (lo[r] < 0 || p < lo[r]) lo[r] = p;
        if (p > hi[r]) hi[r] = p;
    };
    for (int b = 0; b < B; ++b) {
        Set live = liveOut[b];
        int e = b + 1 < B ? start[b+1] : n;
        for (int i = e - 1; i >= start[b]; --i) {
            for (int r = 0; r < R; ++r) if (live[r]) touch(r, i);
            if (c[i].dst >= 0) { touch(c[i].dst, i); live[c[i].dst] = false; }
            std::vector<int> u = usesOf(c[i]);
            for (size_t k = 0; k < u.size(); ++k) { touch(u[k], i); live[u[k]] = true; }
        }
        if (b == 0) for (int r = 0; r < R; ++r) if (live[r]) touch(r, 0);
    }
    for (size_t p = 0; p < f.params.size(); ++p) {
        const ParamInfo& pi = f.params[p];
        if (!pi.inSlot && !pi.byVal && pi.reg >= 0) touch(pi.reg, 0);
    }
    std::vector<Interval> iv;
    for (int r = 0; r < R; ++r)
        if (lo[r] >= 0) { Interval x; x.reg = r; x.start = lo[r]; x.end = hi[r]; iv.push_back(x); }
    return iv;
}

/* Linear scan (Poletto & Sarkar): returns the physical register for each IR
   register, or "" for one that stays in its stack slot.  Integer registers go
   to $s0-$s7, float and double ones to the even registers $f20-$f30.  All of
   these are callee-saved, so a value survives the calls in its interval. */
std::vector<std::string> allocate(const IrFunc& f) {
    std::vector<std::string> phys(f.regs.size());
    std::vector<Interval> iv = liveIntervals(f);
    std::sort(iv.begin(), iv.end(), [](const Interval& a, const Interval& b) {
        return a.start != b.start ? a.start < b.start : a.reg < b.reg; });
    for (int cls = 0; cls < 2; ++cls) {
        std::vector<std::string> pool;
        if (cls == 0) { for (int i = 7; i >= 0; --i) pool.push_back("$s" + num(i)); }
        else          { for (int i = 30; i >= 20; i -= 2) pool.push_back("$f" + num(i)); }
        std::vector<Interval> active;
        for (size_t k = 0; k < iv.size(); ++k) {
            const Interval& cur = iv[k];
            bool fp = classOfTag(f.regs[cur.reg].tag) != RC_INT;
            if (fp != (cls == 1)) continue;
            /* expire */
            for (size_t j = 0; j < active.size();) {
                if (active[j].end < cur.start) {
                    pool.push_back(phys[active[j].reg]);
                    active.erase(active.begin() + j);
                } else ++j;
            }
            if (!pool.empty()) {
                phys[cur.reg] = pool.back(); pool.pop_back();
                active.push_back(cur);
            } else {
                size_t far = 0;
                for (size_t j = 1; j < active.size(); ++j)
                    if (active[j].end > active[far].end) far = j;
                if (!active.empty() && active[far].end > cur.end) {
                    phys[cur.reg] = phys[active[far].reg];
                    phys[active[far].reg] = "";
                    active.erase(active.begin() + far);
                    active.push_back(cur);
                }
            }
        }
    }
    return phys;
}

/* ------------------------------------------------------------------------- */

class Emitter {
public:
    Emitter(std::ostream& os, const IrModule& m, const MipsOptions& o)
        : os(os), M(m), opt(o) {
        for (size_t i = 0; i < m.funcs.size(); ++i) defined.insert(m.funcs[i].name);
    }
    bool run(std::string* err);

private:
    std::ostream&      os;
    const IrModule&    M;
    const MipsOptions& opt;
    std::set<std::string> defined;
    std::string error;

    /* per function */
    const IrFunc*            F = 0;
    std::string              fsym;
    std::vector<int>         home;       /* $fp offset of each IR register's slot */
    std::vector<std::string> phys;       /* allocated register, or ""            */
    std::map<std::string,int> slotOfs;   /* $fp offset of each frame slot        */
    int  frameSize = 0, outArea = 0, localBase = 0, saveArea = 0;
    std::vector<std::pair<std::string,int> > saved;   /* register, $fp offset */
    int  internal = 0;
    int  argBytes = 0;                   /* outgoing bytes of the pending call   */

    /* `init.addr @sym+N' words: spim's .word takes a bare symbol only, so
       these are assembled as 0 and stored by main before its first statement
       (MIPS-DESIGN.md section 7). */
    struct AddrFix { std::string holder; int at; std::string target; long long off; };
    std::vector<AddrFix> addrFixes;
    void storeAddrFixes();

    /* naming (MIPS-DESIGN.md section 6) */
    std::string funcSym(const std::string& n) const {
        if (opt.runtimeMode) return "__rt_" + n;
        return defined.count(n) ? "fn_" + n : "__rt_" + n;
    }
    std::string dataSym(const std::string& n) const {
        if (opt.runtimeMode) return n[0] == '.' ? "__rtd" + n : "__rtg_" + n;
        return n[0] == '.' ? "d" + n : "gv_" + n;
    }
    std::string label(const std::string& irLabel) const { return fsym + irLabel; }
    std::string newInternal() { return fsym + ".c" + num(internal++); }

    void ins(const std::string& s) { os << "\t" << s << "\n"; }
    void ins(const std::string& op, const std::string& args) {
        std::string pad = op.size() < 8 ? std::string(8 - op.size(), ' ') : " ";
        os << "\t" << op << pad << args << "\n";
    }
    void putLabel(const std::string& l) { os << l << ":\n"; }

    void mem(const std::string& op, const std::string& reg, long long off,
             const std::string& base);
    void addrOf(const std::string& dst, long long off, const std::string& base);
    void li(const std::string& reg, long long v);

    RClass rc(int r) const { return classOfTag(F->regs[r].tag); }
    std::string getI(const Opnd& o, const char* scratch);
    std::string getF(int r, const char* scratch);
    std::string dstI(int r, const char* scratch) {
        return phys[r].empty() ? std::string(scratch) : phys[r];
    }
    std::string dstF(int r, const char* scratch) { return dstI(r, scratch); }
    void putI(int r, const std::string& v);
    void putF(int r, const std::string& v);

    void layoutFrame();
    void prologue();
    void epilogue();
    void function(const IrFunc& f);
    void instr(const Instr& in, bool last);
    void binary(const Instr& in);
    void intBinary(const Instr& in);
    void divide(const Instr& in);
    void floatBinary(const Instr& in);
    void unary(const Instr& in);
    void convert(const Instr& in);
    void param(const Instr& in);
    void call(const Instr& in);
    void ret(const Instr& in, bool last);
    void blockCopy(const std::string& dst, const std::string& src, long long n, long long align);
    void blockZero(const std::string& dst, long long n);

    void header();
    void data();
    void dataObject(const DataObj& d);
    void floatPiece(const DataObj::Piece& p);
};

/* ---- addressing ---- */

/* `op reg, off(base)`, computing the address in $t7 when off does not fit the
   16-bit signed displacement (MIPS-DESIGN.md section 3.4). */
void Emitter::mem(const std::string& op, const std::string& reg, long long off,
                  const std::string& base) {
    if (fits16(off)) { ins(op, reg + ", " + num(off) + "(" + base + ")"); return; }
    ins("li", "$t7, " + num(off));
    ins("addu", "$t7, $t7, " + base);
    ins(op, reg + ", 0($t7)");
}

void Emitter::addrOf(const std::string& dst, long long off, const std::string& base) {
    if (fits16(off)) { ins("addiu", dst + ", " + base + ", " + num(off)); return; }
    ins("li", "$t7, " + num(off));
    ins("addu", dst + ", $t7, " + base);
}

void Emitter::li(const std::string& reg, long long v) { ins("li", reg + ", " + num(i32(v))); }

/* ---- operand access ---- */

std::string Emitter::getI(const Opnd& o, const char* scratch) {
    if (o.kind == Opnd::IMM) {
        if (i32(o.imm) == 0) return "$zero";
        li(scratch, o.imm);
        return scratch;
    }
    if (!phys[o.reg].empty()) return phys[o.reg];
    if (rc(o.reg) != RC_INT) {          /* not produced by this front end */
        error = "integer use of floating register in " + F->name;
        return scratch;
    }
    mem("lw", scratch, home[o.reg], "$fp");
    return scratch;
}

std::string Emitter::getF(int r, const char* scratch) {
    if (!phys[r].empty()) return phys[r];
    mem(rc(r) == RC_DOUBLE ? "ldc1" : "lwc1", scratch, home[r], "$fp");
    return scratch;
}

void Emitter::putI(int r, const std::string& v) {
    if (phys[r].empty()) mem("sw", v, home[r], "$fp");
    else if (phys[r] != v) ins("move", phys[r] + ", " + v);
}

void Emitter::putF(int r, const std::string& v) {
    bool d = rc(r) == RC_DOUBLE;
    if (phys[r].empty()) mem(d ? "sdc1" : "swc1", v, home[r], "$fp");
    else if (phys[r] != v) ins(d ? "mov.d" : "mov.s", phys[r] + ", " + v);
}

/* ---- frame ---- */

/* Assigns every frame slot, saved register and IR register its $fp offset and
   computes the frame size (MIPS-DESIGN.md section 3). */
void Emitter::layoutFrame() {
    const IrFunc& f = *F;
    phys.assign(f.regs.size(), "");
    if (opt.optLevel >= 1) phys = allocate(f);

    std::set<std::string> used(phys.begin(), phys.end());
    used.erase("");
    saved.clear();
    int off = -8;
    for (int i = 20; i <= 30; i += 2)                 /* doubles first: 8-aligned */
        if (used.count("$f" + num(i))) { off -= 8; saved.push_back(std::make_pair("$f" + num(i), off)); }
    for (int i = 0; i <= 7; ++i)
        if (used.count("$s" + num(i))) { off -= 4; saved.push_back(std::make_pair("$s" + num(i), off)); }
    off = -alignUp(-off, 8);
    saveArea = -off - 8;

    int F8 = alignUp(f.frameSize, 8);
    localBase = off - F8;                              /* 8-aligned */
    slotOfs.clear();
    for (size_t i = 0; i < f.slots.size(); ++i)
        slotOfs[f.slots[i].name] = localBase + f.slots[i].offset;

    int cur = localBase;
    home.assign(f.regs.size(), 0);
    for (size_t r = 0; r < f.regs.size(); ++r) {
        if (!phys[r].empty()) continue;
        if (rc((int)r) == RC_DOUBLE) { cur -= 8; cur = -alignUp(-cur, 8); }
        else cur -= 4;
        home[r] = cur;
    }
    cur = -alignUp(-cur, 8);

    /* outgoing-argument area: the largest call, at least the 16-byte home
       area every callee may spill $a0-$a3 into */
    outArea = 16;
    int bytes = 0;
    for (size_t i = 0; i < f.code.size(); ++i) {
        const Instr& in = f.code[i];
        if (in.op == IR_PARAM) {
            if (in.tag == "double") bytes = alignUp(bytes, 8) + 8; else bytes += 4;
        } else if (in.op == IR_CALL) {
            outArea = std::max(outArea, alignUp(bytes, 8));
            bytes = 0;
        }
    }
    frameSize = -cur + outArea;
}

/* Byte offset of each parameter in the argument area, laid out like a struct
   of 4-byte words with doubles 8-aligned; a struct travels as its address. */
std::vector<int> paramOffsets(const IrFunc& f, int* total) {
    std::vector<int> o;
    int off = 0;
    for (size_t i = 0; i < f.params.size(); ++i) {
        bool d = !f.params[i].byVal && f.params[i].tag == "double";
        if (d) off = alignUp(off, 8);
        o.push_back(off);
        off += d ? 8 : 4;
    }
    if (total) *total = off;
    return o;
}

/* At main's entry, before its prologue (only $t0, $t1 and $t7 are used, so
   argc/argv in $a0/$a1 survive): store each `&global + N' initializer, once
   -- a flag word keeps a recursive call of main from redoing it. */
void Emitter::storeAddrFixes() {
    std::string done = fsym + ".fixdone";
    os << "\t# store the address constants with an offset (data words above)\n";
    ins("la", "$t0, " + fsym + ".fixed");
    ins("lw", "$t1, 0($t0)");
    ins("bne", "$t1, $zero, " + done);
    ins("li", "$t1, 1");
    ins("sw", "$t1, 0($t0)");
    for (size_t i = 0; i < addrFixes.size(); ++i) {
        const AddrFix& fx = addrFixes[i];
        ins("la", "$t0, " + fx.target);
        addrOf("$t0", fx.off, "$t0");
        ins("la", "$t1, " + fx.holder);
        mem("sw", "$t0", fx.at, "$t1");
    }
    putLabel(done);
}

/* Saves $ra/$fp, allocates the frame, saves the callee-saved registers the
   allocator used, spills $a0-$a3 to the home area and moves every parameter to
   where the body expects it: its register, its frame slot, or -- for a struct
   passed by value -- a copy of the caller's object in its frame slot. */
void Emitter::prologue() {
    ins("sw", "$ra, -4($sp)");
    ins("sw", "$fp, -8($sp)");
    ins("move", "$fp, $sp");
    if (fits16(-frameSize)) ins("addiu", "$sp, $sp, " + num(-frameSize));
    else { ins("li", "$t7, " + num(frameSize)); ins("subu", "$sp, $sp, $t7"); }
    for (size_t i = 0; i < saved.size(); ++i)
        mem(saved[i].first[1] == 'f' ? "sdc1" : "sw", saved[i].first, saved[i].second, "$fp");

    int total = 0;
    std::vector<int> po = paramOffsets(*F, &total);
    for (int w = 0; w < 4 && w * 4 < total; ++w)
        ins("sw", "$a" + num(w) + ", " + num(4 * w) + "($fp)");

    for (size_t i = 0; i < F->params.size(); ++i) {
        const ParamInfo& p = F->params[i];
        int in = po[i];
        os << "\t# param " << p.name << " : " << p.tag << " at " << in << "($fp)";
        if (p.byVal) os << ", copied into slot " << p.name;
        else if (p.inSlot) os << " -> slot " << p.name;
        os << "\n";
        if (p.byVal) {
            ins("lw", "$t1, " + num(in) + "($fp)");
            addrOf("$t0", localBase + p.slotOffset, "$fp");
            blockCopy("$t0", "$t1", p.size, p.align);
        } else if (p.inSlot) {
            int dst = localBase + p.slotOffset;
            if (p.tag == "double") {
                ins("lw", "$t0, " + num(in) + "($fp)");
                ins("lw", "$t1, " + num(in + 4) + "($fp)");
                mem("sw", "$t0", dst, "$fp");
                mem("sw", "$t1", dst + 4, "$fp");
            } else {
                ins("lw", "$t0, " + num(in) + "($fp)");
                mem(p.size == 1 ? "sb" : "sw", "$t0", dst, "$fp");
            }
        } else if (p.reg >= 0) {
            RClass c = rc(p.reg);
            if (c == RC_INT) {
                std::string d = dstI(p.reg, "$t0");
                ins("lw", d + ", " + num(in) + "($fp)");
                putI(p.reg, d);
            } else {
                std::string d = dstF(p.reg, "$f4");
                ins(c == RC_DOUBLE ? "ldc1" : "lwc1", d + ", " + num(in) + "($fp)");
                putF(p.reg, d);
            }
        }
    }
}

void Emitter::epilogue() {
    putLabel(fsym + ".ret");
    for (size_t i = 0; i < saved.size(); ++i)
        mem(saved[i].first[1] == 'f' ? "ldc1" : "lw", saved[i].first, saved[i].second, "$fp");
    ins("move", "$sp, $fp");
    ins("lw", "$ra, -4($sp)");
    ins("lw", "$fp, -8($sp)");
    ins("jr", "$ra");
}

/* One function: the frame-layout comment, the prologue, every IR instruction
   preceded by a comment with its IR text, and the shared epilogue. */
void Emitter::function(const IrFunc& f) {
    F = &f;
    fsym = funcSym(f.name);
    internal = 0;
    argBytes = 0;
    layoutFrame();

    os << "\n";
    if (opt.runtimeMode) os << "# @unit " << fsym << "\n";
    os << "\t.text\n";
    os << "# ---------------------------------------------------------------\n";
    os << "# function " << f.name << " (line " << f.line << "), returns " << f.retTag
       << (f.sret ? " via sret" : "") << "\n";
    os << "# frame " << frameSize << " bytes ($fp = $sp at entry):\n";
    int total = 0;
    std::vector<int> po = paramOffsets(f, &total);
    for (size_t i = 0; i < f.params.size(); ++i)
        os << "#   " << po[i] << "($fp)\tparam " << f.params[i].name << " (" << f.params[i].tag
           << (po[i] < 16 ? ", arrives in $a" + num(po[i] / 4) : "") << ")\n";
    os << "#   -4($fp)\t$ra\n#   -8($fp)\tcaller's $fp\n";
    for (size_t i = 0; i < saved.size(); ++i)
        os << "#   " << saved[i].second << "($fp)\tsaved " << saved[i].first << "\n";
    for (size_t i = 0; i < f.slots.size(); ++i)
        os << "#   " << slotOfs[f.slots[i].name] << "($fp)\tlocal " << f.slots[i].name
           << " : " << f.slots[i].ctype << " (" << f.slots[i].size << " bytes)\n";
    for (size_t r = 0; r < f.regs.size(); ++r) {
        os << "#   ";
        if (phys[r].empty()) os << home[r] << "($fp)"; else os << phys[r];
        os << "\t%" << f.regs[r].name << " : " << f.regs[r].tag << "\n";
    }
    os << "#   0($sp)\toutgoing arguments (" << outArea << " bytes)\n";
    os << "# ---------------------------------------------------------------\n";
    bool fixes = f.name == "main" && !opt.runtimeMode && !addrFixes.empty();
    if (fixes) os << "\t.data\n" << fsym << ".fixed:\t.word 0\t\t# address constants stored yet?\n\t.text\n";
    os << "\t.globl " << fsym << "\n";
    putLabel(fsym);
    if (fixes) storeAddrFixes();
    prologue();
    for (size_t i = 0; i < f.code.size(); ++i) {
        const Instr& in = f.code[i];
        if (in.op == IR_LABEL) { putLabel(label(in.label)); continue; }
        os << "\t# " << irInstrText(f, in) << "\n";
        instr(in, i + 1 == f.code.size());
    }
    epilogue();
    F = 0;
}

/* ---- instructions (MIPS-DESIGN.md section 5) ---- */

/* Dispatches one IR instruction.  `last` is true for the final instruction of
   the function, so a return there falls into the epilogue without a jump. */
void Emitter::instr(const Instr& in, bool last) {
    switch (in.op) {
    case IR_LABEL: break;
    case IR_COPY: {
        RClass c = rc(in.dst);
        if (c == RC_INT) {
            std::string d = dstI(in.dst, "$t0");
            std::string a = getI(in.a, d.c_str());
            if (a != d) ins("move", d + ", " + a);
            putI(in.dst, d);
        } else {
            if (in.a.kind != Opnd::REG) { error = "floating immediate in copy"; return; }
            std::string a = getF(in.a.reg, "$f4");
            putF(in.dst, a);
        }
        break;
    }
    case IR_BIN:  binary(in); break;
    case IR_UN:   unary(in); break;
    case IR_SEXTB: {
        std::string a = getI(in.a, "$t0"), d = dstI(in.dst, "$t0");
        ins("sll", d + ", " + a + ", 24");
        ins("sra", d + ", " + d + ", 24");
        putI(in.dst, d);
        break;
    }
    case IR_CVT: convert(in); break;
    case IR_ADDR_LOCAL: {
        std::map<std::string,int>::iterator it = slotOfs.find(in.label);
        if (it == slotOfs.end()) { error = "unknown frame slot " + in.label; return; }
        std::string d = dstI(in.dst, "$t0");
        addrOf(d, it->second, "$fp");
        putI(in.dst, d);
        break;
    }
    case IR_ADDR_GLOBAL: case IR_FADDR: {
        std::string d = dstI(in.dst, "$t0");
        ins("la", d + ", " + (in.op == IR_FADDR ? funcSym(in.label) : dataSym(in.label)));
        putI(in.dst, d);
        break;
    }
    case IR_LOAD: {
        std::string a = getI(in.a, "$t0");
        if (in.sop == "w" || in.sop == "b") {
            std::string d = dstI(in.dst, "$t1");
            ins(in.sop == "w" ? "lw" : "lb", d + ", 0(" + a + ")");
            putI(in.dst, d);
        } else {
            std::string d = dstF(in.dst, "$f4");
            ins(in.sop == "d" ? "ldc1" : "lwc1", d + ", 0(" + a + ")");
            putF(in.dst, d);
        }
        break;
    }
    case IR_STORE: {
        std::string a = getI(in.a, "$t0");
        if (in.sop == "w" || in.sop == "b") {
            std::string v = getI(in.b, "$t1");
            ins(in.sop == "w" ? "sw" : "sb", v + ", 0(" + a + ")");
        } else {
            if (in.b.kind != Opnd::REG) { error = "floating immediate in store"; return; }
            std::string v = getF(in.b.reg, "$f4");
            ins(in.sop == "d" ? "sdc1" : "swc1", v + ", 0(" + a + ")");
        }
        break;
    }
    case IR_BLKCOPY: {
        std::string d = getI(in.a, "$t0");
        if (d != "$t0") ins("move", "$t0, " + d);
        std::string s = getI(in.b, "$t1");
        if (s != "$t1") ins("move", "$t1, " + s);
        blockCopy("$t0", "$t1", in.n, in.align);
        break;
    }
    case IR_MEMZERO: {
        std::string d = getI(in.a, "$t0");
        if (d != "$t0") ins("move", "$t0, " + d);
        blockZero("$t0", in.n);
        break;
    }
    case IR_GOTO: ins("b", label(in.label)); break;
    case IR_IF: case IR_IFFALSE: {
        if (in.a.kind == Opnd::IMM) {
            bool taken = (i32(in.a.imm) != 0) == (in.op == IR_IF);
            if (taken) ins("b", label(in.label));
            break;
        }
        std::string a = getI(in.a, "$t0");
        ins(in.op == IR_IF ? "bne" : "beq", a + ", $zero, " + label(in.label));
        break;
    }
    case IR_PARAM:  param(in); break;
    case IR_CALL:   call(in); break;
    case IR_RETURN: ret(in, last); break;
    }
}

void Emitter::binary(const Instr& in) {
    const std::string& s = in.sop;
    if (s.size() > 2 && (s.compare(s.size() - 2, 2, ".s") == 0 || s.compare(s.size() - 2, 2, ".d") == 0))
        floatBinary(in);
    else if (s == "/" || s == "%")
        divide(in);
    else
        intBinary(in);
}

/* Integer arithmetic, bitwise, shift and comparison operators.  An immediate
   right operand uses the I-type form when it fits (addiu, andi, ori, xori,
   slti, sll, sra); comparisons produce 0/1 with slt/sltu (section 5.2). */
void Emitter::intBinary(const Instr& in) {
    const std::string& s = in.sop;
    std::string a = getI(in.a, "$t0");
    std::string d = dstI(in.dst, "$t0");
    bool bi = in.b.kind == Opnd::IMM;
    long long bv = bi ? i32(in.b.imm) : 0;
    auto B = [&]() { return getI(in.b, "$t1"); };

    if (s == "+") {
        if (bi && fits16(bv)) ins("addiu", d + ", " + a + ", " + num(bv));
        else ins("addu", d + ", " + a + ", " + B());
    } else if (s == "-") {
        if (bi && fits16(-bv)) ins("addiu", d + ", " + a + ", " + num(-bv));
        else ins("subu", d + ", " + a + ", " + B());
    } else if (s == "*") {
        ins("mul", d + ", " + a + ", " + B());
    } else if (s == "&" || s == "|" || s == "^") {
        const char* rop = s == "&" ? "and" : s == "|" ? "or" : "xor";
        const char* iop = s == "&" ? "andi" : s == "|" ? "ori" : "xori";
        if (bi && fitsU16(bv)) ins(iop, d + ", " + a + ", " + num(bv));
        else ins(rop, d + ", " + a + ", " + B());
    } else if (s == "<<" || s == ">>") {
        if (bi) ins(s == "<<" ? "sll" : "sra", d + ", " + a + ", " + num(bv & 31));
        else ins(s == "<<" ? "sllv" : "srav", d + ", " + a + ", " + B());
    } else if (s == "<") {
        if (bi && fits16(bv)) ins("slti", d + ", " + a + ", " + num(bv));
        else ins("slt", d + ", " + a + ", " + B());
    } else if (s == ">=") {
        if (bi && fits16(bv)) ins("slti", d + ", " + a + ", " + num(bv));
        else ins("slt", d + ", " + a + ", " + B());
        ins("xori", d + ", " + d + ", 1");
    } else if (s == ">") {
        ins("slt", d + ", " + B() + ", " + a);
    } else if (s == "<=") {
        ins("slt", d + ", " + B() + ", " + a);
        ins("xori", d + ", " + d + ", 1");
    } else if (s == "==" || s == "!=") {
        if (bi && fitsU16(bv)) ins("xori", d + ", " + a + ", " + num(bv));
        else ins("xor", d + ", " + a + ", " + B());
        if (s == "==") ins("sltiu", d + ", " + d + ", 1");
        else ins("sltu", d + ", $zero, " + d);
    } else {
        error = "unknown integer operator '" + s + "'";
        return;
    }
    putI(in.dst, d);
}

/* Signed division and remainder with C semantics (section 5.3): a zero
   divisor calls __rt_divzero (message on stderr, exit status 70, as irsim
   does); a divisor of -1 is handled without `div' so INT_MIN / -1 wraps to
   INT_MIN and INT_MIN % -1 is 0, where the MIPS divider leaves 0 in both. */
void Emitter::divide(const Instr& in) {
    bool rem = in.sop == "%";
    std::string a = getI(in.a, "$t0");
    std::string d = dstI(in.dst, "$t0");
    if (in.b.kind == Opnd::IMM) {
        int bv = i32(in.b.imm);
        if (bv == 0) {
            ins("jal", "__rt_divzero");
            ins("move", d + ", $zero");
        } else if (bv == -1) {
            if (rem) ins("move", d + ", $zero");
            else ins("subu", d + ", $zero, " + a);
        } else {
            li("$t1", bv);
            ins("div", a + ", $t1");
            ins(rem ? "mfhi" : "mflo", d);
        }
        putI(in.dst, d);
        return;
    }
    std::string b = getI(in.b, "$t1");
    std::string ok = newInternal(), normal = newInternal(), done = newInternal();
    ins("bne", b + ", $zero, " + ok);
    ins("jal", "__rt_divzero");
    putLabel(ok);
    ins("li", "$t2, -1");
    ins("bne", b + ", $t2, " + normal);
    if (rem) ins("move", d + ", $zero");
    else ins("subu", d + ", $zero, " + a);
    ins("b", done);
    putLabel(normal);
    ins("div", a + ", " + b);
    ins(rem ? "mfhi" : "mflo", d);
    putLabel(done);
    putI(in.dst, d);
}

/* Floating arithmetic (add/sub/mul/div .s/.d) and comparisons.  A comparison
   sets the FPU condition flag with c.eq/c.olt/c.ole -- swapping the operands
   for > and >=, and testing the flag false for != -- and turns it into 0/1
   with bc1t/bc1f (section 5.4).  Every comparison with a NaN is false except
   !=.  c.olt/c.ole are the quiet (non-signalling) forms: c.lt/c.le raise the
   invalid exception on a NaN, which spim reports on stdout, whereas gcc's
   SSE comparisons do not trap. */
void Emitter::floatBinary(const Instr& in) {
    std::string s = in.sop;
    std::string fmt = s.substr(s.size() - 1);
    std::string op = s.substr(0, s.size() - 2);
    if (in.a.kind != Opnd::REG || in.b.kind != Opnd::REG) { error = "floating immediate operand"; return; }
    std::string a = getF(in.a.reg, "$f4");
    std::string b = getF(in.b.reg, "$f6");
    if (op == "+" || op == "-" || op == "*" || op == "/") {
        const char* m = op == "+" ? "add." : op == "-" ? "sub." : op == "*" ? "mul." : "div.";
        std::string d = dstF(in.dst, "$f8");
        ins(m + fmt, d + ", " + a + ", " + b);
        putF(in.dst, d);
        return;
    }
    std::string cmp, x = a, y = b;
    bool onFalse = false;
    if (op == "==") cmp = "c.eq.";
    else if (op == "!=") { cmp = "c.eq."; onFalse = true; }
    else if (op == "<") cmp = "c.olt.";
    else if (op == "<=") cmp = "c.ole.";
    else if (op == ">") { cmp = "c.olt."; std::swap(x, y); }
    else if (op == ">=") { cmp = "c.ole."; std::swap(x, y); }
    else { error = "unknown floating operator '" + s + "'"; return; }
    ins(cmp + fmt, x + ", " + y);
    std::string d = dstI(in.dst, "$t0");
    std::string end = newInternal();
    ins("li", d + ", 1");
    ins(onFalse ? "bc1f" : "bc1t", end);
    ins("li", d + ", 0");
    putLabel(end);
    putI(in.dst, d);
}

void Emitter::unary(const Instr& in) {
    const std::string& s = in.sop;
    if (s == "-.s" || s == "-.d") {
        if (in.a.kind != Opnd::REG) { error = "floating immediate operand"; return; }
        std::string a = getF(in.a.reg, "$f4"), d = dstF(in.dst, "$f4");
        ins(s == "-.s" ? "neg.s" : "neg.d", d + ", " + a);
        putF(in.dst, d);
        return;
    }
    std::string a = getI(in.a, "$t0"), d = dstI(in.dst, "$t0");
    if (s == "-") ins("subu", d + ", $zero, " + a);
    else if (s == "!") ins("sltiu", d + ", " + a + ", 1");
    else if (s == "~") ins("nor", d + ", " + a + ", $zero");
    else { error = "unknown unary operator '" + s + "'"; return; }
    putI(in.dst, d);
}

/* cvt.s.w / cvt.d.w move the integer into the FPU with mtc1 first;
   trunc.w.s / trunc.w.d bring the result back with mfc1 (section 5.5). */
void Emitter::convert(const Instr& in) {
    const std::string& s = in.sop;
    if (s == "cvt.s.w" || s == "cvt.d.w") {
        std::string a = getI(in.a, "$t0");
        ins("mtc1", a + ", $f4");
        std::string d = dstF(in.dst, "$f6");
        ins(s, d + ", $f4");
        putF(in.dst, d);
    } else if (s == "cvt.s.d" || s == "cvt.d.s") {
        if (in.a.kind != Opnd::REG) { error = "floating immediate operand"; return; }
        std::string a = getF(in.a.reg, "$f4");
        std::string d = dstF(in.dst, "$f6");
        ins(s, d + ", " + a);
        putF(in.dst, d);
    } else if (s == "trunc.w.d" || s == "trunc.w.s") {
        if (in.a.kind != Opnd::REG) { error = "floating immediate operand"; return; }
        std::string a = getF(in.a.reg, "$f4");
        ins(s, "$f6, " + a);
        std::string d = dstI(in.dst, "$t0");
        ins("mfc1", d + ", $f6");
        putI(in.dst, d);
    } else {
        error = "unknown conversion '" + s + "'";
    }
}

/* Stores one argument into the outgoing area at its struct-like offset; the
   call that follows loads the first four words into $a0-$a3 (section 4). */
void Emitter::param(const Instr& in) {
    if (in.tag == "double") {
        argBytes = alignUp(argBytes, 8);
        if (in.a.kind != Opnd::REG) { error = "floating immediate argument"; return; }
        std::string v = getF(in.a.reg, "$f4");
        mem("sdc1", v, argBytes, "$sp");
        argBytes += 8;
    } else if (in.tag == "float") {
        if (in.a.kind != Opnd::REG) { error = "floating immediate argument"; return; }
        std::string v = getF(in.a.reg, "$f4");
        mem("swc1", v, argBytes, "$sp");
        argBytes += 4;
    } else {
        std::string v = getI(in.a, "$t0");
        mem("sw", v, argBytes, "$sp");
        argBytes += 4;
    }
}

void Emitter::call(const Instr& in) {
    for (int w = 0; w < 4 && w * 4 < argBytes; ++w)
        ins("lw", "$a" + num(w) + ", " + num(4 * w) + "($sp)");
    argBytes = 0;
    if (in.indirect) {
        std::string t = getI(in.a, "$t9");
        if (t != "$t9") ins("move", "$t9, " + t);
        ins("jalr", "$t9");
    } else {
        ins("jal", funcSym(in.label));
    }
    if (in.dst >= 0) {
        RClass c = rc(in.dst);
        if (c == RC_INT) putI(in.dst, "$v0");
        else putF(in.dst, "$f0");
    }
}

void Emitter::ret(const Instr& in, bool last) {
    if (in.a.kind != Opnd::NONE) {
        RClass c = classOfTag(F->retTag);
        if (F->sret) c = RC_INT;
        if (c == RC_INT) {
            std::string v = getI(in.a, "$v0");
            if (v != "$v0") ins("move", "$v0, " + v);
        } else {
            if (in.a.kind != Opnd::REG) { error = "floating immediate return"; return; }
            std::string v = getF(in.a.reg, "$f0");
            if (v != "$f0") ins(c == RC_DOUBLE ? "mov.d" : "mov.s", "$f0, " + v);
        }
    }
    if (!last) ins("b", fsym + ".ret");
}

/* blkcopy with memmove semantics (section 5.8): up to 16 word-aligned bytes
   are all loaded into $t3-$t6 before any is stored, so overlap is harmless;
   up to 4 bytes of any alignment likewise byte by byte; anything larger calls
   __rt_memmove.  dst and src must already be in $t0/$t1. */
void Emitter::blockCopy(const std::string& dst, const std::string& src, long long n,
                        long long align) {
    if (n <= 0) return;
    if (align >= 4 && n % 4 == 0 && n <= 16) {
        for (long long k = 0; k < n / 4; ++k) ins("lw", "$t" + num(3 + k) + ", " + num(4 * k) + "(" + src + ")");
        for (long long k = 0; k < n / 4; ++k) ins("sw", "$t" + num(3 + k) + ", " + num(4 * k) + "(" + dst + ")");
    } else if (n <= 4) {
        for (long long k = 0; k < n; ++k) ins("lb", "$t" + num(3 + k) + ", " + num(k) + "(" + src + ")");
        for (long long k = 0; k < n; ++k) ins("sb", "$t" + num(3 + k) + ", " + num(k) + "(" + dst + ")");
    } else {
        ins("move", "$a0, " + dst);
        ins("move", "$a1, " + src);
        li("$a2", n);
        ins("jal", "__rt_memmove");
    }
}

void Emitter::blockZero(const std::string& dst, long long n) {
    if (n <= 0) return;
    if (n <= 16) {
        for (long long k = 0; k < n; ++k) ins("sb", "$zero, " + num(k) + "(" + dst + ")");
    } else {
        ins("move", "$a0, " + dst);
        li("$a1", n);
        ins("jal", "__rt_bzero");
    }
}

/* ---- data (MIPS-DESIGN.md section 7) ---- */

/* spim's .asciiz understands \n, \t and \" correctly but turns \\ into two
   backslashes and rejects octal escapes, so a string is written with .asciiz
   only when it needs nothing else; otherwise as a .byte list. */
bool asciizSafe(const std::string& b) {
    for (size_t i = 0; i < b.size(); ++i) {
        unsigned char c = (unsigned char)b[i];
        if (c == '\\') return false;
        if (c == '\n' || c == '\t') continue;
        if (c < 32 || c > 126) return false;
    }
    return true;
}

std::string asciizText(const std::string& b) {
    std::string r = "\"";
    for (size_t i = 0; i < b.size(); ++i) {
        char c = b[i];
        if (c == '\n') r += "\\n";
        else if (c == '\t') r += "\\t";
        else if (c == '"') r += "\\\"";
        else r += c;
    }
    return r + "\"";
}

/* A float or double initializer.  Finite values other than -0.0 are written
   with .float %.9e / .double %.17e, which spim reads back bit-exactly (checked
   for normal, subnormal and extreme values); infinities, NaNs and -0.0 are
   written as their bit patterns with .word, low word first (little-endian). */
void Emitter::floatPiece(const DataObj::Piece& p) {
    char buf[64];
    if (p.width == 4) {
        float f = (float)p.fval; uint32_t u; std::memcpy(&u, &f, 4);
        if (std::isfinite(f) && !(f == 0 && std::signbit(f))) {
            std::snprintf(buf, sizeof buf, "%.9e", (double)f);
            ins(".float", std::string(buf) + "\t# 0x" + [&]{ char h[16]; std::snprintf(h, sizeof h, "%08x", u); return std::string(h); }());
        } else {
            std::snprintf(buf, sizeof buf, "0x%08x", u);
            ins(".word", std::string(buf) + "\t# float " + (std::isnan(f) ? "nan" : std::isinf(f) ? (f < 0 ? "-inf" : "inf") : "-0.0"));
        }
    } else {
        double g = p.fval; uint64_t u; std::memcpy(&u, &g, 8);
        if (std::isfinite(g) && !(g == 0 && std::signbit(g))) {
            std::snprintf(buf, sizeof buf, "%.17e\t# 0x%016llx", g, (unsigned long long)u);
            ins(".double", buf);
        } else {
            std::snprintf(buf, sizeof buf, "0x%08x, 0x%08x\t# double %s", (unsigned)(u & 0xffffffffu),
                          (unsigned)(u >> 32),
                          std::isnan(g) ? "nan" : std::isinf(g) ? (g < 0 ? "-inf" : "inf") : "-0.0");
            ins(".word", buf);
        }
    }
}

/* Emits one IR data object in the .data section: a string as .asciiz (or
   .byte when it holds bytes .asciiz cannot express), a global as its
   .byte/.word/.float/.double/.space pieces in order.  spim cannot
   assemble `.word sym+N', so an address constant with an offset is emitted
   as 0 and recorded in addrFixes for main to store at startup. */
void Emitter::dataObject(const DataObj& d) {
    std::string sym = dataSym(d.name);
    os << "\n";
    if (opt.runtimeMode) os << "# @unit " << sym << "\n";
    os << "\t.data\n";
    int lg = 0;
    while ((1 << lg) < d.align) ++lg;
    if (lg > 0) ins(".align", num(lg));
    if (d.isString) {
        os << sym << ":\t\t# " << d.name << ", " << d.size << " bytes\n";
        if (asciizSafe(d.bytes)) ins(".asciiz", asciizText(d.bytes));
        else {
            std::string l;
            for (size_t k = 0; k <= d.bytes.size(); ++k) {
                int c = k < d.bytes.size() ? (int)(unsigned char)d.bytes[k] : 0;
                l += (l.empty() ? "" : ", ") + num(c);
                if (l.size() > 60 || k == d.bytes.size()) { ins(".byte", l); l.clear(); }
            }
        }
        int extra = d.size - (int)d.bytes.size() - 1;
        if (extra > 0) ins(".space", num(extra));
        return;
    }
    os << sym << ":\t\t# " << d.ctype << ", " << d.size << " bytes\n";
    int pos = 0;
    for (size_t k = 0; k < d.init.size(); ++k) {
        const DataObj::Piece& p = d.init[k];
        if (p.zero) ins(".space", num(p.width));
        else if (!p.sym.empty() && p.symOff != 0) {
            AddrFix fx = { sym, pos, dataSym(p.sym), p.symOff };
            addrFixes.push_back(fx);
            ins(".word", "0\t\t# " + fx.target + (p.symOff > 0 ? "+" : "") + num(p.symOff) +
                         ", stored by fn_main");
        }
        else if (!p.sym.empty()) ins(".word", p.isFunc ? funcSym(p.sym) : dataSym(p.sym));
        else if (p.isFloat) floatPiece(p);
        else if (p.width == 1) ins(".byte", num((int)(signed char)p.value));
        else ins(".word", num(i32(p.value)));
        pos += p.width;
    }
    if (pos < d.size) ins(".space", num(d.size - pos));
}

void Emitter::data() {
    for (size_t i = 0; i < M.data.size(); ++i) dataObject(M.data[i]);
}

void Emitter::header() {
    std::string out = opt.outputName.empty() ? "program.s" : opt.outputName;
    os << "# " << out << " -- MIPS assembly generated by mipscc from " << opt.sourceName << "\n"
       << "#\n"
       << "# Simulator : " << kSimulatorLine << "\n"
       << "#             (install: sudo apt-get install spim).  QtSpim shares spim's\n"
       << "#             simulator core and should run this file unchanged, but\n"
       << "#             only command-line spim was tested (see README).\n"
       << "# Run       : spim -file " << out << " [arguments...] < input\n"
       << "#             spim prints its banner (5 lines with the default exception\n"
       << "#             handler) on stdout before the program's own output.\n"
       << "# Assumes   : spim defaults -- pseudo-instructions on, no branch delay\n"
       << "#             slots, little-endian memory (as on an x86 host), the default\n"
       << "#             exception handler, whose __start calls `main' with argc in\n"
       << "#             $a0 and argv in $a1 (argv[0] is this file's path).  The\n"
       << "#             default stack is about 256 KB; add -lstack <bytes> for\n"
       << "#             deeper recursion.  Exit status = return value of main (or\n"
       << "#             the argument of exit) & 0xff, via syscall 17.\n"
       << "# Generated with -O" << opt.optLevel << ".  Every group of instructions is\n"
       << "# preceded by the IR instruction it implements; see docs/MIPS-DESIGN.md.\n";
}

/* ------------------------------------------------------------------------- */
/* Runtime linking: the embedded runtime is cut into units at "# @unit name"
   lines; a unit is included when the program (or an included unit) mentions
   its name outside a comment.  The entry unit `main' is always included. */

struct Unit { std::string name, text; std::set<std::string> refs; };

/* The labels a piece of assembly defines ("name:" at the start of a line). */
std::set<std::string> definedLabels(const std::string& text) {
    std::set<std::string> d;
    std::istringstream in(text);
    std::string line;
    while (std::getline(in, line)) {
        size_t n = 0;
        while (n < line.size() && (std::isalnum((unsigned char)line[n]) || line[n] == '_' ||
                                   line[n] == '.' || line[n] == '$')) ++n;
        if (n > 0 && n < line.size() && line[n] == ':') d.insert(line.substr(0, n));
    }
    return d;
}

/* The identifiers a piece of assembly mentions outside comments and strings. */
std::set<std::string> referencedNames(const std::string& text) {
    std::set<std::string> r;
    bool inStr = false, inComment = false;
    std::string cur;
    auto flush = [&]() { if (!cur.empty()) { r.insert(cur); cur.clear(); } };
    for (size_t i = 0; i < text.size(); ++i) {
        char c = text[i];
        if (c == '\n') { flush(); inComment = false; inStr = false; continue; }
        if (inComment) continue;
        if (inStr) { if (c == '\\') ++i; else if (c == '"') inStr = false; continue; }
        if (c == '#') { flush(); inComment = true; continue; }
        if (c == '"') { flush(); inStr = true; continue; }
        if (std::isalnum((unsigned char)c) || c == '_' || c == '.' || c == '$') cur += c;
        else flush();
    }
    flush();
    return r;
}

std::vector<Unit> splitUnits(const char* text) {
    std::vector<Unit> units;
    std::istringstream in(text ? text : "");
    std::string line;
    while (std::getline(in, line)) {
        if (line.compare(0, 8, "# @unit ") == 0) {
            Unit u; u.name = line.substr(8);
            while (!u.name.empty() && (u.name.back() == ' ' || u.name.back() == '\r')) u.name.pop_back();
            units.push_back(u);
        }
        if (!units.empty()) units.back().text += line + "\n";
    }
    /* a unit's references to its own labels (e.g. a message string) are local */
    for (size_t i = 0; i < units.size(); ++i) {
        units[i].refs = referencedNames(units[i].text);
        std::set<std::string> own = definedLabels(units[i].text);
        for (std::set<std::string>::iterator it = own.begin(); it != own.end(); ++it)
            if (*it != units[i].name) units[i].refs.erase(*it);
    }
    return units;
}

/* Appends to the program the runtime units it needs.  The runtime text is
   split into units at `# @unit NAME' markers; starting from the names the
   program references (plus main), every unit whose name is referenced by an
   already-wanted unit is pulled in too, and the wanted units are written in
   their original order.  Fails (with *err) if a referenced runtime name is
   missing. */
bool linkRuntime(std::ostream& os, const std::string& program, std::string* err) {
    std::vector<Unit> units = splitUnits(kRuntimeCore);
    std::vector<Unit> lib = splitUnits(kRuntimeLib);
    units.insert(units.end(), lib.begin(), lib.end());
    std::map<std::string, size_t> byName;
    for (size_t i = 0; i < units.size(); ++i) byName[units[i].name] = i;

    std::vector<bool> want(units.size(), false);
    std::vector<size_t> work;
    std::set<std::string> roots = referencedNames(program);
    roots.insert("main");
    for (std::set<std::string>::iterator it = roots.begin(); it != roots.end(); ++it) {
        std::map<std::string, size_t>::iterator u = byName.find(*it);
        if (u != byName.end()) { if (!want[u->second]) { want[u->second] = true; work.push_back(u->second); } }
        else if (it->compare(0, 5, "__rt_") == 0) {
            if (err) *err = "runtime routine '" + *it + "' is not available";
            return false;
        }
    }
    while (!work.empty()) {
        size_t k = work.back(); work.pop_back();
        for (std::set<std::string>::iterator it = units[k].refs.begin(); it != units[k].refs.end(); ++it) {
            std::map<std::string, size_t>::iterator u = byName.find(*it);
            if (u != byName.end() && !want[u->second]) { want[u->second] = true; work.push_back(u->second); }
            else if (u == byName.end() && it->compare(0, 5, "__rt_") == 0 &&
                     it->find('.') == std::string::npos) {
                if (err) *err = "runtime routine '" + *it + "' (used by " + units[k].name + ") is not available";
                return false;
            }
        }
    }
    os << "\n# =====================================================================\n"
       << "# Runtime library (src/runtime/rt_core.s and rt_lib.c): only the units\n"
       << "# this program uses, in their original order.\n"
       << "# =====================================================================\n";
    for (size_t i = 0; i < units.size(); ++i)
        if (want[i]) os << units[i].text;
    return true;
}

bool Emitter::run(std::string* err) {
    /* The program goes to a buffer first, so that the runtime units can be
       chosen from the names it references. */
    std::ostringstream body;
    {
        Emitter sub(body, M, opt);
        sub.data();
        for (size_t i = 0; i < M.funcs.size() && sub.error.empty(); ++i)
            sub.function(M.funcs[i]);
        if (!sub.error.empty()) { if (err) *err = sub.error; return false; }
    }
    if (opt.runtimeMode) {
        os << "# runtime library compiled from " << opt.sourceName << " by mipscc -O"
           << opt.optLevel << "\n" << body.str();
        return true;
    }
    header();
    os << body.str();
    return linkRuntime(os, body.str(), err);
}

} // namespace

bool emitMips(std::ostream& os, const IrModule& m, const MipsOptions& opt, std::string* err) {
    Emitter e(os, m, opt);
    return e.run(err);
}
