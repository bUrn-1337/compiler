/* ir.h -- in-memory form of the three-address IR, plus the text writer.
 * The text format produced here is specified in docs/IR-DESIGN.md and is what
 * tools/irsim (the interpreter) and tools/ircheck.py (the validator) parse.
 */
#ifndef IR_H
#define IR_H

#include <string>
#include <vector>
#include <map>
#include <ostream>

enum IrOp {
    IR_LABEL,        /* label:                                   */
    IR_COPY,         /* dst = a                                  */
    IR_BIN,          /* dst = a <sop> b     sop may carry .s/.d  */
    IR_UN,           /* dst = <sop> a       sop may carry .s/.d  */
    IR_SEXTB,        /* dst = sext.b a                           */
    IR_CVT,          /* dst = <sop> a       sop = cvt./trunc.    */
    IR_ADDR_LOCAL,   /* dst = addr name                          */
    IR_ADDR_GLOBAL,  /* dst = addr @name                         */
    IR_FADDR,        /* dst = faddr @name   address of a function*/
    IR_LOAD,         /* dst = load.w/.b/.s/.d a                  */
    IR_STORE,        /* store.w/.b/.s/.d a, b                    */
    IR_BLKCOPY,      /* blkcopy a, b, size n align k  (memmove)  */
    IR_MEMZERO,      /* memzero a, n                             */
    IR_GOTO,         /* goto label                               */
    IR_IF,           /* if a goto label                          */
    IR_IFFALSE,      /* ifFalse a goto label                     */
    IR_PARAM,        /* param a : tag [size n align k] [sret]    */
    IR_CALL,         /* [dst =] call @name, n   -- direct        */
                     /* [dst =] call a, n       -- indirect      */
    IR_RETURN        /* return [a]                               */
};

struct Opnd {
    enum Kind { NONE, REG, IMM } kind;
    int        reg;
    long long  imm;
    Opnd() : kind(NONE), reg(-1), imm(0) {}
    static Opnd none()        { return Opnd(); }
    static Opnd r(int i)      { Opnd o; o.kind = REG; o.reg = i; return o; }
    static Opnd c(long long v){ Opnd o; o.kind = IMM; o.imm = v; return o; }
};

struct Instr {
    IrOp        op;
    int         dst;        /* destination register index, or -1 */
    Opnd        a, b;
    std::string sop;        /* operator text, or "w"/"b"/"s"/"d" for load/store */
    std::string label;      /* label, callee, global or local name */
    long long   n;          /* call arg count / blkcopy size */
    long long   align;      /* blkcopy alignment, param alignment */
    std::string tag;        /* param type tag */
    bool        sret;       /* IR_PARAM: this is the hidden result pointer */
    bool        indirect;   /* IR_CALL: callee is the register in `a`  */
    int         line;       /* source line, for a trailing comment */
    Instr() : op(IR_LABEL), dst(-1), n(0), align(0), sret(false),
              indirect(false), line(0) {}
};

/* A frame slot: a local, parameter or compiler-created object that lives in
   memory because its address is taken (or because it is an array/struct). */
struct Slot {
    std::string name;       /* unique within the function */
    std::string ctype;      /* human-readable declared type */
    std::string tag;        /* int|char|float|double|ptr|str|agg */
    int         size;
    int         align;
    int         offset;     /* bytes from the base of the frame's local area */
};

struct ParamInfo {
    std::string name;
    std::string ctype;
    std::string tag;
    int         size;
    int         align;
    bool        inSlot;     /* true: lives at slotOffset; false: lives in reg */
    int         slotOffset;
    int         reg;        /* register index when !inSlot, or the incoming
                               pointer register when byVal */
    bool        byVal;      /* struct/union passed by value: `reg` holds the
                               caller's address and the prologue copies it into
                               slotOffset, so the callee owns its own copy */
    bool        sret;       /* the hidden result pointer of an sret function */
    ParamInfo() : size(0), align(1), inSlot(false), slotOffset(0), reg(-1),
                  byVal(false), sret(false) {}
};

struct RegInfo {
    std::string name;       /* "t7" for anonymous temporaries */
    std::string ctype;
    std::string tag;
    bool        named;
};

struct IrFunc {
    std::string            name;
    std::string            retTag;
    std::string            retCType;
    std::vector<ParamInfo> params;
    std::vector<Slot>      slots;
    std::vector<RegInfo>   regs;
    std::vector<Instr>     code;
    int                    frameSize;
    int                    line;
    bool                   sret;      /* returns a struct/union by value through
                                         the hidden pointer in parameter 0 */
    int                    retSize;   /* sret only: size/align of the result */
    int                    retAlign;
    IrFunc() : frameSize(0), line(0), sret(false), retSize(0), retAlign(1) {}
};

/* A data-section object: a global variable or a string literal. */
struct DataObj {
    std::string name;
    std::string ctype;
    std::string tag;
    int         size;
    int         align;
    bool        isString;
    std::string bytes;               /* string literal contents, no NUL */
    /* initializer: a list of (width, value) pieces laid out in order, or a
       single zero-fill when the global has no initializer.  A piece is a
       floating one when isFloat is set, in which case fval (not value) holds
       it and width is 4 (init.float) or 8 (init.double).  `sym` names a
       global or a function whose address is the piece's value. */
    struct Piece {
        int         width;
        long long   value;
        bool        zero;
        std::string sym;
        bool        isFloat;
        double      fval;
        bool        isFunc;        /* sym names a function, not an object */
        long long   symOff;        /* init.addr @sym+symOff (Stage 4)       */
        Piece() : width(4), value(0), zero(false), isFloat(false), fval(0),
                  isFunc(false), symOff(0) {}
    };
    std::vector<Piece> init;
    DataObj() : size(0), align(1), isString(false) {}
};

struct ExternFunc {
    std::string name;
    std::string retTag;
    int         nparams;
    bool        variadic;
};

struct IrModule {
    std::vector<DataObj>    data;
    std::vector<ExternFunc> externs;
    std::vector<IrFunc>     funcs;
    std::string             sourceName;
};

void writeIr(std::ostream& os, const IrModule& m);
/* One instruction as writeIr prints it (no indentation, no newline). */
std::string irInstrText(const IrFunc& f, const Instr& in);

#endif
