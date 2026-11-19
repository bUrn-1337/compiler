/* tools/irsim.cpp -- an interpreter for the three-address IR.
 *
 * THIS IS A VERIFICATION TOOL, NOT PART OF THE CODE GENERATOR.  It exists so
 * that the IR produced by src/ can be executed and its output compared against
 * the output of the same program compiled by gcc.  It is deliberately a
 * separate program that knows nothing about the compiler's internals: it reads
 * only the IR text file, exactly as documented in docs/IR-DESIGN.md, which also
 * checks that that document is complete enough for a back end to be written
 * from it alone.
 *
 *   irsim <file.ir> [program args...]
 *
 * Memory is a single flat byte-addressable array, laid out the way the MIPS
 * back end will lay it out:
 *
 *   0x00000000  null page (any access is a fault)
 *   0x00001000  .data    globals and string literals, in declaration order
 *   0x00100000  heap     malloc/calloc/realloc/free, bump allocator + free list
 *   0x01000000  stack    grows downward, one frame per activation
 *
 * Integers and pointers are 32-bit, matching the target model (char=1, int=4,
 * ptr=4).  Floating-point values are held in the host's own float/double, and
 * every `.s' operation rounds its result to float, so arithmetic is bit-for-bit
 * what gcc produces for the same program (see docs/IR-DESIGN.md s11).
 *
 * A function's address is a synthetic word FUNC_BASE+4*k, never a real memory
 * address: code lives outside the data/heap/stack map above, so a stray
 * dereference of a function pointer faults instead of reading data.
 *
 * One argument occupies one argument slot regardless of width, so a double
 * takes one slot here where MIPS would use an aligned pair.  Nothing in the IR
 * depends on the number of slots -- the back end assigns them from the param
 * tags -- and the simulator's job is to reproduce values, not the ABI.
 */
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <cstdint>
#include <cmath>
#include <string>
#include <vector>
#include <map>
#include <set>
#include <fstream>
#include <sstream>
#include <iostream>

/* ===================== memory ===================== */

static const uint32_t DATA_BASE  = 0x00001000u;
static const uint32_t HEAP_BASE  = 0x00100000u;
static const uint32_t STACK_TOP  = 0x01000000u;
static const uint32_t MEM_SIZE   = 0x01000000u;
static const uint32_t FILE_BASE  = 0xF0000000u;   /* fake FILE* handles */
static const uint32_t FUNC_BASE  = 0xE0000000u;   /* fake code addresses */

static std::vector<uint8_t> MEM;

static void fault(const char* what, uint32_t addr) {
    std::fflush(stdout);
    std::fprintf(stderr, "irsim: %s at address 0x%08x\n", what, addr);
    std::exit(70);
}
static void checkRange(uint32_t a, uint32_t n) {
    if (a < 0x1000u || (uint64_t)a + n > MEM_SIZE) fault("invalid memory access", a);
}
static int32_t ld32(uint32_t a) {
    checkRange(a, 4);
    uint32_t v;  std::memcpy(&v, &MEM[a], 4);  return (int32_t)v;
}
static void st32(uint32_t a, int32_t v) {
    checkRange(a, 4);
    uint32_t u = (uint32_t)v;  std::memcpy(&MEM[a], &u, 4);
}
static int32_t ld8(uint32_t a) {
    checkRange(a, 1);
    return (int32_t)(int8_t)MEM[a];          /* char is signed, as on the target */
}
static void st8(uint32_t a, int32_t v) {
    checkRange(a, 1);
    MEM[a] = (uint8_t)(v & 0xff);
}
static double ld64(uint32_t a) {
    checkRange(a, 8);
    double v;  std::memcpy(&v, &MEM[a], 8);  return v;
}
static void st64(uint32_t a, double v) {
    checkRange(a, 8);
    std::memcpy(&MEM[a], &v, 8);
}
static double ldf32(uint32_t a) {
    checkRange(a, 4);
    float v;  std::memcpy(&v, &MEM[a], 4);  return (double)v;
}
static void stf32(uint32_t a, double v) {
    checkRange(a, 4);
    float f = (float)v;  std::memcpy(&MEM[a], &f, 4);
}
static std::string cstr(uint32_t a) {
    std::string s;
    for (;; ++a) { checkRange(a, 1); if (!MEM[a]) break; s += (char)MEM[a]; }
    return s;
}

/* ===================== heap ===================== */

struct Block { uint32_t addr; uint32_t size; bool free; };
static std::vector<Block> heapBlocks;
static uint32_t heapEnd = HEAP_BASE;

static uint32_t hmalloc(uint32_t n) {
    if (n == 0) n = 1;
    uint32_t need = (n + 7u) & ~7u;
    for (size_t i = 0; i < heapBlocks.size(); ++i)
        if (heapBlocks[i].free && heapBlocks[i].size >= need) {
            heapBlocks[i].free = false;
            return heapBlocks[i].addr;
        }
    if (heapEnd + need > STACK_TOP - 0x100000u) { std::fprintf(stderr, "irsim: heap exhausted\n"); std::exit(70); }
    Block b; b.addr = heapEnd; b.size = need; b.free = false;
    heapEnd += need;
    heapBlocks.push_back(b);
    return b.addr;
}
static Block* findBlock(uint32_t a) {
    for (size_t i = 0; i < heapBlocks.size(); ++i)
        if (heapBlocks[i].addr == a) return &heapBlocks[i];
    return 0;
}
static void hfree(uint32_t a) {
    if (a == 0) return;
    Block* b = findBlock(a);
    if (!b) { std::fflush(stdout); std::fprintf(stderr, "irsim: free() of a bad pointer 0x%08x\n", a); std::exit(70); }
    if (b->free) { std::fflush(stdout); std::fprintf(stderr, "irsim: double free of 0x%08x\n", a); std::exit(70); }
    b->free = true;
}

/* ===================== IR representation ===================== */

enum Op {
    O_LABEL, O_COPY, O_BIN, O_UN, O_SEXTB, O_CVT, O_ADDR_LOCAL, O_ADDR_GLOBAL,
    O_FADDR, O_LOAD, O_STORE, O_BLKCOPY, O_MEMZERO, O_GOTO, O_IF, O_IFFALSE,
    O_PARAM, O_CALL, O_RETURN
};

struct Val { bool isReg; int reg; int32_t imm; Val() : isReg(false), reg(-1), imm(0) {} };

/* A register's value.  The two fields are not a union: an instruction's
   mnemonic says which one it reads (load.w vs load.d, +.d vs +), so each
   producer writes just its own field, and `dst = a' copies the pair -- which
   is why a plain copy needs no type information.  A float-typed register
   keeps its value in `d' already rounded to float, so holding it in a double
   is exact. */
struct RV {
    int32_t i;
    double  d;
    RV() : i(0), d(0) {}
    static RV ofI(int32_t v) { RV r; r.i = v; r.d = (double)v; return r; }
    static RV ofD(double v)  { RV r; r.d = v; r.i = 0; return r; }
};

struct In {
    Op          op;
    int         dst;       /* register index, or -1 */
    Val         a, b;
    std::string sop;       /* operator text, or "w"/"b"/"s"/"d" */
    std::string label;     /* label / callee / slot name */
    int32_t     n;         /* arg count or byte count */
    int32_t     align;     /* blkcopy alignment */
    bool        indirect;  /* O_CALL through the register in `a' */
    int         target;    /* resolved pc for jumps */
    std::string tag;
    int         line;
    In() : op(O_LABEL), dst(-1), n(0), align(0), indirect(false),
           target(-1), line(0) {}
};

struct SlotDef { std::string name; int32_t offset; int32_t size; };
struct ParamDef {
    std::string name; bool inSlot; int32_t slotOffset; int reg; std::string tag;
    bool    byVal;     /* struct/union by value: `reg' receives the caller's
                          address and the prologue copies `size' bytes from it
                          into slotOffset, so the callee owns its own copy */
    int32_t size;
    ParamDef() : inSlot(false), slotOffset(0), reg(-1), byVal(false), size(0) {}
};

