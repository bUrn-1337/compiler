#ifndef IRGEN_H
#define IRGEN_H

#include "sema.h"
#include "ir.h"

class IrGen {
public:
    IrGen(TypeArena& types, Diag& diag) : T(types), D(diag) {}
    void run(Node* program, AnalysisResult& ar, IrModule& out);

private:
    TypeArena& T;
    Diag&      D;
    IrModule*  M  = 0;
    IrFunc*    F  = 0;
    int        labelCounter = 0;
    Type*      curRetType = 0;

    /* ---- an lvalue that has already been reduced to either a register or an
       address, so that compound assignment and ++/-- evaluate it exactly once */
    struct LV {
        bool  isReg;
        int   reg;        /* when isReg */
        Opnd  addr;       /* when !isReg */
        Type* type;
    };

    /* loop / switch targets.  Separate stacks: break takes the innermost of
       either kind, continue takes the innermost loop only. */
    struct BreakTarget { std::string label; };
    std::vector<std::string> breakStack;
    std::vector<std::string> contStack;
    std::vector<std::map<Node*, std::string> > caseLabels;

    /* ---- emission helpers ---- */
    std::string newLabel();
    int   newTemp(Type* t);
    int   newNamedReg(const std::string& name, Type* t);
    /* A compiler-created frame object -- at present only the destination of a
       struct-returning call.  Returns the slot's name. */
    std::string newTempSlot(const char* why, Type* t);
    Opnd  slotAddr(const std::string& name, Type* t);
    int   regOf(Sym* s);
    void  emit(const Instr& in);
    void  emitLabel(const std::string& l);
    Opnd  imm(long long v);
    int   toReg(const Opnd& o, Type* t);
    /* A floating constant lives in the data section (no MIPS instruction takes
       a floating immediate); this interns one and loads it into a register. */
    Opnd  floatConst(double v, Type* t);
    Type* common(Type* a, Type* b);        /* usual arithmetic conversions */
    Opnd  toTruth(Node* e);                /* value as a 0/1 integer */

    /* ---- expressions ---- */
    Opnd  rvalue(Node* e);
    Opnd  addrOf(Node* e);
    LV    lvalue(Node* e);
    Opnd  loadLV(const LV& lv);
    void  storeLV(const LV& lv, Opnd v);
    Opnd  convert(Opnd v, Type* from, Type* to);
    /* `result` is the type of the expression, `inType` the type the operands
       are combined in -- the two differ for a comparison, whose result is int
       but whose operands may be double. */
    Opnd  binop(const std::string& op, Node* ln, Node* rn, Type* result, Type* inType);
    Opnd  scaleIndex(Opnd idx, int elemSize);
    Opnd  callExpr(Node* e);
    Opnd  materializeBool(Node* e);

    /* ---- conditions: jumping code ---- */
    void  cond(Node* e, const std::string& lt, const std::string& lf, bool fallThroughIsTrue);

    /* ---- statements ---- */
    void  stmt(Node* s);
    void  block(Node* s);
    void  localDecl(Node* d);
    void  initLocal(Sym* s, Node* init);
    void  initLocalAt(Opnd base, int offset, Type* t, Node* init);

    /* ---- functions and data ---- */
    void  genFunc(FuncCtx* ctx);
    void  genGlobal(Sym* s, Node* init, AnalysisResult& ar);
    void  emitInitData(DataObj& d, Type* t, Node* init, int at, int& pos);
    void  padTo(DataObj& d, int target, int& pos);

    std::map<Sym*, int> symReg;
    /* (bit pattern, width) -> data-section name, so equal constants share one
       object and the IR stays small. */
    std::map<std::pair<unsigned long long,int>, std::string> fconstPool;
    std::map<std::string, std::string> gotoLabels;   /* source label -> IR label */
    int curLine = 0;
    int tmpSlots = 0;      /* counter for the names of compiler-created slots */
    /* The hidden result pointer of the function being generated, or -1.  A
       function that returns a struct or union by value receives the caller's
       destination address in this register and returns it. */
    int sretReg = -1;
};

#endif
