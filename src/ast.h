/* ast.h -- type system and abstract syntax tree for the IR generator.
 *
 * Everything is allocated from arenas (TypeArena / NodeArena) that own their
 * objects and free them in their destructors, so there is no manual delete
 * anywhere in the compiler and no leak (the old parser strdup'd every lexeme
 * and never freed any of them).
 */
#ifndef AST_H
#define AST_H

#include <string>
#include <vector>
#include <map>
#include <memory>

/* A diagnostic raised by the parser itself.  A few mistakes are found while
   parsing but are semantic in kind -- `typedef' on a function definition, a
   malformed character or string literal -- and, unlike a syntax error, they
   leave the tree intact, so they must not stop the semantic pass.  The parser
   collects them here and the driver hands them to the Diag, which prints every
   diagnostic in source order no matter which pass found it. */
struct ParseDiag {
    int         line;
    int         col;
    std::string msg;
};
extern std::vector<ParseDiag> g_parseDiags;

/* ================================================================= *
 *  Types
 * ================================================================= */

enum TypeKind {
    TY_ERROR,   /* produced after a semantic error, suppresses cascades */
    TY_VOID,
    TY_CHAR,
    TY_INT,
    TY_ENUM,
    TY_FLOAT,
    TY_DOUBLE,
    TY_PTR,
    TY_ARRAY,
    TY_STRUCT,
    TY_UNION,
    TY_FUNC
};

struct Type;

struct Member {
    std::string name;
    Type*       type;
    int         offset;
    int         line;
};

/* Shared body of a struct/union/enum tag.  Kept separate from Type so that
   `struct node { struct node *next; };` can refer to itself. */
struct TagInfo {
    std::string         tag;        /* "" for anonymous */
    TypeKind            kind;       /* TY_STRUCT / TY_UNION / TY_ENUM */
    bool                complete;
    std::vector<Member> members;
    int                 size;
    int                 align;
    Type*               type;       /* the canonical Type* for this tag */
    TagInfo() : kind(TY_STRUCT), complete(false), size(0), align(1), type(0) {}
};

struct Type {
    TypeKind            kind;
    Type*               base;       /* PTR/ARRAY element, FUNC return type */
    long long           nelem;      /* ARRAY length, -1 if unspecified */
    TagInfo*            tag;        /* STRUCT/UNION/ENUM */
    std::vector<Type*>  params;     /* FUNC parameter types */
    bool                variadic;   /* FUNC: ... */
    Type() : kind(TY_ERROR), base(0), nelem(-1), tag(0), variadic(false) {}
};

/* Owns every Type and TagInfo ever created. */
class TypeArena {
public:
    Type* make(TypeKind k);
    Type* ptrTo(Type* b);
    Type* arrayOf(Type* b, long long n);
    Type* func(Type* ret, const std::vector<Type*>& ps, bool variadic);
    TagInfo* makeTag(TypeKind k, const std::string& tag);

    Type* tyVoid();
    Type* tyChar();
    Type* tyInt();
    Type* tyFloat();
    Type* tyDouble();
    Type* tyError();

private:
    std::vector<std::unique_ptr<Type> >    types_;
    std::vector<std::unique_ptr<TagInfo> > tags_;
    Type* void_ = 0; Type* char_ = 0; Type* int_ = 0; Type* err_ = 0;
    Type* float_ = 0; Type* double_ = 0;
};

/* ---- the single place where sizes, alignments and offsets are decided ---- */
int  typeSize (const Type* t);
int  typeAlign(const Type* t);
void layoutTag(TagInfo* ti);               /* fills member offsets, size, align */
int  alignUp(int v, int a);

bool isInteger  (const Type* t);           /* char, int, enum */
bool isFloat    (const Type* t);           /* float, double */
bool isArith    (const Type* t);           /* integer or floating */
bool isScalar   (const Type* t);           /* arithmetic or pointer */
bool isPointer  (const Type* t);
bool isArray    (const Type* t);
bool isAggregate(const Type* t);           /* struct or union */
bool isVoid     (const Type* t);
bool isError    (const Type* t);
bool sameType   (const Type* a, const Type* b);
std::string typeName(const Type* t);       /* human-readable, for diagnostics */
std::string irTypeTag(const Type* t);      /* int | char | float | double | ptr | str | agg | void */

/* Rank used by the usual arithmetic conversions: char/int/enum < float < double.
   Returns 0 for a non-arithmetic type. */
int  arithRank(const Type* t);

/* The one-letter IR suffix for a floating type: 's' for float, 'd' for double. */
char floatSuffix(const Type* t);

/* ================================================================= *
 *  AST
 * ================================================================= */

enum NodeKind {
    /* ---- declarator shapes (consumed during semantic analysis) ---- */
    N_DCL_NAME, N_DCL_PTR, N_DCL_ARRAY, N_DCL_FUNC,