struct Func {
    std::string             name;
    std::string             retTag;
    int                     nparams;
    int32_t                 frame;
    int                     nregs;
    std::vector<ParamDef>   params;
    std::map<std::string,int32_t> slots;
    std::vector<In>         code;
    std::map<std::string,int> labels;
    std::map<std::string,int> regIndex;
    int                     line;
    Func() : nparams(0), frame(0), nregs(0), line(0) {}
};

static std::map<std::string,uint32_t> gDataAddr;
static std::vector<Func>              gFuncs;
static std::map<std::string,int>      gFuncIndex;
static std::set<std::string>          gExterns;
/* Function addresses.  Every @name that can have its address taken -- defined
   or extern -- gets one synthetic word, so an indirect call can map a value
   back to the name it came from. */
static std::map<std::string,uint32_t> gFuncAddr;
static std::map<uint32_t,std::string> gAddrFunc;
static uint32_t                       gNextFuncAddr = FUNC_BASE;

static uint32_t funcAddrOf(const std::string& nm) {
    std::map<std::string,uint32_t>::iterator it = gFuncAddr.find(nm);
    if (it != gFuncAddr.end()) return it->second;
    uint32_t a = gNextFuncAddr;
    gNextFuncAddr += 4u;
    gFuncAddr[nm] = a;
    gAddrFunc[a]  = nm;
    return a;
}

/* ===================== tokenizer ===================== */

/* Split a line into tokens.  Quoted strings stay in one token (so that
   ctype "int [3][4]" survives), commas and colons are separators, and
   everything from an unquoted ';' is a comment. */
static std::vector<std::string> tokenize(const std::string& line) {
    std::vector<std::string> out;
    size_t i = 0;
    while (i < line.size()) {
        char c = line[i];
        if (c == ';') break;
        if (std::isspace((unsigned char)c) || c == ',') { ++i; continue; }
        if (c == '"') {
            std::string s; ++i;
            while (i < line.size() && line[i] != '"') s += line[i++];
            if (i < line.size()) ++i;
            out.push_back(s);
            continue;
        }
        if (c == ':') { out.push_back(":"); ++i; continue; }
        std::string s;
        while (i < line.size() && !std::isspace((unsigned char)line[i])
               && line[i] != ',' && line[i] != ';' && line[i] != ':')
            s += line[i++];
        if (!s.empty()) out.push_back(s);
        if (i < line.size() && line[i] == ':') { out.push_back(":"); ++i; }
    }
    return out;
}

static int32_t toInt(const std::string& s) { return (int32_t)std::strtoll(s.c_str(), 0, 10); }

static void die(const std::string& msg, int lineNo, const std::string& text) {
    std::fprintf(stderr, "irsim: %s (IR line %d): %s\n", msg.c_str(), lineNo, text.c_str());
    std::exit(71);
}

/* Resolve an operand token: %reg or an integer literal. */
static Val operand(Func& f, const std::string& t) {
    Val v;
    if (!t.empty() && t[0] == '%') {
        std::string nm = t.substr(1);
        std::map<std::string,int>::iterator it = f.regIndex.find(nm);
        if (it == f.regIndex.end()) {
            int idx = (int)f.regIndex.size();
            f.regIndex[nm] = idx;
            v.isReg = true; v.reg = idx;
        } else { v.isReg = true; v.reg = it->second; }
    } else {
        v.isReg = false; v.imm = toInt(t);
    }
    return v;
}
static int regIdx(Func& f, const std::string& t) { return operand(f, t).reg; }

/* ===================== loader ===================== */

struct PendingAddr { uint32_t at; std::string sym; bool isFunc; int32_t off; };

/* Loads an IR file: lays out the .data section in simulated memory
   (strings and globals at their alignment), records every function's
   instructions, labels, frame size and parameters, and finally resolves the
   init.addr pieces (symbol plus optional offset) once every address is
   known.  Exits with status 71 on a malformed file. */
