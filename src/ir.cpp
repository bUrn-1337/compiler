#include "ir.h"
#include "ast.h"
#include <sstream>
#include <cstdio>
#include <cstring>

static std::string regName(const IrFunc& f, int i) {
    if (i < 0 || (size_t)i >= f.regs.size()) return "%<bad>";
    return "%" + f.regs[i].name;
}

static std::string opndStr(const IrFunc& f, const Opnd& o) {
    switch (o.kind) {
        case Opnd::REG: return regName(f, o.reg);
        case Opnd::IMM: { std::ostringstream os; os << o.imm; return os.str(); }
        default: return "<none>";
    }
}

/* Render a byte as a readable C escape, for the trailing comment only. */
static std::string readable(const std::string& s) {
    std::string r;
    for (size_t i = 0; i < s.size(); ++i) {
        unsigned char c = (unsigned char)s[i];
        switch (c) {
            case '\n': r += "\\n"; break;
            case '\t': r += "\\t"; break;
            case '\r': r += "\\r"; break;
            case '"':  r += "\\\""; break;
            case '\\': r += "\\\\"; break;
            default:
                if (c < 32 || c > 126) { char b[8]; snprintf(b, sizeof b, "\\%03o", c); r += b; }
                else r += (char)c;
        }
    }
    return r;
}

/* Writes the .data section in the Stage 3 text format: one `str' line per
   string literal (its bytes in decimal plus the terminating 0, followed by a
   readable copy as a comment) and one `global' header per object followed by
   its init.byte/half/word/float/double/addr/zero pieces. */
static void writeData(std::ostream& os, const IrModule& m) {
    os << ".data\n";
    for (size_t i = 0; i < m.data.size(); ++i) {
        const DataObj& d = m.data[i];
        if (d.isString) {
            os << "str @" << d.name << " len " << d.size << " bytes";
            for (size_t k = 0; k < d.bytes.size(); ++k)
                os << (k ? "," : " ") << (int)(unsigned char)d.bytes[k];
            os << (d.bytes.empty() ? " 0" : ",0");
            os << "    ; \"" << readable(d.bytes) << "\"\n";
        } else {
            os << "global @" << d.name << " size " << d.size
               << " align " << d.align << " type " << d.tag
               << " ctype \"" << d.ctype << "\"\n";
            for (size_t k = 0; k < d.init.size(); ++k) {
                const DataObj::Piece& p = d.init[k];
                if (p.zero) os << "  init.zero " << p.width << "\n";
                else if (!p.sym.empty())
                {
                    os << "  init." << (p.isFunc ? "faddr" : "addr") << " @" << p.sym;
                    if (p.symOff) os << (p.symOff > 0 ? "+" : "") << p.symOff;
                    os << "\n";
                }
                else if (p.isFloat) {
                    /* The decimal spelling round-trips exactly (%.9g for a
                       float, %.17g for a double), so a reader that parses it
                       with strtod reproduces the same value bit for bit.  The
                       raw bit pattern follows in a comment for verification. */
                    char hex[32];
                    if (p.width == 4) {
                        float f = (float)p.fval; unsigned int u = 0;
                        memcpy(&u, &f, 4);
                        snprintf(hex, sizeof hex, "0x%08x", u);
                        os << "  init.float " << floatImage(p.fval, true);
                    } else {
                        double g = p.fval; unsigned long long u = 0;
                        memcpy(&u, &g, 8);
                        snprintf(hex, sizeof hex, "0x%016llx", u);
                        os << "  init.double " << floatImage(p.fval, false);
                    }
                    os << "    ; " << hex << "\n";
                }
                else if (p.width == 1) os << "  init.byte " << p.value << "\n";
                else os << "  init.word " << p.value << "\n";
            }
        }
    }
    os << ".enddata\n";
}

/* Writes one IR instruction in the Stage 3 text syntax, one case per opcode
   (label, copy, bin, un, cvt, sextb, load, store, addr, faddr, blkcopy,
   memzero, goto, if, iffalse, call, param, return).  Labels start in column
   0, everything else is indented. */
static void writeInstr(std::ostream& os, const IrFunc& f, const Instr& in) {
    std::string pad = "  ";
    switch (in.op) {
        case IR_LABEL:
            os << in.label << ":";
            break;
        case IR_COPY:
            os << pad << regName(f, in.dst) << " = " << opndStr(f, in.a);
            break;
        case IR_BIN:
            os << pad << regName(f, in.dst) << " = " << opndStr(f, in.a)
               << " " << in.sop << " " << opndStr(f, in.b);
            break;
        case IR_UN:
            os << pad << regName(f, in.dst) << " = " << in.sop << " " << opndStr(f, in.a);
            break;
        case IR_SEXTB:
            os << pad << regName(f, in.dst) << " = sext.b " << opndStr(f, in.a);
            break;
        case IR_CVT:
            os << pad << regName(f, in.dst) << " = " << in.sop << " " << opndStr(f, in.a);
            break;
        case IR_ADDR_LOCAL:
            os << pad << regName(f, in.dst) << " = addr " << in.label;
            break;
        case IR_ADDR_GLOBAL:
            os << pad << regName(f, in.dst) << " = addr @" << in.label;
            break;
        case IR_FADDR:
            os << pad << regName(f, in.dst) << " = faddr @" << in.label;
            break;
        case IR_LOAD:
            os << pad << regName(f, in.dst) << " = load." << in.sop << " " << opndStr(f, in.a);
            break;
        case IR_STORE:
            os << pad << "store." << in.sop << " " << opndStr(f, in.a) << ", " << opndStr(f, in.b);
            break;
        case IR_BLKCOPY:
            os << pad << "blkcopy " << opndStr(f, in.a) << ", " << opndStr(f, in.b)
               << ", size " << in.n << " align " << in.align;
            break;
        case IR_MEMZERO:
            os << pad << "memzero " << opndStr(f, in.a) << ", " << in.n;
            break;
        case IR_GOTO:
            os << pad << "goto " << in.label;
            break;
        case IR_IF:
            os << pad << "if " << opndStr(f, in.a) << " goto " << in.label;
            break;
        case IR_IFFALSE:
            os << pad << "ifFalse " << opndStr(f, in.a) << " goto " << in.label;
            break;
        case IR_PARAM:
            os << pad << "param " << opndStr(f, in.a) << " : " << in.tag;
            if (in.tag == "agg" || in.sret) os << " size " << in.n << " align " << in.align;
            if (in.sret) os << " sret";
            break;
        case IR_CALL:
            os << pad;
            if (in.dst >= 0) os << regName(f, in.dst) << " = ";
            if (in.indirect) os << "call " << opndStr(f, in.a) << ", " << in.n;
            else             os << "call @" << in.label << ", " << in.n;
            break;
        case IR_RETURN:
            os << pad << "return";
            if (in.a.kind != Opnd::NONE) os << " " << opndStr(f, in.a);
            break;
    }
    if (in.line > 0) os << "   ; line " << in.line;
    os << "\n";
}

