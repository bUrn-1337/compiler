/* sema.h -- diagnostics, scoped symbol table, and the semantic analysis pass.
 *
 * Analysis annotates the AST in place: every N_ID gets its Sym*, every
 * expression gets its Type*, every local gets its storage class (frame slot vs
 * virtual register) and, for slots, its frame offset.  The IR generator then
 * only reads those annotations -- it never resolves a name again.
 */
#ifndef SEMA_H
#define SEMA_H

#include "ast.h"
#include "ir.h"
#include <string>
#include <vector>
#include <map>
#include <set>
#include <iostream>

/* ================= diagnostics ================= */

struct Diag {
    /* Messages are collected rather than printed as they are found, because
       analysis does not visit the program in source order (goto labels, for
       instance, are only checked once a whole function body has been read).
       flush() sorts them so the user always reads them top to bottom. */
    struct Msg { int line; int col; std::string text; };
    int count;
    std::vector<Msg> msgs;
    Diag() : count(0) {}
    void error(int line, int col, const std::string& msg);
    void flush(std::ostream& os) const;
};

/* ================= symbols ================= */

enum SymKind { SK_VAR, SK_PARAM, SK_GLOBAL, SK_FUNC, SK_TYPEDEF, SK_ENUMCONST };

struct FuncCtx;

struct Sym {
    SymKind     kind;
    std::string name;        /* as written in the source */
    std::string uniq;        /* unique within its function (shadowing resolved) */
    Type*       type;
    int         line;

    /* locals / params */
    bool        addrTaken;
    bool        inMemory;    /* true -> frame slot; false -> virtual register */
    int         offset;      /* frame slot offset */
    int         reg;         /* virtual register index, when !inMemory */

    /* enum constants */
    long long   enumVal;

    /* functions */
    bool        defined;     /* has a body */
    bool        isExternal;  /* a built-in runtime function (printf, malloc, ...) */
    bool        used;
    FuncCtx*    ctx;

    Sym() : kind(SK_VAR), type(0), line(0), addrTaken(false), inMemory(false),
            offset(0), reg(-1), enumVal(0), defined(false), isExternal(false),
            used(false), ctx(0) {}
};

struct FuncCtx {
    Sym*               sym;
    Node*              body;
    std::vector<Sym*>  order;      /* params then locals, in declaration order */
    int                frameSize;
    FuncCtx() : sym(0), body(0), frameSize(0) {}
};

/* ================= scoped symbol table =================
 * Two independent namespaces, exactly as in C: ordinary identifiers (which
 * includes typedef names) and struct/union/enum tags.
 */
class SymTab {
public:
    SymTab();
    void push();
    void pop();
    int  depth() const { return (int)ord_.size(); }

    Sym* declare(const std::string& name, SymKind k, Type* t, int line, bool* redecl);
    Sym* lookup(const std::string& name) const;         /* all scopes */
    Sym* lookupLocal(const std::string& name) const;    /* innermost scope only */

    TagInfo* declareTag(TagInfo* ti);
    TagInfo* lookupTag(const std::string& tag) const;
    TagInfo* lookupTagLocal(const std::string& tag) const;

    /* Hand every Sym this table created over to `dest`; the table keeps its
       (now non-owning) scope maps so lookups still work. */
    void takeOwnership(std::vector<std::unique_ptr<Sym> >& dest);

private:
    std::vector<std::map<std::string, Sym*> >     ord_;
    std::vector<std::map<std::string, TagInfo*> > tags_;
    std::vector<std::unique_ptr<Sym> >           pool_;
};

/* ================= the analysis pass ================= */

struct AnalysisResult {
    /* Ownership of every Sym and FuncCtx is handed over here when analysis
       finishes, because the IR generator reads them long after the Sema object
       (and its symbol table) have gone out of scope. */
    std::vector<std::unique_ptr<Sym> >     symPool;
    std::vector<std::unique_ptr<FuncCtx> > ctxPool;

    std::vector<Sym*>                              globals;    /* in declaration order */
    std::vector<std::pair<std::string, std::string> > strings;  /* label -> raw bytes */
    std::vector<FuncCtx*>                          funcs;      /* in definition order */
    std::vector<Sym*>                              externsUsed;
    std::map<Sym*, Node*>                          globalInit; /* global -> initializer */
};

class Sema {
public:
    Sema(TypeArena& types, Diag& diag) : T(types), D(diag) {}
    void run(Node* program, AnalysisResult& out);

    /* Stage 4: set when compiling the runtime library (src/runtime/rt_lib.c)
       rather than a user program.  The library functions are then *defined*
       by the file instead of being built in, `main' is not required, and a
       prototype without a body names a hand-written assembly routine. */
    bool runtimeMode = false;

private:
    TypeArena& T;
    Diag&      D;
    SymTab     S;
    AnalysisResult* R = 0;

    /* current function state */
    FuncCtx*   fn = 0;
    Type*      retType = 0;
    int        loopDepth = 0;
    int        switchDepth = 0;
    std::vector<std::set<long long> > caseVals;
    std::vector<bool>                 hasDefault;
    std::map<std::string, int>        labelsDefined;
    std::map<std::string, std::pair<int,int> > labelsUsed;   /* name -> first use line, col */
    std::set<std::string>             usedNames;   /* for uniquifying locals */
    /* Names already reported as undeclared in the function being analysed, so
       that one missing declaration produces one message (Sema::firstUndeclared). */
    std::set<std::string>             undeclSeen;

    /* declarations */
    Type* typeSpec(Node* spec);
    Type* buildType(Type* base, Node* dcl, std::string* name);
    void  declaration(Node* d, bool atFileScope);
    void  funcDefinition(Node* f);
    void  structSpec(Node* n, Type** out);
    /* True the first time `name' is reported as undeclared in this function. */
    bool  firstUndeclared(const std::string& name);
    void  enumSpec(Node* n, Type** out);

    /* statements and expressions */
    void  stmt(Node* s);
    void  block(Node* s);
    Type* expr(Node* e);
    Node* unknownTypeDeclShape(Node* e);   /* 'Foo *p;' at block scope, or null */
    void  condition(Node* e);

    /* helpers */
    Sym*  declareLocal(const std::string& name, SymKind k, Type* t, int line, int col);
    void  markAddrTaken(Node* e);
    Type* decay(Node* e);
    Type* usualArith(Type* a, Type* b);    /* the usual arithmetic conversions */
    /* report a binary operator's operands once, and give it the error type */
    Type* badOperands(Node* e, Type* lt, Type* rt, const std::string& why);
    void  checkAssignable(Type* lhs, Type* rhs, Node* at, const char* what);
    void  checkCall(Node* call);
    /* mark a function symbol as referenced, and remember it if it is one of
       the runtime externals, which the IR must then declare */
    void  useFunc(Sym* s);
    void  initializer(Node* init, Type* t, Node* at, bool isGlobal);
    long long constExpr(Node* e, bool* ok);
    std::string internString(const std::string& bytes);
    void  assignStorage();
    void  registerBuiltins();
    Sym*  builtin(const std::string& name);

    std::map<std::string, std::string> strPool;
    std::map<std::string, Sym*>        builtinPool;
    int strCounter = 0;
};

/* Is e (an analysed initializer) an address constant: the address of a
   global object, or of an element or member inside one at a constant
   offset (&g, &a[2], &s.m, &a[1][2].x, or an array name that decayed)?
   If so, *sym and *off receive the global's IR name and the byte offset.
   Stage 4: Stage 3 accepted any &... at file scope and emitted 0 for
   everything but &g. */
bool addressConstant(const Node* e, std::string* sym, long long* off);

#endif