static void load(const std::string& path) {
    std::ifstream in(path.c_str());
    if (!in) { std::fprintf(stderr, "irsim: cannot open '%s'\n", path.c_str()); std::exit(71); }

    MEM.assign(MEM_SIZE, 0);

    std::string line;
    int lineNo = 0;
    uint32_t dataPos = DATA_BASE;
    std::vector<PendingAddr> fixups;
    Func* cur = 0;
    bool inBody = false;
    std::string curData;

    while (std::getline(in, line)) {
        ++lineNo;
        std::vector<std::string> t = tokenize(line);
        if (t.empty()) continue;

        if (t[0] == ".data" || t[0] == ".enddata") { continue; }

        /* ---- data section ---- */
        if (t[0] == "str") {
            /* str @.str0 len 7 bytes 104,101,...,0 */
            std::string nm = t[1].substr(1);
            int32_t len = 0;
            size_t k = 2;
            while (k < t.size() && t[k] != "len") ++k;
            if (k + 1 < t.size()) len = toInt(t[k+1]);
            while (k < t.size() && t[k] != "bytes") ++k;
            gDataAddr[nm] = dataPos;
            uint32_t p = dataPos;
            for (size_t j = k + 1; j < t.size(); ++j) MEM[p++] = (uint8_t)toInt(t[j]);
            dataPos += (uint32_t)len;
            dataPos = (dataPos + 3u) & ~3u;
            continue;
        }
        if (t[0] == "global") {
            int32_t size = 0, align = 4;
            for (size_t k = 2; k + 1 < t.size(); ++k) {
                if (t[k] == "size")  size  = toInt(t[k+1]);
                if (t[k] == "align") align = toInt(t[k+1]);
            }
            if (align < 1) align = 1;
            dataPos = (dataPos + (uint32_t)align - 1u) / (uint32_t)align * (uint32_t)align;
            curData = t[1].substr(1);
            gDataAddr[curData] = dataPos;
            dataPos += (uint32_t)size;
            dataPos = (dataPos + 3u) & ~3u;
            continue;
        }
        if (t[0].compare(0, 5, "init.") == 0) {
            uint32_t base = gDataAddr[curData];
            /* initializer pieces fill the object in order; track how far we are */
            static std::map<std::string,uint32_t> fillPos;
            uint32_t& pos = fillPos[curData];
            if (t[0] == "init.zero") { pos += (uint32_t)toInt(t[1]); }
            else if (t[0] == "init.byte") { MEM[base + pos] = (uint8_t)toInt(t[1]); pos += 1; }
            else if (t[0] == "init.word") { st32(base + pos, toInt(t[1])); pos += 4; }
            else if (t[0] == "init.float") {
                /* The decimal spelling round-trips, so strtod recovers exactly
                   the value the compiler folded (docs/IR-DESIGN.md s11.6). */
                stf32(base + pos, std::strtod(t[1].c_str(), 0)); pos += 4;
            }
            else if (t[0] == "init.double") {
                st64(base + pos, std::strtod(t[1].c_str(), 0)); pos += 8;
            }
            else if (t[0] == "init.addr" || t[0] == "init.faddr") {
                /* @sym or (Stage 4) @sym+N / @sym-N: an address inside it */
                PendingAddr pa; pa.at = base + pos; pa.sym = t[1].substr(1); pa.off = 0;
                size_t k = pa.sym.find_first_of("+-");
                if (k != std::string::npos) { pa.off = toInt(pa.sym.substr(k)); pa.sym.erase(k); }
                pa.isFunc = (t[0] == "init.faddr");
                fixups.push_back(pa); pos += 4;
            } else die("unknown data directive " + t[0], lineNo, line);
            continue;
        }
        if (t[0] == "extern") { gExterns.insert(t[1].substr(1));
                                funcAddrOf(t[1].substr(1)); continue; }

        /* ---- function header ---- */
        if (t[0] == "func") {
            gFuncs.push_back(Func());
            cur = &gFuncs.back();
            cur->name = t[1].substr(1);
            for (size_t k = 2; k + 1 < t.size(); ++k) {
                if (t[k] == "ret")     cur->retTag = t[k+1];
                if (t[k] == "nparams") cur->nparams = (int)toInt(t[k+1]);
                if (t[k] == "frame")   cur->frame = toInt(t[k+1]);
                if (t[k] == "regs")    cur->nregs = (int)toInt(t[k+1]);
            }
            gFuncIndex[cur->name] = (int)gFuncs.size() - 1;
            funcAddrOf(cur->name);
            inBody = false;
            continue;
        }
        if (!cur) continue;

        if (t[0] == ".param") {
            ParamDef p; p.name = t[2];
            bool sawSlot = false;
            for (size_t k = 3; k < t.size(); ++k) {
                if (t[k] == "type"  && k + 1 < t.size()) p.tag = t[k+1];
                if (t[k] == "size"  && k + 1 < t.size()) p.size = toInt(t[k+1]);
                if (t[k] == "byval")                     p.byVal = true;
                if (t[k] == "slot"  && k + 1 < t.size()) { sawSlot = true; p.slotOffset = toInt(t[k+1]); }
                if (t[k] == "reg"   && k + 1 < t.size()) p.reg = regIdx(*cur, t[k+1]);
            }
            /* "slot N" alone means the parameter's value lives in the frame;
               "byval slot N from reg %p" means the incoming pointer arrives in
               %p and the prologue copies the object into slot N, so the callee
               cannot write through to the caller's variable. */
            p.inSlot = sawSlot && !p.byVal;
            if (sawSlot) cur->slots[p.name] = p.slotOffset;
            cur->params.push_back(p);
            continue;
        }
        if (t[0] == ".local") {
            int32_t off = 0, size = 0;
            for (size_t k = 2; k + 1 < t.size(); ++k) {
                if (t[k] == "slot") off  = toInt(t[k+1]);
                if (t[k] == "size") size = toInt(t[k+1]);
            }
            (void)size;
            cur->slots[t[1]] = off;
            continue;
        }
        if (t[0] == ".reg") { operand(*cur, t[1]); continue; }
        if (t[0] == "begin") { inBody = true; continue; }
        if (t[0] == "end")   { inBody = false; cur = 0; continue; }
        if (!inBody) continue;

        /* ---- instructions ---- */
        In ins; ins.line = lineNo;

        if (t.size() >= 2 && t[1] == ":") {           /* .L3 : */
            ins.op = O_LABEL; ins.label = t[0];
            cur->labels[t[0]] = (int)cur->code.size();
            cur->code.push_back(ins);
            continue;
        }
        if (t[0] == "goto")    { ins.op = O_GOTO;    ins.label = t[1]; cur->code.push_back(ins); continue; }
        if (t[0] == "if")      { ins.op = O_IF;      ins.a = operand(*cur, t[1]); ins.label = t[3]; cur->code.push_back(ins); continue; }
        if (t[0] == "ifFalse") { ins.op = O_IFFALSE; ins.a = operand(*cur, t[1]); ins.label = t[3]; cur->code.push_back(ins); continue; }
        if (t[0] == "param")   { ins.op = O_PARAM;   ins.a = operand(*cur, t[1]);
                                 ins.tag = (t.size() > 3 ? t[3] : std::string("int"));
                                 for (size_t k = 4; k + 1 < t.size(); ++k) {
                                     if (t[k] == "size")  ins.n     = toInt(t[k+1]);
                                     if (t[k] == "align") ins.align = toInt(t[k+1]);
                                 }
                                 cur->code.push_back(ins); continue; }
        if (t[0] == "blkcopy") { /* blkcopy %d, %s, size N align A -- memmove */
            ins.op = O_BLKCOPY;
            ins.a = operand(*cur, t[1]); ins.b = operand(*cur, t[2]);
            for (size_t k = 3; k + 1 < t.size(); ++k) {
                if (t[k] == "size")  ins.n     = toInt(t[k+1]);
                if (t[k] == "align") ins.align = toInt(t[k+1]);
            }
            cur->code.push_back(ins); continue;
        }
        if (t[0] == "memzero") { ins.op = O_MEMZERO; ins.a = operand(*cur, t[1]); ins.n = toInt(t[2]); cur->code.push_back(ins); continue; }
        if (t[0].compare(0, 6, "store.") == 0) {
            ins.op = O_STORE; ins.sop = t[0].substr(6);
            ins.a = operand(*cur, t[1]); ins.b = operand(*cur, t[2]);
            cur->code.push_back(ins); continue;
        }
        if (t[0] == "return") {
            ins.op = O_RETURN;
            if (t.size() > 1) { ins.a = operand(*cur, t[1]); ins.n = 1; }
            cur->code.push_back(ins); continue;
        }
        if (t[0] == "call") {
            ins.op = O_CALL; ins.dst = -1; ins.n = toInt(t[2]);
            if (t[1][0] == '%') { ins.indirect = true; ins.a = operand(*cur, t[1]); }
            else                  ins.label = t[1].substr(1);
            cur->code.push_back(ins); continue;
        }
        /* %dst = ... */
        if (t.size() >= 3 && t[0][0] == '%' && t[1] == "=") {
            ins.dst = regIdx(*cur, t[0]);
            const std::string& k = t[2];
            if (k == "call") {
                ins.op = O_CALL; ins.n = toInt(t[4]);
                if (t[3][0] == '%') { ins.indirect = true; ins.a = operand(*cur, t[3]); }
                else                  ins.label = t[3].substr(1);
            } else if (k == "faddr") {
                ins.op = O_FADDR; ins.label = t[3].substr(1);
            } else if (k == "addr") {
                if (t[3][0] == '@') { ins.op = O_ADDR_GLOBAL; ins.label = t[3].substr(1); }
                else                { ins.op = O_ADDR_LOCAL;  ins.label = t[3]; }
            } else if (k == "sext.b") {
                ins.op = O_SEXTB; ins.a = operand(*cur, t[3]);
            } else if (k.compare(0, 5, "load.") == 0) {
                ins.op = O_LOAD; ins.sop = k.substr(5); ins.a = operand(*cur, t[3]);
            } else if (k.compare(0, 4, "cvt.") == 0 || k.compare(0, 6, "trunc.") == 0) {
                ins.op = O_CVT; ins.sop = k; ins.a = operand(*cur, t[3]);
            } else if (t.size() == 3) {
                ins.op = O_COPY; ins.a = operand(*cur, t[2]);
            } else if (t.size() == 4) {
                ins.op = O_UN; ins.sop = t[2]; ins.a = operand(*cur, t[3]);
            } else if (t.size() == 5) {
                ins.op = O_BIN; ins.a = operand(*cur, t[2]); ins.sop = t[3]; ins.b = operand(*cur, t[4]);
            } else die("cannot parse instruction", lineNo, line);
            cur->code.push_back(ins);
            continue;
        }
        die("cannot parse instruction", lineNo, line);
    }

    for (size_t i = 0; i < fixups.size(); ++i) {
        if (fixups[i].isFunc) {
            if (!gFuncAddr.count(fixups[i].sym)) {
                std::fprintf(stderr, "irsim: init.faddr refers to unknown function @%s\n",
                             fixups[i].sym.c_str());
                std::exit(71);
            }
            st32(fixups[i].at, (int32_t)gFuncAddr[fixups[i].sym]);
            continue;
        }
        std::map<std::string,uint32_t>::iterator it = gDataAddr.find(fixups[i].sym);
        if (it == gDataAddr.end()) {
            std::fprintf(stderr, "irsim: init.addr refers to unknown symbol @%s\n", fixups[i].sym.c_str());
            std::exit(71);
        }
        st32(fixups[i].at, (int32_t)it->second + fixups[i].off);
    }

    /* resolve jump targets */
    for (size_t i = 0; i < gFuncs.size(); ++i) {
        Func& f = gFuncs[i];
        for (size_t j = 0; j < f.code.size(); ++j) {
            In& c = f.code[j];
            if (c.op != O_GOTO && c.op != O_IF && c.op != O_IFFALSE) continue;
            std::map<std::string,int>::iterator it = f.labels.find(c.label);
            if (it == f.labels.end()) {
                std::fprintf(stderr, "irsim: %s jumps to undefined label %s\n",
                             f.name.c_str(), c.label.c_str());
                std::exit(71);
            }
            c.target = it->second;
        }
    }
}

/* ===================== runtime library ===================== */

static std::vector<FILE*> gFiles;