/* Writes one function in the Stage 3 text format: the `func' header (return
   type, sret size and alignment, parameter count, frame size), one .param
   line per parameter (register, slot or by-value copy), the .local frame
   slots and .reg register declarations, then the body between begin/end. */
static void writeFunc(std::ostream& os, const IrFunc& f) {
    /* count anonymous temporaries */
    int ntemp = 0;
    for (size_t i = 0; i < f.regs.size(); ++i) if (!f.regs[i].named) ++ntemp;

    os << "\nfunc @" << f.name
       << " ret " << f.retTag
       << " retctype \"" << f.retCType << "\"";
    if (f.sret) os << " retsize " << f.retSize << " retalign " << f.retAlign << " sret";
    os << " nparams " << f.params.size()
       << " frame " << f.frameSize
       << " regs " << f.regs.size() << " temps " << ntemp
       << "    ; line " << f.line << "\n";

    for (size_t i = 0; i < f.params.size(); ++i) {
        const ParamInfo& p = f.params[i];
        os << "  .param " << i << " " << p.name
           << " : type " << p.tag << " ctype \"" << p.ctype << "\""
           << " size " << p.size << " align " << p.align << " ";
        if (p.byVal) {
            /* The caller hands over an address; the prologue copies the object
               into this slot, so the callee's writes never reach the caller. */
            os << "byval slot " << p.slotOffset << " from reg %" << f.regs[p.reg].name;
        } else if (p.inSlot) {
            os << "slot " << p.slotOffset;
        } else {
            os << "reg %" << f.regs[p.reg].name;
        }
        if (p.sret) os << " sret";
        os << "\n";
    }
    for (size_t i = 0; i < f.slots.size(); ++i) {
        const Slot& s = f.slots[i];
        os << "  .local " << s.name
           << " : type " << s.tag << " ctype \"" << s.ctype << "\""
           << " size " << s.size << " align " << s.align
           << " slot " << s.offset << "\n";
    }
    /* Named registers are always declared.  An anonymous temporary is declared
       too when it holds a floating-point value, because its register file
       (MIPS $f0.. rather than $t0..) and its width cannot be recovered from the
       instructions alone -- load.s and load.w both move four bytes.  So the
       rule a reader may rely on is: a register with no .reg line is an
       integer-or-pointer temporary. */
    for (size_t i = 0; i < f.regs.size(); ++i) {
        const RegInfo& r = f.regs[i];
        if (!r.named && r.tag != "float" && r.tag != "double") continue;
        os << "  .reg %" << r.name
           << " : type " << r.tag << " ctype \"" << r.ctype << "\"\n";
    }
    os << "begin\n";
    for (size_t i = 0; i < f.code.size(); ++i) writeInstr(os, f, f.code[i]);
    os << "end\n";
}

/* Stage 4: one instruction in exactly the text form writeIr uses, without the
   newline -- the MIPS back end puts it in a comment above the code it lowers
   that instruction to. */
std::string irInstrText(const IrFunc& f, const Instr& in) {
    std::ostringstream os;
    writeInstr(os, f, in);
    std::string s = os.str();
    while (!s.empty() && (s.back() == '\n' || s.back() == ' ')) s.pop_back();
    while (!s.empty() && s[0] == ' ') s.erase(0, 1);
    return s;
}

void writeIr(std::ostream& os, const IrModule& m) {
    os << "; Three-address intermediate representation\n";
    os << "; source: " << m.sourceName << "\n";
    os << "; target model: 32-bit MIPS -- char=1, int=4, pointer=4, big-endian-agnostic\n";
    os << "; see docs/IR-DESIGN.md for the full instruction specification\n\n";

    writeData(os, m);

    if (!m.externs.empty()) os << "\n";
    for (size_t i = 0; i < m.externs.size(); ++i) {
        const ExternFunc& e = m.externs[i];
        os << "extern @" << e.name << " ret " << e.retTag
           << " nparams " << e.nparams
           << (e.variadic ? " variadic" : "") << "\n";
    }

    for (size_t i = 0; i < m.funcs.size(); ++i) writeFunc(os, m.funcs[i]);
}