    /* ---- declarations ---- */
    N_PROGRAM,
    N_DECL,            /* a declaration: kids = init-declarators */
    N_INIT_DECL,       /* kid0 = declarator, kid1 = initializer or null */
    N_FUNCDEF,         /* kid0 = declarator, kid1 = body */
    N_PARAM,           /* kid0 = declarator or null (abstract) */
    N_TYPESPEC,        /* a parsed type specifier; ival = TypeKind-ish, see sema */
    N_STRUCTSPEC,      /* sval = tag, kids = member N_DECLs, ival = 1 if union  */
    N_ENUMSPEC,        /* sval = tag, kids = N_ENUMERATORs */
    N_ENUMERATOR,      /* sval = name, kid0 = value expr or null */
    N_INIT_LIST,       /* braced initializer, kids = elements */

    /* ---- statements ---- */
    N_COMPOUND, N_EXPRSTMT, N_IF, N_SWITCH, N_WHILE, N_UNTIL, N_DO, N_FOR,
    N_GOTO, N_CONTINUE, N_BREAK, N_RETURN, N_LABEL, N_CASE, N_DEFAULT,
    N_EMPTY,

    /* ---- expressions ---- */
    N_ID, N_ICONST, N_CCONST, N_SCONST, N_FCONST,
    N_BINOP, N_UNOP, N_ASSIGN, N_COND, N_COMMA,
    N_PREINC, N_PREDEC, N_POSTINC, N_POSTDEC,
    N_ADDR, N_DEREF, N_INDEX, N_CALL, N_MEMBER, N_ARROW,
    N_SIZEOF_EXPR, N_SIZEOF_TYPE, N_CAST, N_TYPENAME,
    N_ARGLIST
};

struct Sym;   /* forward: symbol table entry, defined in sema.h */

struct Node {
    NodeKind                kind;
    int                     line;
    int                     col;
    std::string             sval;     /* identifier / operator spelling / string bytes */
    long long               ival;     /* integer constant, operator code, flags */
    std::vector<Node*>      kids;

    /* ---- annotations filled in by semantic analysis ---- */
    Type*                   type   = 0;
    Sym*                    sym    = 0;
    bool                    lvalue = false;
    bool                    decayed = false;   /* array/function decayed to pointer */
    Type*                   origType = 0;      /* type before decay, if decayed */
    bool                    isConst = false;   /* integer constant expression */
    long long               constVal = 0;
    bool                    isFConst = false;  /* floating constant expression */
    double                  fconstVal = 0;
    Type*                   cmpType = 0;       /* N_BINOP relational: the type
                                                  the two operands are compared
                                                  in (int, float or double) */
    const Member*           member = 0;        /* for N_MEMBER / N_ARROW */
    std::string             aux;               /* N_SCONST: data-section label  */
    std::vector<Node*>      extra;             /* N_SWITCH: its case/default nodes */

    Node(NodeKind k, int ln, int cl) : kind(k), line(ln), col(cl), ival(0) {}
    Node* kid(size_t i) const { return i < kids.size() ? kids[i] : 0; }

    /* A constant whose value is usable as a floating one: either a floating
       constant expression or an integer one (which converts exactly here). */
    bool   hasFConst() const { return isFConst || isConst; }
    double fvalue()    const { return isFConst ? fconstVal : (double)constVal; }
};

/* Owns every Node.  The parser allocates through the global arena below so
   that nodes dropped by error recovery are still freed. */
class NodeArena {
public:
    Node* make(NodeKind k, int line, int col);
    void  clear();
private:
    std::vector<std::unique_ptr<Node> > nodes_;
};

extern NodeArena* g_nodes;
extern TypeArena* g_types;

Node* mk(NodeKind k, int line, int col);
Node* mk1(NodeKind k, int line, int col, Node* a);
Node* mk2(NodeKind k, int line, int col, Node* a, Node* b);
Node* mk3(NodeKind k, int line, int col, Node* a, Node* b, Node* c);

/* Decode a C character literal / string literal lexeme (quotes included,
   escapes unprocessed) into raw bytes.  Returns false on a malformed literal. */
bool decodeCharLiteral(const std::string& lexeme, long long* out);
bool decodeStringLiteral(const std::string& lexeme, std::string* out);
long long parseIntLiteral(const std::string& lexeme);

/* Decode a floating constant lexeme.  *isFloat is set when the lexeme carries
   an f/F suffix (so the constant has type `float`); otherwise the constant has
   type `double`, as in C.  Returns false only on a lexeme strtod rejects. */
bool parseFloatLiteral(const std::string& lexeme, double* out, bool* isFloat);

/* Exact, round-tripping decimal spelling of a float/double, for the IR text. */
std::string floatImage(double v, bool single);

/* Lexeme pool: the lexer hands the parser stable `const char*` values owned
   here, instead of strdup'ing every lexeme and never freeing it. */
const char* internLexeme(const char* s);
void        clearLexemePool();

#endif