static FILE* fileOf(int32_t p) {
    uint32_t u = (uint32_t)p;
    if (u == FILE_BASE - 4u) return stdin;      /* not produced, kept for clarity */
    if (u < FILE_BASE) return 0;
    size_t i = (u - FILE_BASE) / 4u;
    if (i >= gFiles.size()) return 0;
    return gFiles[i];
}

/* snprintf into a std::string of any length (no fixed-size buffer). */
template <class T>
static std::string fmtOne(const std::string& spec, T v) {
    int n = std::snprintf(0, 0, spec.c_str(), v);
    if (n <= 0) return std::string();
    std::vector<char> tmp((size_t)n + 1);
    std::snprintf(&tmp[0], tmp.size(), spec.c_str(), v);
    return std::string(&tmp[0], (size_t)n);     /* keeps a NUL from %c */
}

/* printf-family: render `fmt` with `args`, writing to `out`.
 *
 * Stage 4 changes (all so that irsim agrees with glibc, i.e. with gcc -m32):
 *   - results of any length (the Stage 3 version cut each one at 511 chars);
 *   - %c of 0 writes a NUL byte (it used to vanish);
 *   - %s of a null pointer prints "(null)" only when the precision is absent
 *     or >= 6, otherwise nothing (glibc), rather than a prefix of "(null)";
 *   - %% with flags or a width ("%5%") prints "%" and takes no argument;
 *   - a negative precision from '*' means "no precision" (C99 7.19.6.1);
 *   - %hd/%hx... print the argument as a short, %hhd/%hhx... as a char. */
static int doPrintf(FILE* out, std::string* sout, uint32_t fmtAddr,
                    const std::vector<RV>& args, size_t argStart) {
    std::string fmt = cstr(fmtAddr);
    std::string res;
    size_t ai = argStart;

    for (size_t i = 0; i < fmt.size(); ++i) {
        if (fmt[i] != '%') { res += fmt[i]; continue; }
        if (i + 1 < fmt.size() && fmt[i+1] == '%') { res += '%'; ++i; continue; }

        std::string spec = "%";
        int prec = -1;
        ++i;
        while (i < fmt.size() && std::strchr("-+ #0", fmt[i])) spec += fmt[i++];
        if (i < fmt.size() && fmt[i] == '*') {
            std::ostringstream w; w << (ai < args.size() ? args[ai++].i : 0);
            spec += w.str(); ++i;
        } else while (i < fmt.size() && std::isdigit((unsigned char)fmt[i])) spec += fmt[i++];
        if (i < fmt.size() && fmt[i] == '.') {
            ++i;
            if (i < fmt.size() && fmt[i] == '*') {
                int32_t pv = ai < args.size() ? args[ai++].i : 0;
                if (pv >= 0) { std::ostringstream w; w << '.' << pv; spec += w.str(); prec = pv; }
                ++i;
            } else {
                spec += '.';
                prec = 0;
                while (i < fmt.size() && std::isdigit((unsigned char)fmt[i])) {
                    prec = prec * 10 + (fmt[i] - '0');
                    spec += fmt[i++];
                }
            }
        }
        /* Length modifiers: h and hh narrow an integer argument to short
           and char as glibc does (Stage 4); the others are ignored, since
           every integer is 32-bit and a float argument has already been
           promoted to double by the caller, so %f and %lf agree. */
        std::string mods;
        while (i < fmt.size() && std::strchr("hlLzjt", fmt[i])) mods += fmt[i++];
        if (i >= fmt.size()) { res += spec; break; }

        char conv = fmt[i];
        RV argv = (ai < args.size() ? args[ai++] : RV());
        int32_t arg = argv.i;
        if (mods == "h")  arg = (conv == 'd' || conv == 'i') ? (int32_t)(int16_t)arg : (int32_t)(uint16_t)arg;
        if (mods == "hh") arg = (conv == 'd' || conv == 'i') ? (int32_t)(int8_t)arg : (int32_t)(uint8_t)arg;
        switch (conv) {
            case 'd': case 'i':
                res += fmtOne(spec + "d", (int)arg); break;
            case 'u': case 'o': case 'x': case 'X':
                res += fmtOne(spec + conv, (unsigned)arg); break;
            case 'c':
                res += fmtOne(spec + "c", (int)(arg & 0xff)); break;
            case 's': {
                std::string s = arg ? cstr((uint32_t)arg)
                                    : std::string(prec >= 0 && prec < 6 ? "" : "(null)");
                res += fmtOne(spec + "s", s.c_str());
                break;
            }
            case 'f': case 'F': case 'e': case 'E':
            case 'g': case 'G': case 'a': case 'A':
                /* Rendered by the host's own printf on the host's own double,
                   which is the same IEEE-754 binary64 the target uses, so the
                   digits match gcc exactly. */
                res += fmtOne(spec + conv, argv.d); break;
            case 'p':
                res += fmtOne(std::string("0x%x"), (unsigned)arg); break;
            case '%':
                res += '%'; --ai; break;
            default:
                res += spec; res += conv; --ai; break;
        }
    }
    if (sout) { *sout = res; return (int)res.size(); }
    std::fwrite(res.data(), 1, res.size(), out);
    return (int)res.size();
}

/* strtol/strtoul as glibc does them with a 32-bit long (gcc -m32): `digits'
   (no sign, no prefix) in `base'; a signed result saturates to
   INT_MIN/INT_MAX, an unsigned one to UINT_MAX on overflow and is
   otherwise negated modulo 2^32 for a '-'.  Stage 4: the Stage 3 version
   used the host's 64-bit long and kept the low 32 bits. */
static int32_t strtol32(const std::string& digits, int base, bool neg, bool isSigned) {
    uint64_t mag = 0;
    bool ovf = false;
    for (char ch : digits) {
        int d = std::isdigit((unsigned char)ch) ? ch - '0' : (std::tolower((unsigned char)ch) - 'a' + 10);
        mag = mag * (uint64_t)base + (uint64_t)d;
        if (mag > 0xffffffffull) { ovf = true; mag = 0xffffffffull + 1; }
    }
    if (isSigned) {
        if (!neg) return (ovf || mag > 0x7fffffffull) ? INT32_MAX : (int32_t)mag;
        return (ovf || mag > 0x80000000ull) ? INT32_MIN : (int32_t)(0 - (uint32_t)mag);
    }
    if (ovf) return (int32_t)0xffffffffu;
    return (int32_t)(neg ? 0 - (uint32_t)mag : (uint32_t)mag);
}

/* atoi: optional space, sign and decimal digits, as (int)strtol. */
static int32_t atoi32(const std::string& s) {
    size_t i = 0;
    while (i < s.size() && std::isspace((unsigned char)s[i])) ++i;
    bool neg = false;
    if (i < s.size() && (s[i] == '+' || s[i] == '-')) neg = s[i++] == '-';
    std::string digits;
    while (i < s.size() && std::isdigit((unsigned char)s[i])) digits += s[i++];
    return strtol32(digits, 10, neg, true);
}

/* scanf-family over a character source. */
struct Source {
    FILE* f;
    const std::string* s;
    size_t pos;
    /* Sticky: set once the source has run out.  scanf must tell an input
       failure (end of file, which returns EOF when nothing was assigned yet)
       from a matching failure (a character that does not fit the conversion,
       which returns 0). */
    bool   eof;
    Source() : f(0), s(0), pos(0), eof(false) {}
    int get() {
        int c = EOF;
        if (f) c = std::fgetc(f);
        else if (pos < s->size()) c = (unsigned char)(*s)[pos++];
        if (c == EOF) eof = true;
        return c;
    }
    void unget(int c) {
        if (c == EOF) return;
        if (f) std::ungetc(c, f); else if (pos) --pos;
    }
};

/* The value a failing scanf returns: what it has assigned so far, or, if it
   has assigned nothing, EOF for an input failure and 0 for a matching one. */
static int scanFail(int assigned, const Source& src) {
    return assigned ? assigned : (src.eof ? EOF : 0);
}

/* Implements scanf/fscanf/sscanf over a Source: whitespace in the format
   skips input whitespace, ordinary characters must match, and %d %i %u %x
   %X %o %c %s %f %lf %e %g with optional width and * conversions store
   through the pointer arguments.  Integer parsing mirrors the MIPS runtime
   exactly (prefixes, width counting the sign, 32-bit saturation).  Returns
   the number of assignments; scanFail turns a failure at end of input
   before the first assignment into -1, as C does. */
static int doScanf(Source& src, uint32_t fmtAddr,
                   const std::vector<RV>& args, size_t argStart) {
    std::string fmt = cstr(fmtAddr);
    size_t ai = argStart;
    int assigned = 0;

    for (size_t i = 0; i < fmt.size(); ++i) {
        char fc = fmt[i];
        if (std::isspace((unsigned char)fc)) {
            int c;
            while ((c = src.get()) != EOF && std::isspace((unsigned char)c)) {}
            src.unget(c);
            continue;
        }
        if (fc != '%') {
            int c = src.get();
            if (c != fc) { src.unget(c); return scanFail(assigned, src); }
            continue;
        }
        ++i;
        if (i < fmt.size() && fmt[i] == '%') {
            int c = src.get();
            if (c != '%') { src.unget(c); return scanFail(assigned, src); }
            continue;
        }
        bool suppress = false;
        if (i < fmt.size() && fmt[i] == '*') { suppress = true; ++i; }
        int width = 0;
        while (i < fmt.size() && std::isdigit((unsigned char)fmt[i]))
            width = width * 10 + (fmt[i++] - '0');
        /* `l' matters for one conversion only: %f fills a float, %lf a
           double.  For the integer conversions every width is 32-bit. */
        bool isLong = false;
        while (i < fmt.size() && std::strchr("hlLzjt", fmt[i])) {
            if (fmt[i] == 'l' || fmt[i] == 'L') isLong = true;
            ++i;
        }
        if (i >= fmt.size()) break;
        char conv = fmt[i];

        if (conv != 'c') {
            int c;
            while ((c = src.get()) != EOF && std::isspace((unsigned char)c)) {}
            src.unget(c);
        }

        switch (conv) {
            case 'd': case 'i': case 'u': case 'x': case 'X': case 'o': {
                /* As glibc: the width counts the sign and a 0x prefix; %i
                   takes 0x as hex and a leading 0 as octal, %x also allows
                   0x; a "0x" with no hex digit after it reads as 0. */
                std::string num;
                int cnt = 0;
                bool neg = false;
                auto room = [&]() { return width == 0 || cnt < width; };
                int c = src.get();
                if (c == '+' || c == '-') { neg = c == '-'; ++cnt; c = src.get(); }
                int base = (conv == 'x' || conv == 'X') ? 16 : conv == 'o' ? 8 : conv == 'i' ? 0 : 10;
                int ndig = 0;
                if ((base == 0 || base == 16) && c == '0' && room()) {
                    num += '0'; ++cnt; ++ndig; c = src.get();
                    if (room() && (c == 'x' || c == 'X')) { ++cnt; base = 16; c = src.get(); }
                    else if (base == 0) base = 8;
                }
                if (base == 0) base = 10;
                while (room() && c != EOF && ((base == 16 && std::isxdigit((unsigned char)c))
                                 || (base != 16 && c >= '0' && c <= (base == 8 ? '7' : '9')))) {
                    num += (char)c; ++ndig; ++cnt;
                    c = src.get();
                }
                src.unget(c);
                if (!ndig) return scanFail(assigned, src);
                int32_t v = strtol32(num, base, neg, conv == 'd' || conv == 'i');
                if (!suppress) {
                    if (ai >= args.size()) return assigned;
                    st32((uint32_t)args[ai++].i, v);
                    ++assigned;
                }
                break;
            }
            case 'f': case 'e': case 'g': case 'E': case 'G': {
                /* Accept the strtod syntax that C requires of %f: an optional
                   sign, digits with an optional point, an optional exponent. */
                std::string num;
                int c = src.get();
                if (c == '+' || c == '-') { num += (char)c; c = src.get(); }
                int ndig = 0;
                while (c != EOF && std::isdigit((unsigned char)c)) { num += (char)c; ++ndig; c = src.get(); }
                if (c == '.') {
                    num += (char)c; c = src.get();
                    while (c != EOF && std::isdigit((unsigned char)c)) { num += (char)c; ++ndig; c = src.get(); }
                }
                if (ndig && (c == 'e' || c == 'E')) {
                    std::string ex(1, (char)c); c = src.get();
                    if (c == '+' || c == '-') { ex += (char)c; c = src.get(); }
                    int edig = 0;
                    while (c != EOF && std::isdigit((unsigned char)c)) { ex += (char)c; ++edig; c = src.get(); }
                    if (edig) num += ex;        /* else the 'e' was not ours */
                }
                src.unget(c);
                if (!ndig) return scanFail(assigned, src);
                double v = std::strtod(num.c_str(), 0);
                if (!suppress) {
                    if (ai >= args.size()) return assigned;
                    uint32_t q = (uint32_t)args[ai++].i;
                    if (isLong) st64(q, v); else stf32(q, v);
                    ++assigned;
                }
                break;
            }
            case 'c': {
                int n = width ? width : 1;
                uint32_t p = suppress ? 0 : (ai < args.size() ? (uint32_t)args[ai++].i : 0);
                int got = 0;
                for (int k = 0; k < n; ++k) {
                    int c = src.get();
                    if (c == EOF) break;
                    if (!suppress) st8(p + (uint32_t)k, c);
                    ++got;
                }
                if (!got) return scanFail(assigned, src);
                if (!suppress) ++assigned;
                break;
            }
            case 's': {
                uint32_t p = suppress ? 0 : (ai < args.size() ? (uint32_t)args[ai++].i : 0);
                int c = src.get();
                int got = 0;
                while (c != EOF && !std::isspace((unsigned char)c)) {
                    if (!suppress) st8(p + (uint32_t)got, c);
                    ++got;
                    if (width && got >= width) { c = src.get(); break; }
                    c = src.get();
                }
                src.unget(c);
                if (!got) return scanFail(assigned, src);
                if (!suppress) { st8(p + (uint32_t)got, 0); ++assigned; }
                break;
            }
            default:
                return assigned;
        }
    }
    return assigned;
}

static bool gExited = false;
static int  gExitCode = 0;

static RV callBuiltin(const std::string& nm, const std::vector<RV>& a);

/* ===================== execution ===================== */

static uint32_t gStackPtr = STACK_TOP;
static int      gDepth    = 0;

struct Pending { RV v; std::string tag; };

static RV run(Func& f, const std::vector<RV>& args);

static RV callByName(const std::string& nm, const std::vector<RV>& args) {
    std::map<std::string,int>::iterator it = gFuncIndex.find(nm);
    if (it != gFuncIndex.end()) return run(gFuncs[it->second], args);
    return callBuiltin(nm, args);
}

/* Split a mnemonic's floating suffix: "+.d" -> ("+", false), "<=.s" ->
   ("<=", true).  A mnemonic with no .s/.d suffix is an integer one. */
static bool fsuffix(const std::string& o, std::string* base, bool* single) {
    if (o.size() < 3) return false;
    char c = o[o.size() - 1];
    if (o[o.size() - 2] != '.' || (c != 's' && c != 'd')) return false;
    *base = o.substr(0, o.size() - 2);
    *single = (c == 's');
    return true;
}
/* Round a `.s' result to float; a `.d' result is already a double. */
static double fround(double v, bool single) { return single ? (double)(float)v : v; }

/* Interprets function f with the given argument values: allocates its
   frame on the simulated stack (filled with a pattern, not zeroed), then
   executes instructions until `ret', following the same 32-bit integer and
   IEEE float/double semantics as the MIPS code.  Runtime errors (division
   by zero, bad memory access, stack overflow) exit with status 70. */
static RV run(Func& f, const std::vector<RV>& args) {
    if (++gDepth > 20000) { std::fflush(stdout); std::fprintf(stderr, "irsim: stack overflow (recursion too deep)\n"); std::exit(70); }

    uint32_t frame = 0;
    uint32_t savedSp = gStackPtr;
    uint32_t fsize = (uint32_t)((f.frame + 7) & ~7);
    if (fsize) {
        gStackPtr -= fsize;
        frame = gStackPtr;
        /* Locals are NOT zeroed: uninitialised locals hold whatever was there,
           exactly like the target.  Fill with a recognisable pattern so that a
           test that depends on them shows up as a difference against gcc. */
        std::memset(&MEM[frame], 0xCD, fsize);
    }

    std::vector<RV> R(f.regIndex.size() + 4);
    for (size_t i = 0; i < f.params.size(); ++i) {
        const ParamDef& p = f.params[i];
        RV v = (i < args.size() ? args[i] : RV());
        if (p.byVal) {
            /* The callee's own copy: made here, in the prologue, so that
               whatever the body writes never reaches the caller's object. */
            uint32_t d = frame + (uint32_t)p.slotOffset, src = (uint32_t)v.i;
            if (p.size > 0) {
                checkRange(d, (uint32_t)p.size); checkRange(src, (uint32_t)p.size);
                std::memmove(&MEM[d], &MEM[src], (size_t)p.size);
            }
            if (p.reg >= 0 && (size_t)p.reg < R.size()) R[p.reg] = v;
        } else if (p.inSlot) {
            if (p.tag == "double")      st64(frame + (uint32_t)p.slotOffset, v.d);
            else if (p.tag == "float")  stf32(frame + (uint32_t)p.slotOffset, v.d);
            else                        st32(frame + (uint32_t)p.slotOffset, v.i);
        } else if (p.reg >= 0 && (size_t)p.reg < R.size()) {
            R[p.reg] = v;
        }
    }

    std::vector<Pending> pend;
    RV ret;

    std::string fbase; bool fsingle = false;

    for (size_t pc = 0; pc < f.code.size(); ++pc) {
        In& c = f.code[pc];
        /* An immediate is always an integer one: there is no floating
           immediate in the IR (see floatConst in src/irgen.cpp). */
        #define RV_(o) ((o).isReg ? R[(o).reg] : RV::ofI((o).imm))
        #define RD(o)  (RV_(o).i)
        #define FD(o)  (RV_(o).d)
        switch (c.op) {
            case O_LABEL: break;
            case O_COPY:  R[c.dst] = RV_(c.a); break;
            case O_SEXTB: R[c.dst] = RV::ofI((int32_t)(int8_t)(RD(c.a) & 0xff)); break;
            case O_CVT: {
                const std::string& o = c.sop;
                if      (o == "cvt.s.w")   R[c.dst] = RV::ofD((double)(float)RD(c.a));
                else if (o == "cvt.d.w")   R[c.dst] = RV::ofD((double)RD(c.a));
                else if (o == "cvt.d.s")   R[c.dst] = RV::ofD(FD(c.a));
                else if (o == "cvt.s.d")   R[c.dst] = RV::ofD((double)(float)FD(c.a));
                /* trunc, not cvt.w.*: C truncates toward zero regardless of
                   the rounding mode in force. */
                else if (o == "trunc.w.s") R[c.dst] = RV::ofI((int32_t)(float)FD(c.a));
                else if (o == "trunc.w.d") R[c.dst] = RV::ofI((int32_t)FD(c.a));
                else die("unknown conversion " + o, c.line, "");
                break;
            }
            case O_FADDR: {
                std::map<std::string,uint32_t>::iterator it = gFuncAddr.find(c.label);
                if (it == gFuncAddr.end()) die("address of unknown function @" + c.label, c.line, "");
                R[c.dst] = RV::ofI((int32_t)it->second);
                break;
            }
            case O_UN: {
                if (fsuffix(c.sop, &fbase, &fsingle)) {
                    double v = FD(c.a);
                    if      (fbase == "-") R[c.dst] = RV::ofD(fround(-v, fsingle));
                    else if (fbase == "+") R[c.dst] = RV::ofD(v);
                    else die("unknown unary operator " + c.sop, c.line, "");
                    break;
                }
                int32_t v = RD(c.a);
                if (c.sop == "-") R[c.dst] = RV::ofI((int32_t)(0u - (uint32_t)v));
                else if (c.sop == "+") R[c.dst] = RV::ofI(v);
                else if (c.sop == "!") R[c.dst] = RV::ofI(v == 0);
                else if (c.sop == "~") R[c.dst] = RV::ofI((int32_t)(~(uint32_t)v));
                else die("unknown unary operator " + c.sop, c.line, "");
                break;
            }
            case O_BIN: {
                if (fsuffix(c.sop, &fbase, &fsingle)) {
                    double x = FD(c.a), y = FD(c.b);
                    const std::string& o = fbase;
                    /* No division-by-zero trap here: in C a floating division
                       by zero yields an infinity or a NaN, it does not fault. */
                    if      (o == "+")  R[c.dst] = RV::ofD(fround(x + y, fsingle));
                    else if (o == "-")  R[c.dst] = RV::ofD(fround(x - y, fsingle));
                    else if (o == "*")  R[c.dst] = RV::ofD(fround(x * y, fsingle));
                    else if (o == "/")  R[c.dst] = RV::ofD(fround(x / y, fsingle));
                    /* A comparison's result is an int, in any register file. */
                    else if (o == "<")  R[c.dst] = RV::ofI(x <  y);
                    else if (o == "<=") R[c.dst] = RV::ofI(x <= y);
                    else if (o == ">")  R[c.dst] = RV::ofI(x >  y);
                    else if (o == ">=") R[c.dst] = RV::ofI(x >= y);
                    else if (o == "==") R[c.dst] = RV::ofI(x == y);
                    else if (o == "!=") R[c.dst] = RV::ofI(x != y);
                    else die("unknown floating operator " + c.sop, c.line, "");
                    break;
                }
                int32_t x = RD(c.a), y = RD(c.b);
                const std::string& o = c.sop;
                if      (o == "+")  R[c.dst] = RV::ofI((int32_t)((uint32_t)x + (uint32_t)y));
                else if (o == "-")  R[c.dst] = RV::ofI((int32_t)((uint32_t)x - (uint32_t)y));
                else if (o == "*")  R[c.dst] = RV::ofI((int32_t)((uint32_t)x * (uint32_t)y));
                else if (o == "/") {
                    if (y == 0) { std::fflush(stdout); std::fprintf(stderr, "irsim: division by zero\n"); std::exit(70); }
                    R[c.dst] = RV::ofI((x == INT32_MIN && y == -1) ? x : x / y);
                } else if (o == "%") {
                    if (y == 0) { std::fflush(stdout); std::fprintf(stderr, "irsim: division by zero\n"); std::exit(70); }
                    R[c.dst] = RV::ofI((x == INT32_MIN && y == -1) ? 0 : x % y);
                }
                else if (o == "<<") R[c.dst] = RV::ofI((int32_t)((uint32_t)x << (y & 31)));
                else if (o == ">>") R[c.dst] = RV::ofI(x >> (y & 31));
                else if (o == "&")  R[c.dst] = RV::ofI(x & y);
                else if (o == "|")  R[c.dst] = RV::ofI(x | y);
                else if (o == "^")  R[c.dst] = RV::ofI(x ^ y);
                else if (o == "<")  R[c.dst] = RV::ofI(x <  y);
                else if (o == "<=") R[c.dst] = RV::ofI(x <= y);
                else if (o == ">")  R[c.dst] = RV::ofI(x >  y);
                else if (o == ">=") R[c.dst] = RV::ofI(x >= y);
                else if (o == "==") R[c.dst] = RV::ofI(x == y);
                else if (o == "!=") R[c.dst] = RV::ofI(x != y);
                else die("unknown binary operator " + o, c.line, "");
                break;
            }
            case O_ADDR_LOCAL: {
                std::map<std::string,int32_t>::iterator it = f.slots.find(c.label);
                if (it == f.slots.end()) die("addr of unknown slot " + c.label, c.line, "");
                R[c.dst] = RV::ofI((int32_t)(frame + (uint32_t)it->second));
                break;
            }
            case O_ADDR_GLOBAL: {
                std::map<std::string,uint32_t>::iterator it = gDataAddr.find(c.label);
                if (it == gDataAddr.end()) die("addr of unknown global @" + c.label, c.line, "");
                R[c.dst] = RV::ofI((int32_t)it->second);
                break;
            }
            case O_LOAD: {
                uint32_t a = (uint32_t)RD(c.a);
                if      (c.sop == "b") R[c.dst] = RV::ofI(ld8(a));
                else if (c.sop == "w") R[c.dst] = RV::ofI(ld32(a));
                else if (c.sop == "s") R[c.dst] = RV::ofD(ldf32(a));
                else if (c.sop == "d") R[c.dst] = RV::ofD(ld64(a));
                else die("unknown load width ." + c.sop, c.line, "");
                break;
            }
            case O_STORE: {
                uint32_t a = (uint32_t)RD(c.a);
                if      (c.sop == "b") st8(a, RD(c.b));
                else if (c.sop == "w") st32(a, RD(c.b));
                else if (c.sop == "s") stf32(a, FD(c.b));
                else if (c.sop == "d") st64(a, FD(c.b));
                else die("unknown store width ." + c.sop, c.line, "");
                break;
            }
            case O_BLKCOPY: {
                /* memmove, not memcpy: "s = s" and a copy between overlapping
                   objects must both be well defined (docs/IR-DESIGN.md s12). */
                uint32_t d = (uint32_t)RD(c.a), s = (uint32_t)RD(c.b);
                if (c.n > 0) {
                    checkRange(d, (uint32_t)c.n); checkRange(s, (uint32_t)c.n);
                    if (c.align > 1 && ((d | s) & (uint32_t)(c.align - 1)))
                        die("blkcopy operand is not aligned to the stated alignment", c.line, "");
                    std::memmove(&MEM[d], &MEM[s], (size_t)c.n);
                }
                break;
            }
            case O_MEMZERO: {
                uint32_t d = (uint32_t)RD(c.a);
                checkRange(d, (uint32_t)c.n);
                std::memset(&MEM[d], 0, (size_t)c.n);
                break;
            }
            case O_GOTO:    pc = (size_t)c.target; break;
            case O_IF:      if (RD(c.a) != 0) pc = (size_t)c.target; break;
            case O_IFFALSE: if (RD(c.a) == 0) pc = (size_t)c.target; break;
            case O_PARAM: { Pending p; p.v = RV_(c.a); p.tag = c.tag; pend.push_back(p); break; }
            case O_CALL: {
                size_t n = (size_t)c.n;
                if (pend.size() < n) die("call has fewer param instructions than arguments", c.line, "");
                std::vector<RV> as;
                for (size_t k = pend.size() - n; k < pend.size(); ++k) as.push_back(pend[k].v);
                pend.resize(pend.size() - n);
                std::string callee = c.label;
                if (c.indirect) {
                    uint32_t fa = (uint32_t)RD(c.a);
                    std::map<uint32_t,std::string>::iterator it = gAddrFunc.find(fa);
                    if (it == gAddrFunc.end()) {
                        std::fflush(stdout);
                        std::fprintf(stderr, "irsim: indirect call through a value that is not a "
                                             "function address (0x%08x), IR line %d\n", fa, c.line);
                        std::exit(70);
                    }
                    callee = it->second;
                }
                RV v = callByName(callee, as);
                if (gExited) { gStackPtr = savedSp; --gDepth; return RV(); }
                if (c.dst >= 0) R[c.dst] = v;
                break;
            }
            case O_RETURN:
                ret = (c.n ? RV_(c.a) : RV());
                gStackPtr = savedSp;
                --gDepth;
                return ret;
        }
        #undef FD
        #undef RD
        #undef RV_
        if (gExited) break;
    }
    gStackPtr = savedSp;
    --gDepth;
    return ret;
}

/* ===================== built-ins ===================== */

/* The great majority of the C library this simulator provides returns an int
   or a pointer, so that set is kept in one integer-returning function and the
   few double-returning ones are handled by the wrapper below. */
static int32_t callBuiltinI(const std::string& nm, const std::vector<RV>& a);

static RV callBuiltin(const std::string& nm, const std::vector<RV>& a) {
    #define AD(k) (k < a.size() ? a[k].d : 0.0)
    /* <math.h>, double in and double out.  Evaluated by the host's libm on the
       host's binary64, which is the target's double, so a program that prints
       its result with a fixed precision prints the same digits as under gcc.
       (These are the only externals whose result is floating, which is why the
       IR needs no return-type tag on a call: the callee's declared type, which
       the front end already checked, says which register file to read.) */
    if (nm == "sqrt")  return RV::ofD(std::sqrt(AD(0)));
    if (nm == "fabs")  return RV::ofD(std::fabs(AD(0)));
    if (nm == "floor") return RV::ofD(std::floor(AD(0)));
    if (nm == "ceil")  return RV::ofD(std::ceil(AD(0)));
    if (nm == "pow")   return RV::ofD(std::pow(AD(0), AD(1)));
    if (nm == "fmod")  return RV::ofD(std::fmod(AD(0), AD(1)));
    if (nm == "exp")   return RV::ofD(std::exp(AD(0)));
    if (nm == "log")   return RV::ofD(std::log(AD(0)));
    if (nm == "log10") return RV::ofD(std::log10(AD(0)));
    if (nm == "sin")   return RV::ofD(std::sin(AD(0)));
    if (nm == "cos")   return RV::ofD(std::cos(AD(0)));
    if (nm == "tan")   return RV::ofD(std::tan(AD(0)));
    if (nm == "asin")  return RV::ofD(std::asin(AD(0)));
    if (nm == "acos")  return RV::ofD(std::acos(AD(0)));
    if (nm == "atan")  return RV::ofD(std::atan(AD(0)));
    if (nm == "atan2") return RV::ofD(std::atan2(AD(0), AD(1)));
    if (nm == "atof")  return RV::ofD(std::strtod(
                              cstr((uint32_t)(a.empty() ? 0 : a[0].i)).c_str(), 0));
    #undef AD
    return RV::ofI(callBuiltinI(nm, a));
}

/* Executes a library function that returns an int or a pointer: the stdio
   functions (printf/scanf families, files), the heap (malloc, calloc,
   realloc, free), string and memory helpers and exit.  Arguments arrive as
   RVs; strings are addresses in simulated memory.  Exits with status 72 for
   an unknown builtin. */
static int32_t callBuiltinI(const std::string& nm, const std::vector<RV>& a) {
    /* `k', not `i': the body says a[k].i and the preprocessor would
       substitute a macro parameter named i into that member name too. */
    #define A(k) (k < a.size() ? a[k].i : 0)

    if (nm == "printf")  { return doPrintf(stdout, 0, (uint32_t)A(0), a, 1); }
    if (nm == "fprintf") { FILE* f = fileOf(A(0)); if (!f) f = stdout;
                           return doPrintf(f, 0, (uint32_t)A(1), a, 2); }
    if (nm == "sprintf") { std::string s; int n = doPrintf(0, &s, (uint32_t)A(1), a, 2);
                           for (size_t i = 0; i < s.size(); ++i) st8((uint32_t)A(0) + (uint32_t)i, (unsigned char)s[i]);
                           st8((uint32_t)A(0) + (uint32_t)s.size(), 0); return n; }
    if (nm == "puts")    { std::string s = cstr((uint32_t)A(0)); std::fwrite(s.data(), 1, s.size(), stdout);
                           std::fputc('\n', stdout); return (int)s.size() + 1; }
    if (nm == "putchar") { std::fputc((int)(A(0) & 0xff), stdout); return A(0) & 0xff; }
    if (nm == "getchar") { return std::fgetc(stdin); }

    if (nm == "scanf")   { Source s; s.f = stdin; return doScanf(s, (uint32_t)A(0), a, 1); }
    if (nm == "fscanf")  { FILE* f = fileOf(A(0)); if (!f) return -1;
                           Source s; s.f = f; return doScanf(s, (uint32_t)A(1), a, 2); }
    if (nm == "sscanf")  { std::string in = cstr((uint32_t)A(0));
                           Source s; s.s = &in; return doScanf(s, (uint32_t)A(1), a, 2); }

    if (nm == "malloc")  { return (int32_t)hmalloc((uint32_t)A(0)); }
    if (nm == "calloc")  { uint32_t n = (uint32_t)A(0) * (uint32_t)A(1);
                           uint32_t p = hmalloc(n);
                           if (n) { checkRange(p, n); std::memset(&MEM[p], 0, n); }
                           return (int32_t)p; }
    if (nm == "realloc") { uint32_t old = (uint32_t)A(0), n = (uint32_t)A(1);
                           if (!old) return (int32_t)hmalloc(n);
                           Block* b = findBlock(old);
                           if (!b) { std::fflush(stdout); std::fprintf(stderr, "irsim: realloc of a bad pointer\n"); std::exit(70); }
                           if (b->size >= n) return (int32_t)old;
                           uint32_t p = hmalloc(n);
                           checkRange(p, b->size); std::memmove(&MEM[p], &MEM[old], b->size);
                           hfree(old); return (int32_t)p; }
    if (nm == "free")    { hfree((uint32_t)A(0)); return 0; }

    if (nm == "exit")    { gExited = true; gExitCode = A(0); return 0; }
    if (nm == "abs")     { int32_t v = A(0); return v < 0 ? -v : v; }
    if (nm == "atoi")    { return atoi32(cstr((uint32_t)A(0))); }

    if (nm == "strlen")  { return (int32_t)cstr((uint32_t)A(0)).size(); }
    if (nm == "strcpy")  { uint32_t d = (uint32_t)A(0), s = (uint32_t)A(1);
                           for (;; ++d, ++s) { int32_t ch = ld8(s); st8(d, ch); if (!ch) break; }
                           return A(0); }
    if (nm == "strncpy") { uint32_t d = (uint32_t)A(0), s = (uint32_t)A(1); int32_t n = A(2);
                           int32_t i = 0;
                           for (; i < n; ++i) { int32_t ch = ld8(s + (uint32_t)i); st8(d + (uint32_t)i, ch); if (!ch) break; }
                           for (; i < n; ++i) st8(d + (uint32_t)i, 0);
                           return A(0); }
    if (nm == "strcat")  { uint32_t d = (uint32_t)A(0), s = (uint32_t)A(1);
                           while (ld8(d)) ++d;
                           for (;; ++d, ++s) { int32_t ch = ld8(s); st8(d, ch); if (!ch) break; }
                           return A(0); }
    if (nm == "strcmp")  { std::string x = cstr((uint32_t)A(0)), y = cstr((uint32_t)A(1));
                           int r = std::strcmp(x.c_str(), y.c_str());
                           return r < 0 ? -1 : (r > 0 ? 1 : 0); }
    if (nm == "strncmp") { std::string x = cstr((uint32_t)A(0)), y = cstr((uint32_t)A(1));
                           int r = std::strncmp(x.c_str(), y.c_str(), (size_t)A(2));
                           return r < 0 ? -1 : (r > 0 ? 1 : 0); }
    if (nm == "strchr")  { uint32_t p = (uint32_t)A(0); int32_t ch = A(1) & 0xff;
                           for (;; ++p) { int32_t c = ld8(p) & 0xff; if (c == ch) return (int32_t)p; if (!c) return 0; } }
    if (nm == "memset")  { uint32_t p = (uint32_t)A(0); int32_t v = A(1); int32_t n = A(2);
                           if (n > 0) { checkRange(p, (uint32_t)n); std::memset(&MEM[p], (int)(v & 0xff), (size_t)n); }
                           return A(0); }
    if (nm == "memcpy")  { uint32_t d = (uint32_t)A(0), s = (uint32_t)A(1); int32_t n = A(2);
                           if (n > 0) { checkRange(d, (uint32_t)n); checkRange(s, (uint32_t)n);
                                        std::memmove(&MEM[d], &MEM[s], (size_t)n); }
                           return A(0); }

    if (nm == "fopen")   { std::string path = cstr((uint32_t)A(0)), mode = cstr((uint32_t)A(1));
                           FILE* f = std::fopen(path.c_str(), mode.c_str());
                           if (!f) return 0;
                           gFiles.push_back(f);
                           return (int32_t)(FILE_BASE + (uint32_t)(gFiles.size() - 1) * 4u); }
    if (nm == "fclose")  { FILE* f = fileOf(A(0)); if (!f) return -1;
                           size_t i = ((uint32_t)A(0) - FILE_BASE) / 4u;
                           if (i < gFiles.size()) gFiles[i] = 0;
                           return std::fclose(f); }
    if (nm == "fgets")   { FILE* f = fileOf(A(2)); if (!f) f = stdin;
                           uint32_t p = (uint32_t)A(0); int32_t n = A(1);
                           if (n <= 0) return 0;
                           int32_t i = 0;
                           for (; i < n - 1; ) { int ch = std::fgetc(f);
                                                 if (ch == EOF) break;
                                                 st8(p + (uint32_t)i, ch); ++i;
                                                 if (ch == '\n') break; }
                           if (!i) return 0;
                           st8(p + (uint32_t)i, 0);
                           return A(0); }
    if (nm == "fputs")   { FILE* f = fileOf(A(1)); if (!f) f = stdout;
                           std::string s = cstr((uint32_t)A(0));
                           std::fwrite(s.data(), 1, s.size(), f); return (int)s.size(); }
    if (nm == "fgetc")   { FILE* f = fileOf(A(0)); if (!f) f = stdin; return std::fgetc(f); }
    if (nm == "fputc")   { FILE* f = fileOf(A(1)); if (!f) f = stdout;
                           return std::fputc((int)(A(0) & 0xff), f); }
    if (nm == "feof")    { FILE* f = fileOf(A(0)); return f ? (std::feof(f) ? 1 : 0) : 1; }
    if (nm == "rewind")  { FILE* f = fileOf(A(0)); if (f) std::rewind(f); return 0; }
    if (nm == "remove")  { return std::remove(cstr((uint32_t)A(0)).c_str()); }

    std::fflush(stdout);
    std::fprintf(stderr, "irsim: call to unimplemented external function '%s'\n", nm.c_str());
    std::exit(72);
    #undef A
}

/* ===================== entry ===================== */

/* irsim FILE.ir [args...]: loads the IR, builds argc/argv for main in
   simulated memory (argv[0] is the IR file's path), runs main and exits
   with its result, or with the value passed to exit, & 0xff. */
int main(int argc, char** argv) {
    if (argc < 2) {
        std::fprintf(stderr, "usage: irsim <file.ir> [program args...]\n");
        return 2;
    }
    load(argv[1]);

    std::map<std::string,int>::iterator mit = gFuncIndex.find("main");
    if (mit == gFuncIndex.end()) { std::fprintf(stderr, "irsim: no main\n"); return 71; }
    Func& mf = gFuncs[mit->second];

    /* Build argv in memory: the pointer array, then the strings.  argv[0] is
       the IR file's own name, mirroring how a real program sees its path. */
    std::vector<std::string> pargs;
    pargs.push_back(argv[1]);
    for (int i = 2; i < argc; ++i) pargs.push_back(argv[i]);

    uint32_t strBase = hmalloc(4u * (uint32_t)(pargs.size() + 1));
    std::vector<uint32_t> ptrs;
    for (size_t i = 0; i < pargs.size(); ++i) {
        uint32_t p = hmalloc((uint32_t)pargs[i].size() + 1);
        for (size_t k = 0; k < pargs[i].size(); ++k) st8(p + (uint32_t)k, (unsigned char)pargs[i][k]);
        st8(p + (uint32_t)pargs[i].size(), 0);
        ptrs.push_back(p);
    }
    for (size_t i = 0; i < ptrs.size(); ++i) st32(strBase + 4u * (uint32_t)i, (int32_t)ptrs[i]);
    st32(strBase + 4u * (uint32_t)ptrs.size(), 0);

    std::vector<RV> args;
    args.push_back(RV::ofI((int32_t)pargs.size()));
    args.push_back(RV::ofI((int32_t)strBase));
    args.resize(mf.params.size() < 2 ? mf.params.size() : args.size());

    RV rc = run(mf, args);
    std::fflush(stdout);
    for (size_t i = 0; i < gFiles.size(); ++i) if (gFiles[i]) std::fclose(gFiles[i]);
    return gExited ? (gExitCode & 0xff) : (rc.i & 0xff);
}
