#include "sema.h"
#include <sstream>
#include <algorithm>
#include <cstdio>

/* ================= diagnostics ================= */

void Diag::error(int line, int col, const std::string& msg) {
    std::ostringstream os;
    /* A few checks are about the file as a whole (a missing 'main') and have no
       position at all; those print no bracket rather than "[Line 0]". */
    os << "Semantic Error";
    if (line > 0) {
        os << " [Line " << line;
        if (col > 0) os << ", Col " << col;
        os << "]";
    }
    os << ": " << msg;
    Msg m; m.line = line; m.col = col; m.text = os.str();
    msgs.push_back(m);
    ++count;
}
static bool byPosition(const Diag::Msg& a, const Diag::Msg& b) {
    if (a.line != b.line) return a.line < b.line;
    return a.col < b.col;
}
void Diag::flush(std::ostream& os) const {
    std::vector<Msg> sorted = msgs;
    std::stable_sort(sorted.begin(), sorted.end(), byPosition);
    for (size_t i = 0; i < sorted.size(); ++i) os << sorted[i].text << "\n";
}

/* ================= symbol table ================= */

SymTab::SymTab() { push(); }

void SymTab::takeOwnership(std::vector<std::unique_ptr<Sym> >& dest) {
    for (size_t i = 0; i < pool_.size(); ++i) dest.push_back(std::move(pool_[i]));
    pool_.clear();
}
void SymTab::push() { ord_.push_back(std::map<std::string,Sym*>());
                      tags_.push_back(std::map<std::string,TagInfo*>()); }
void SymTab::pop()  { if (ord_.size() > 1) { ord_.pop_back(); tags_.pop_back(); } }

Sym* SymTab::declare(const std::string& name, SymKind k, Type* t, int line, bool* redecl) {
    std::map<std::string,Sym*>& sc = ord_.back();
    std::map<std::string,Sym*>::iterator it = sc.find(name);
    if (it != sc.end()) { if (redecl) *redecl = true; return it->second; }
    if (redecl) *redecl = false;
    pool_.push_back(std::unique_ptr<Sym>(new Sym()));
    Sym* s = pool_.back().get();
    s->kind = k; s->name = name; s->uniq = name; s->type = t; s->line = line;
    sc[name] = s;
    return s;
}
Sym* SymTab::lookup(const std::string& name) const {
    for (size_t i = ord_.size(); i-- > 0;) {
        std::map<std::string,Sym*>::const_iterator it = ord_[i].find(name);
        if (it != ord_[i].end()) return it->second;
    }
    return 0;
}
Sym* SymTab::lookupLocal(const std::string& name) const {
    std::map<std::string,Sym*>::const_iterator it = ord_.back().find(name);
    return it == ord_.back().end() ? 0 : it->second;
}
TagInfo* SymTab::declareTag(TagInfo* ti) { tags_.back()[ti->tag] = ti; return ti; }
TagInfo* SymTab::lookupTag(const std::string& tag) const {
    for (size_t i = tags_.size(); i-- > 0;) {
        std::map<std::string,TagInfo*>::const_iterator it = tags_[i].find(tag);
        if (it != tags_[i].end()) return it->second;
    }
    return 0;
}
TagInfo* SymTab::lookupTagLocal(const std::string& tag) const {
    std::map<std::string,TagInfo*>::const_iterator it = tags_.back().find(tag);
    return it == tags_.back().end() ? 0 : it->second;
}

/* ================= built-in external functions =================
 * This source language has no preprocessor, so there are no header files to
 * declare the C runtime.  These prototypes are therefore built in; anything
 * NOT in this table and not defined in the file is "call to undeclared
 * function".
 */
namespace {
struct BuiltinSpec { const char* name; const char* ret; const char* params; bool variadic; };

/* ret/params letters:  v void  i int  c char  p void*  s char*  F FILE*  . */
const BuiltinSpec kBuiltins[] = {
    { "printf",   "i", "s",    true  },
    { "scanf",    "i", "s",    true  },
    { "sprintf",  "i", "ss",   true  },
    { "sscanf",   "i", "ss",   true  },
    { "puts",     "i", "s",    false },
    { "putchar",  "i", "i",    false },
    { "getchar",  "i", "",     false },
    { "malloc",   "p", "i",    false },
    { "calloc",   "p", "ii",   false },
    { "realloc",  "p", "pi",   false },
    { "free",     "v", "p",    false },
    { "exit",     "v", "i",    false },
    { "abs",      "i", "i",    false },
    { "atoi",     "i", "s",    false },
    { "strlen",   "i", "s",    false },
    { "strcpy",   "s", "ss",   false },
    { "strncpy",  "s", "ssi",  false },
    { "strcat",   "s", "ss",   false },
    { "strcmp",   "i", "ss",   false },
    { "strncmp",  "i", "ssi",  false },
    { "strchr",   "s", "si",   false },
    { "memset",   "p", "pii",  false },
    { "memcpy",   "p", "ppi",  false },
    { "fopen",    "F", "ss",   false },
    { "fclose",   "i", "F",    false },
    { "fprintf",  "i", "Fs",   true  },
    { "fscanf",   "i", "Fs",   true  },
    { "fgets",    "s", "siF",  false },
    { "fputs",    "i", "sF",   false },
    { "fgetc",    "i", "F",    false },
    { "fputc",    "i", "iF",   false },
    { "feof",     "i", "F",    false },
    { "rewind",   "v", "F",    false },
    { "remove",   "i", "s",    false },
};
const int kNumBuiltins = (int)(sizeof(kBuiltins) / sizeof(kBuiltins[0]));
}

/* Declares the library the language provides, in a scope below file
   scope: the opaque FILE struct and every function in kBuiltins, whose
   return and parameter types are spelled as one-letter codes. */
void Sema::registerBuiltins() {
    /* FILE is an opaque incomplete struct; the lexer pre-seeds "FILE" as a
       typedef name so that `FILE *fp;` parses. */
    TagInfo* fileTag = T.makeTag(TY_STRUCT, "FILE");
    fileTag->complete = false;
    S.declareTag(fileTag);
    bool dup = false;
    S.declare("FILE", SK_TYPEDEF, fileTag->type, 0, &dup);

    Type* tFile = T.ptrTo(fileTag->type);
    Type* tStr  = T.ptrTo(T.tyChar());
    Type* tVoidP= T.ptrTo(T.tyVoid());

    /* Stage 4 runtime mode: the library is being defined, not used. */
    for (int i = 0; i < (runtimeMode ? 0 : kNumBuiltins); ++i) {
        const BuiltinSpec& b = kBuiltins[i];
        Type* ret = T.tyInt();
        switch (b.ret[0]) {
            case 'v': ret = T.tyVoid(); break;
            case 'p': ret = tVoidP; break;
            case 's': ret = tStr; break;
            case 'F': ret = tFile; break;
            default:  ret = T.tyInt();
        }
        std::vector<Type*> ps;
        for (const char* c = b.params; *c; ++c) {
            switch (*c) {
                case 'i': ps.push_back(T.tyInt()); break;
                case 'c': ps.push_back(T.tyChar()); break;
                case 'p': ps.push_back(tVoidP); break;
                case 's': ps.push_back(tStr); break;
                case 'F': ps.push_back(tFile); break;
            }
        }
        Sym* s = S.declare(b.name, SK_FUNC, T.func(ret, ps, b.variadic), 0, &dup);
        s->isExternal = true;
        s->defined = true;
        builtinPool[b.name] = s;
    }
}

/* ================= type specifiers and declarators ================= */

/* Maps a type-specifier node to its type: the basic types, a typedef
   name looked up in the current scopes, or a struct/union/enum specifier
   (which may define the tag as a side effect). */
Type* Sema::typeSpec(Node* spec) {
    if (!spec) return T.tyInt();
    switch (spec->kind) {
        case N_TYPESPEC:
            switch (spec->ival) {
                case 0: return T.tyInt();
                case 1: return T.tyChar();
                case 2: return T.tyFloat();
                case 3: return T.tyDouble();
                case 4: return T.tyVoid();
                case 5: {
                    Sym* s = S.lookup(spec->sval);
                    if (!s || s->kind != SK_TYPEDEF) {
                        D.error(spec->line, spec->col,
                                "unknown type name '" + spec->sval + "'");
                        return T.tyError();
                    }
                    return s->type;
                }
                /* A plain identifier used where a type belongs; the parser
                   recognised the declaration and left the name here (see
                   unknownTypeDecl in parser.y). */
                case 6:
                    D.error(spec->line, spec->col,
                            "unknown type name '" + spec->sval +
                            "' (if this is a typedef name, the typedef must appear "
                            "before this point and in an enclosing scope)");
                    return T.tyError();
                default: return T.tyInt();
            }
        case N_STRUCTSPEC: { Type* t = 0; structSpec(spec, &t); return t; }
        case N_ENUMSPEC:   { Type* t = 0; enumSpec(spec, &t);   return t; }
        default: return T.tyInt();
    }
}

/* Analyses a struct or union specifier.  Looks the tag up (in the current
   scope only when the body is being defined, so an inner definition hides
   an outer one), creates an incomplete type for a new tag, and for a body
   checks the members (no duplicates, no incomplete or function members) and
   lays them out: offsets aligned to each member, size rounded up to the
   largest alignment, every union member at offset 0. */
void Sema::structSpec(Node* n, Type** out) {
    TypeKind k = (n->ival & 1) ? TY_UNION : TY_STRUCT;
    const std::string& tag = n->sval;
    bool hasBody = !n->kids.empty() || n->ival & 2;
    bool defining = (n->ival & 2) != 0;   /* bit 1 of ival marks "{...} present" */

    TagInfo* ti = 0;
    if (!tag.empty()) {
        ti = defining ? S.lookupTagLocal(tag) : S.lookupTag(tag);
        if (ti && ti->kind != k) {
            D.error(n->line, n->col, "'" + tag + "' was declared as a different kind of tag");
            *out = T.tyError();
            return;
        }
    }
    if (!ti) {
        ti = T.makeTag(k, tag);
        if (!tag.empty()) S.declareTag(ti);
    }
    *out = ti->type;

    if (!defining) {
        (void)hasBody;
        return;   /* a reference like `struct node *p;` -- may stay incomplete */
    }
    if (ti->complete) {
        D.error(n->line, n->col, "redefinition of " +
                std::string(k == TY_UNION ? "union '" : "struct '") + tag + "'");
        return;
    }

    /* Members live in their own scope for tag purposes, but member names are
       recorded on the TagInfo, not in the identifier namespace. */
    for (size_t i = 0; i < n->kids.size(); ++i) {
        Node* d = n->kids[i];
        if (d->kind != N_DECL) continue;
        if (d->ival & 1) {
            D.error(d->line, d->col, "a struct/union member cannot be a typedef");
            continue;
        }
        Type* base = typeSpec(d->kid(0));
        for (size_t j = 1; j < d->kids.size(); ++j) {
            Node* idl = d->kids[j];
            std::string nm;
            Type* mt = buildType(base, idl->kid(0), &nm);
            if (idl->kid(1))
                D.error(idl->line, idl->col, "a struct/union member cannot have an initializer");
            if (nm.empty()) { D.error(idl->line, idl->col, "unnamed struct/union member"); continue; }
            bool dupName = false;
            for (size_t m = 0; m < ti->members.size(); ++m)
                if (ti->members[m].name == nm) dupName = true;
            if (dupName) {
                D.error(idl->line, idl->col, "duplicate member '" + nm + "' in " + typeName(ti->type));
                continue;
            }
            if (mt->kind == TY_FUNC) {
                D.error(idl->line, idl->col, "a struct/union member cannot have function type");
                continue;
            }
            if (isVoid(mt)) {
                D.error(idl->line, idl->col, "member '" + nm + "' has incomplete type void");
                continue;
            }
            if (isAggregate(mt) && mt->tag && !mt->tag->complete) {
                D.error(idl->line, idl->col,
                        "member '" + nm + "' has incomplete type " + typeName(mt));
                continue;
            }
            if (isArray(mt) && mt->nelem < 0) {
                D.error(idl->line, idl->col, "member '" + nm + "' has incomplete array type");
                continue;
            }
            Member mem;
            mem.name = nm; mem.type = mt; mem.offset = 0; mem.line = idl->line;
            ti->members.push_back(mem);
        }
    }
    ti->complete = true;
    layoutTag(ti);
}

/* Analyses an enum specifier: checks the tag, and for a body declares each
   enumerator as an int constant whose value is the explicit constant
   expression or one more than the previous value. */
void Sema::enumSpec(Node* n, Type** out) {
    const std::string& tag = n->sval;
    bool defining = (n->ival & 2) != 0;
    TagInfo* ti = 0;
    if (!tag.empty()) {
        ti = defining ? S.lookupTagLocal(tag) : S.lookupTag(tag);
        if (ti && ti->kind != TY_ENUM) {
            D.error(n->line, n->col, "'" + tag + "' was declared as a different kind of tag");
            *out = T.tyError();
            return;
        }
    }
    if (!ti) {
        ti = T.makeTag(TY_ENUM, tag);
        if (!tag.empty()) S.declareTag(ti);
    }
    *out = ti->type;
    if (!defining) return;
    if (ti->complete) {
        D.error(n->line, n->col, "redefinition of enum '" + tag + "'");
        return;
    }
    long long next = 0;
    for (size_t i = 0; i < n->kids.size(); ++i) {
        Node* e = n->kids[i];
        if (e->kid(0)) {
            bool ok = true;
            long long v = constExpr(e->kid(0), &ok);
            if (!ok) D.error(e->line, e->col,
                             "enumerator '" + e->sval + "' is not an integer constant expression");
            else next = v;
        }
        bool redecl = false;
        Sym* s = S.declare(e->sval, SK_ENUMCONST, ti->type, e->line, &redecl);
        if (redecl)
            D.error(e->line, e->col, "redeclaration of '" + e->sval + "' in the same scope "
                    "(previous declaration on line " + std::to_string(s->line) + ")");
        else
            s->enumVal = next;
        e->ival = next;
        ++next;
    }
    ti->complete = true;
    layoutTag(ti);
}

/* The name node of a declarator, which is where a diagnostic about the object
   being declared points -- the declarator's own position is that of its
   pointer prefix or its opening parenthesis.  The parser already does this for
   an init-declarator; a parameter and a function definition's declarator are
   reached from here instead. */
static Node* declNameOf(Node* dcl) {
    while (dcl && dcl->kind != N_DCL_NAME) dcl = dcl->kid(0);
    return dcl;
}

/* Apply a declarator to a base type, innermost derivation first, and hand
   back the declared name ("" for an abstract declarator). */
Type* Sema::buildType(Type* base, Node* dcl, std::string* name) {
    if (!dcl) { if (name) name->clear(); return base; }
    switch (dcl->kind) {
        case N_DCL_NAME:
            if (name) *name = dcl->sval;
            return base;
        case N_DCL_PTR:
            return buildType(T.ptrTo(base), dcl->kid(0), name);
        case N_DCL_ARRAY: {
            long long n = -1;
            if (dcl->kid(1)) {
                bool ok = true;
                n = constExpr(dcl->kid(1), &ok);
                if (!ok) {
                    D.error(dcl->line, dcl->col, "array size is not an integer constant expression");
                    n = 1;
                } else if (n <= 0) {
                    D.error(dcl->line, dcl->col, "array size must be positive");
                    n = 1;
                }
            }
            if (isVoid(base) || base->kind == TY_FUNC)
                D.error(dcl->line, dcl->col, "cannot declare an array of " + typeName(base));
            return buildType(T.arrayOf(base, n), dcl->kid(0), name);
        }
        case N_DCL_FUNC: {
            std::vector<Type*> ps;
            bool variadic = false;
            Node* pl = dcl->kid(1);
            if (pl) {
                for (size_t i = 0; i < pl->kids.size(); ++i) {
                    Node* p = pl->kids[i];
                    Type* pb = typeSpec(p->kid(0));
                    std::string pn;
                    Type* pt = buildType(pb, p->kid(1), &pn);
                    if (isArray(pt)) pt = T.ptrTo(pt->base);        /* decays */
                    if (pt->kind == TY_FUNC) pt = T.ptrTo(pt);
                    if (isVoid(pt) && pl->kids.size() == 1 && pn.empty()) {
                        /* f(void) -- zero parameters */
                        break;
                    }
                    if (isVoid(pt)) {
                        D.error(p->line, p->col, "parameter has incomplete type void");
                        pt = T.tyError();
                    }
                    ps.push_back(pt);
                    p->type = pt;
                    p->sval = pn;
                }
            }
            if (isArray(base))
                D.error(dcl->line, dcl->col, "a function cannot return an array type");
            /* `typedef int F(int); F g(void);' -- a return type that is itself
               a function.  C forbids it for the same reason as an array: the
               value would have no size to return.  It is reachable only
               through a typedef, since a declarator cannot spell it directly
               (`int g(void)(int)' builds the same tree and is caught here
               too), which is why it needs its own check rather than being
               ruled out by the grammar. */
            if (base->kind == TY_FUNC)
                D.error(dcl->line, dcl->col, "a function cannot return a function type");
            return buildType(T.func(base, ps, variadic), dcl->kid(0), name);
        }
        default:
            if (name) name->clear();
            return base;
    }
}

/* ================= declarations ================= */

Sym* Sema::declareLocal(const std::string& name, SymKind k, Type* t, int line, int col) {
    bool redecl = false;
    Sym* s = S.declare(name, k, t, line, &redecl);
    if (redecl) {
        D.error(line, col, "redeclaration of '" + name + "' in the same scope "
                "(previous declaration on line " + std::to_string(s->line) + ")");
        return s;
    }
    /* make the name unique within the function so that shadowed locals get
       distinct frame slots / registers in the IR */
    std::string u = name;
    int n = 1;
    while (usedNames.count(u)) { u = name + "." + std::to_string(n++); }
    usedNames.insert(u);
    s->uniq = u;
    if (fn) fn->order.push_back(s);
    return s;
}

/* Analyses a declaration: builds each declarator's type from the shared
   base type, rejects void objects, conflicting redeclarations and invalid
   storage, enters the names into the current scope (typedef names as
   types), and checks initializers -- at file scope they must be constant
   expressions or address constants. */
void Sema::declaration(Node* d, bool atFileScope) {
    bool isTypedef = (d->ival & 1) != 0;
    Type* base = typeSpec(d->kid(0));

    if (d->kids.size() == 1) return;    /* e.g. `struct point { ... };` */

    for (size_t i = 1; i < d->kids.size(); ++i) {
        Node* idl = d->kids[i];
        std::string name;
        Type* t = buildType(base, idl->kid(0), &name);
        if (name.empty()) {
            D.error(idl->line, idl->col, "declaration declares nothing");
            continue;
        }
        idl->type = t;

        if (isTypedef) {
            if (idl->kid(1)) D.error(idl->line, idl->col, "a typedef cannot have an initializer");
            bool redecl = false;
            Sym* s = S.declare(name, SK_TYPEDEF, t, idl->line, &redecl);
            if (redecl)
                D.error(idl->line, idl->col, "redeclaration of '" + name + "' in the same scope "
                        "(previous declaration on line " + std::to_string(s->line) + ")");
            idl->sym = s;
            continue;
        }

        if (t->kind == TY_FUNC) {
            /* a prototype */
            bool redecl = false;
            Sym* s = S.declare(name, SK_FUNC, t, idl->line, &redecl);
            if (redecl && !sameType(s->type, t))
                D.error(idl->line, idl->col, "conflicting declaration of function '" + name + "'");
            if (idl->kid(1)) D.error(idl->line, idl->col, "a function cannot have an initializer");
            idl->sym = s;
            continue;
        }

        /* An object whose type has no size cannot be laid out, but the name is
           still declared -- with the error type, so that later uses of it are
           silently well-typed instead of cascading into "undeclared
           identifier".  One root cause, one message. */
        if (isVoid(t)) {
            D.error(idl->line, idl->col, "variable '" + name + "' has incomplete type void");
            t = T.tyError();
        } else if (isAggregate(t) && t->tag && !t->tag->complete) {
            D.error(idl->line, idl->col,
                    "variable '" + name + "' has incomplete type " + typeName(t));
            t = T.tyError();
        }

        if (atFileScope) {
            bool redecl = false;
            Sym* s = S.declare(name, SK_GLOBAL, t, idl->line, &redecl);
            if (redecl) {
                /* At file scope a declaration with no initializer is a tentative
                   definition, so `int g; int g;' declares one object and is legal
                   C -- gcc accepts it, and rejecting it would turn away a valid
                   program.  Only a conflicting type, or a second initializer, is
                   an error. */
                if (!sameType(s->type, t)) {
                    D.error(idl->line, idl->col, "conflicting types for '" + name +
                            "' (previous declaration on line " +
                            std::to_string(s->line) + ")");
                    continue;
                }
                if (idl->kid(1) && R->globalInit.count(s)) {
                    D.error(idl->line, idl->col, "redefinition of '" + name +
                            "' (previous definition on line " +
                            std::to_string(s->line) + ")");
                    continue;
                }
            }
            s->inMemory = true;
            s->uniq = name;
            idl->sym = s;
            if (idl->kid(1)) {
                initializer(idl->kid(1), t, idl, true);
                /* an `int a[] = {...}` global gets its length from the braces */
                if (isArray(s->type) && s->type->nelem < 0) {
                    Node* in = idl->kid(1);
                    long long n = (in->kind == N_INIT_LIST) ? (long long)in->kids.size()
                                : (in->kind == N_SCONST) ? (long long)in->sval.size() + 1 : 1;
                    s->type = T.arrayOf(s->type->base, n);
                    idl->type = s->type;
                }
                R->globalInit[s] = idl->kid(1);
            } else if (!redecl && isArray(t) && t->nelem < 0) {
                D.error(idl->line, idl->col,
                        "array '" + name + "' needs either a size or an initializer");
            }
            if (!redecl) R->globals.push_back(s);   /* one object, declared twice */
        } else {
            Sym* s = declareLocal(name, SK_VAR, t, idl->line, idl->col);
            idl->sym = s;
            if (idl->kid(1)) {
                initializer(idl->kid(1), t, idl, false);
                if (isArray(s->type) && s->type->nelem < 0) {
                    Node* in = idl->kid(1);
                    long long n = (in->kind == N_INIT_LIST) ? (long long)in->kids.size()
                                : (in->kind == N_SCONST) ? (long long)in->sval.size() + 1 : 1;
                    s->type = T.arrayOf(s->type->base, n);
                    idl->type = s->type;
                }
            } else if (isArray(t) && t->nelem < 0) {
                D.error(idl->line, idl->col,
                        "array '" + name + "' needs either a size or an initializer");
            }
        }
    }
}

/* Check an initializer against the object's type, and analyse every
   expression inside it. */
void Sema::initializer(Node* init, Type* t, Node* at, bool isGlobal) {
    if (!init) return;

    if (init->kind != N_INIT_LIST) {
        Type* et = expr(init);
        /* char buf[N] = "text" */
        if (isArray(t) && t->base && t->base->kind == TY_CHAR && init->kind == N_SCONST) {
            long long need = (long long)init->sval.size() + 1;
            if (t->nelem >= 0 && need > t->nelem)
                D.error(init->line, init->col, "string initializer is too long for " + typeName(t));
            return;
        }
        if (isArray(t)) {
            D.error(init->line, init->col, "an array must be initialized with a brace-enclosed list");
            return;
        }
        if (isAggregate(t) && !sameType(t, et)) {
            D.error(init->line, init->col,
                    "cannot initialize " + typeName(t) + " with " + typeName(et));
            return;
        }
        decay(init);
        checkAssignable(t, init->type, init, "initialization");
        /* A function's address is a link-time constant, so it is a valid
           global initializer both as `&f' (N_ADDR) and as the bare name `f',
           which decay() has already turned into a pointer. */
        bool funcAddr = (init->kind == N_ID && init->sym && init->sym->kind == SK_FUNC) ||
                        (init->kind == N_ADDR && init->kid(0) && init->kid(0)->kind == N_ID &&
                         init->kid(0)->sym && init->kid(0)->sym->kind == SK_FUNC);
        if (isGlobal && !init->isConst && !init->isFConst && !funcAddr &&
            !(init->kind == N_SCONST) && !addressConstant(init, 0, 0))
            D.error(init->line, init->col,
                    "initializer for a global variable must be a constant expression");
        return;
    }

    /* braced list */
    if (isArray(t)) {
        if (t->nelem >= 0 && (long long)init->kids.size() > t->nelem)
            D.error(init->line, init->col, "too many initializers for " + typeName(t));
        for (size_t i = 0; i < init->kids.size(); ++i)
            initializer(init->kids[i], t->base, at, isGlobal);
    } else if (isAggregate(t)) {
        if (!t->tag || !t->tag->complete) {
            D.error(init->line, init->col, "cannot initialize incomplete type " + typeName(t));
            return;
        }
        size_t limit = (t->kind == TY_UNION) ? 1 : t->tag->members.size();
        if (init->kids.size() > limit)
            D.error(init->line, init->col, "too many initializers for " + typeName(t));
        for (size_t i = 0; i < init->kids.size() && i < t->tag->members.size(); ++i)
            initializer(init->kids[i], t->tag->members[i].type, at, isGlobal);
    } else {
        if (init->kids.size() > 1)
            D.error(init->line, init->col, "too many initializers for " + typeName(t));
        if (!init->kids.empty()) initializer(init->kids[0], t, at, isGlobal);
    }
}

/* Analyses a function definition: builds the function type, checks it
   against an earlier declaration, declares the parameters in a scope shared
   with the body, analyses the body, and checks that every goto names a
   label defined in the function.  main must return int and the return type
   must be complete. */
void Sema::funcDefinition(Node* f) {
    Type* base = typeSpec(f->kid(0));
    std::string name;

    /* Parameters are declared in a scope that must be open while the
       declarator is being interpreted, because the body shares it. */
    S.push();
    Type* ft = buildType(base, f->kid(1), &name);
    if (ft->kind != TY_FUNC) {
        /* `int (*) { }': the shared declarator sub-grammar lets the name be
           left out, so the name can be empty here.  Saying so is clearer than
           quoting an empty name back at the reader. */
        if (name.empty())
            D.error(f->line, f->col, "a function definition must declare a name");
        else
            D.error(f->line, f->col, "'" + name + "' is not a function definition");
        S.pop();
        return;
    }
    S.pop();

    bool redecl = false;
    Sym* s = S.declare(name, SK_FUNC, ft, f->line, &redecl);
    if (redecl) {
        if (s->defined && !s->isExternal) {
            D.error(f->line, f->col, "redefinition of function '" + name + "'");
        } else if (s->isExternal) {
            D.error(f->line, f->col, "'" + name + "' conflicts with the built-in runtime function "
                    "of the same name");
        } else if (!sameType(s->type, ft)) {
            D.error(f->line, f->col, "definition of '" + name + "' conflicts with its earlier declaration");
        }
    }
    s->type = ft;              /* the definition's prototype wins */
    s->defined = true;         /* visible to itself: recursion works */
    s->isExternal = false;
    f->sym = s;

    if (name == "main") {
        bool ok = ft->params.empty();
        if (!ok && ft->params.size() == 2) {
            Type* a = ft->params[0];
            Type* b = ft->params[1];
            ok = isInteger(a) && isPointer(b) && isPointer(b->base) &&
                 b->base->base && b->base->base->kind == TY_CHAR;
        }
        if (!ok)
            D.error(f->line, f->col,
                    "'main' must be declared as main(void) or main(int argc, char *argv[])");
        if (!isInteger(ft->base))
            D.error(f->line, f->col, "'main' must return int");
    }

    R->ctxPool.push_back(std::unique_ptr<FuncCtx>(new FuncCtx()));
    FuncCtx* ctx = R->ctxPool.back().get();
    ctx->sym = s; ctx->body = f->kid(2);
    s->ctx = ctx;

    FuncCtx* savedFn = fn;
    Type*    savedRet = retType;
    fn = ctx; retType = ft->base;
    usedNames.clear();
    undeclSeen.clear();
    labelsDefined.clear();
    labelsUsed.clear();
    loopDepth = 0; switchDepth = 0;
    caseVals.clear(); hasDefault.clear();

    S.push();
    /* re-declare the parameters, this time recording them as symbols */
    Node* dcl = f->kid(1);
    /* Find the N_DCL_FUNC node that carries THIS function's parameter list.
       buildType walks the declarator through kid(0), so that chain is the
       declarator read inside-out, and the parameter list belongs to the
       innermost N_DCL_FUNC on it: in `int (*choose(int which))(int, int)' the
       outer one is the type of the function pointer being returned, and only
       the inner one declares `which'.  Nested parameter declarations hang off
       kid(1) and are therefore never visited. */
    Node* fnode = 0;
    for (Node* x = dcl; x && x->kind != N_DCL_NAME; x = x->kid(0))
        if (x->kind == N_DCL_FUNC) fnode = x;
    if (fnode && fnode->kid(1)) {
        Node* pl = fnode->kid(1);
        for (size_t i = 0; i < pl->kids.size(); ++i) {
            Node* p = pl->kids[i];
            if (!p->type || isVoid(p->type)) continue;
            if (p->sval.empty()) {
                D.error(p->line, p->col, "a parameter of a function definition must be named");
                continue;
            }
            /* A struct or union parameter is passed by value, so the layout of
               its type has to be known here.  A bare declaration may name an
               incomplete tag (nothing is passed yet); only the definition
               needs the size, which is where gcc reports it as well. */
            if (isAggregate(p->type) && (!p->type->tag || !p->type->tag->complete)) {
                std::ostringstream os;
                os << "parameter " << (i + 1) << " ('" << p->sval
                   << "') has incomplete type";
                Node* pn = declNameOf(p->kid(1));
                D.error(pn ? pn->line : p->line, pn ? pn->col : p->col, os.str());
                p->type = T.tyError();
            }
            Sym* ps = declareLocal(p->sval, SK_PARAM, p->type, p->line, p->col);
            p->sym = ps;
        }
    }
    if (isAggregate(ft->base) && (!ft->base->tag || !ft->base->tag->complete)) {
        Node* fname = declNameOf(f->kid(1));
        D.error(fname ? fname->line : f->line, fname ? fname->col : f->col,
                "return type is an incomplete type");
        retType = T.tyError();
    }

    block(f->kid(2));

    /* goto labels are function-scoped and may be referenced before definition */
    for (std::map<std::string, std::pair<int,int> >::iterator it = labelsUsed.begin();
         it != labelsUsed.end(); ++it)
        if (!labelsDefined.count(it->first))
            D.error(it->second.first, it->second.second,
                    "use of undeclared label '" + it->first + "'");

    S.pop();
    assignStorage();
    R->funcs.push_back(ctx);
    fn = savedFn; retType = savedRet;
}

/* Decide, for every parameter and local of the current function, whether it
   lives in a frame slot or as a virtual register, and lay the slots out. */
void Sema::assignStorage() {
    int off = 0;
    for (size_t i = 0; i < fn->order.size(); ++i) {
        Sym* s = fn->order[i];
        if (s->kind == SK_TYPEDEF || s->kind == SK_ENUMCONST || s->kind == SK_FUNC) continue;
        bool mem = s->addrTaken || isArray(s->type) || isAggregate(s->type);
        s->inMemory = mem;
        if (!mem) continue;
        int a = typeAlign(s->type);
        int sz = typeSize(s->type);
        if (sz == 0) sz = 4;
        off = alignUp(off, a);
        s->offset = off;
        off += sz;
    }
    fn->frameSize = alignUp(off, 8);   /* MIPS keeps the stack 8-byte aligned */
}

/* ================= statements ================= */

void Sema::block(Node* s) {
    S.push();
    for (size_t i = 0; i < s->kids.size(); ++i) {
        Node* it = s->kids[i];
        if (it->kind == N_DECL) declaration(it, false);
        else stmt(it);
    }
    S.pop();
}

namespace { std::vector<Node*> g_switchStack; }

/* Part D.2, block scope.  "Foo *p;" inside a function is grammatically an
   expression statement: the scanner only knows typedef names, so an unknown
   Foo comes back as IDENTIFIER and the parser builds the multiplication
   Foo * p.  Accepting it as a declaration in the grammar is impossible without
   a reduce/reduce conflict against "a * b;", so the shape is recognised here
   instead and reported as the single root cause it is.
   The test matches gcc's: the leading identifier must be undeclared in the
   ordinary namespace.  (If it names a variable, gcc too treats the statement as
   a multiplication -- "int zz; zz * p;" reports p, not zz.)  Anything after the
   '*' must be a declarator shape: p, *p, p[3], *p[3] and so on. */
static bool declaratorShaped(const Node* e) {
    if (!e) return false;
    switch (e->kind) {
        case N_ID:    return true;
        case N_DEREF: return declaratorShaped(e->kid(0));
        case N_INDEX: return declaratorShaped(e->kid(0));
        default:      return false;
    }
}

Node* Sema::unknownTypeDeclShape(Node* e) {
    if (!e) return 0;
    /* "Foo *p = 0;" parses as (Foo * p) = 0 since Part D.1. */
    if (e->kind == N_ASSIGN && e->sval == "=") return unknownTypeDeclShape(e->kid(0));
    if (e->kind == N_COMMA) return unknownTypeDeclShape(e->kid(0));
    if (e->kind != N_BINOP || e->sval != "*") return 0;
    Node* l = e->kid(0);
    if (!l || l->kind != N_ID || S.lookup(l->sval)) return 0;
    if (!declaratorShaped(e->kid(1))) return 0;
    return l;
}

/* Analyses one statement: conditions must be scalars and a switch
   expression an integer, labels must be unique, case labels distinct
   integer constants inside a switch (one default at most), break must be
   inside a loop or switch and continue inside a loop, and return must give
   a value convertible to the return type exactly when it is not void. */
void Sema::stmt(Node* s) {
    if (!s) return;
    switch (s->kind) {
        case N_COMPOUND: block(s); break;
        case N_EMPTY: break;
        case N_DECL: declaration(s, false); break;
        case N_EXPRSTMT:
            if (s->kid(0)) {
                Node* bad = unknownTypeDeclShape(s->kid(0));
                if (bad) {
                    D.error(bad->line, bad->col,
                            "unknown type name '" + bad->sval +
                            "' (if this is a typedef name, the typedef must appear "
                            "before this point and in an enclosing scope)");
                    s->kids[0] = 0;          /* one root cause, one message */
                    break;
                }
                expr(s->kid(0));
            }
            break;

        case N_IF:
            condition(s->kid(0));
            stmt(s->kid(1));
            stmt(s->kid(2));
            break;

        case N_SWITCH: {
            Type* t = s->kid(0) ? expr(s->kid(0)) : T.tyError();
            if (!isError(t) && !isInteger(t))
                /* at the expression itself, as gcc reports it */
                D.error(s->kid(0)->line, s->kid(0)->col,
                        "switch expression must have integer type, got " + typeName(t) +
                        (isFloat(t) ? " (a floating-point value cannot be switched on)" : ""));
            ++switchDepth;
            caseVals.push_back(std::set<long long>());
            hasDefault.push_back(false);
            g_switchStack.push_back(s);
            stmt(s->kid(1));
            g_switchStack.pop_back();
            hasDefault.pop_back();
            caseVals.pop_back();
            --switchDepth;
            break;
        }

        case N_WHILE: case N_UNTIL:
            condition(s->kid(0));
            ++loopDepth; stmt(s->kid(1)); --loopDepth;
            break;

        case N_DO:
            ++loopDepth; stmt(s->kid(0)); --loopDepth;
            condition(s->kid(1));
            break;

        case N_FOR:
            S.push();
            if (s->kid(0)) { if (s->kid(0)->kind == N_DECL) declaration(s->kid(0), false);
                             else stmt(s->kid(0)); }
            if (s->kid(1)) condition(s->kid(1));
            if (s->kid(2)) expr(s->kid(2));
            ++loopDepth; stmt(s->kid(3)); --loopDepth;
            S.pop();
            break;

        case N_GOTO:
            if (!labelsUsed.count(s->sval)) labelsUsed[s->sval] = std::make_pair(s->line, s->col);
            break;

        case N_LABEL: {
            std::map<std::string,int>::iterator it = labelsDefined.find(s->sval);
            if (it != labelsDefined.end())
                D.error(s->line, s->col, "duplicate label '" + s->sval + "' (first defined on line "
                        + std::to_string(it->second) + ")");
            else labelsDefined[s->sval] = s->line;
            stmt(s->kid(0));
            break;
        }

        case N_CASE: {
            if (switchDepth == 0) {
                D.error(s->line, s->col, "'case' label not inside a switch statement");
                if (s->kid(0)) expr(s->kid(0));
            } else {
                bool ok = true;
                long long v = s->kid(0) ? constExpr(s->kid(0), &ok) : (ok = false, 0);
                if (!ok)
                    D.error(s->line, s->col, std::string("case label is not an integer constant expression") +
                            (s->kid(0) && isFloat(s->kid(0)->type)
                                 ? " (its type is " + typeName(s->kid(0)->type) + ")" : ""));
                else {
                    if (caseVals.back().count(v))
                        D.error(s->line, s->col, "duplicate case value " + std::to_string(v));
                    else caseVals.back().insert(v);
                    s->ival = v;
                    s->isConst = true; s->constVal = v;
                }
                g_switchStack.back()->extra.push_back(s);
            }
            stmt(s->kid(0 + 1));
            break;
        }

        case N_DEFAULT:
            if (switchDepth == 0) {
                D.error(s->line, s->col, "'default' label not inside a switch statement");
            } else {
                if (hasDefault.back())
                    D.error(s->line, s->col, "multiple 'default' labels in one switch");
                hasDefault.back() = true;
                g_switchStack.back()->extra.push_back(s);
            }
            stmt(s->kid(0));
            break;

        case N_BREAK:
            if (loopDepth == 0 && switchDepth == 0)
                D.error(s->line, s->col, "'break' outside of a loop or switch statement");
            break;

        case N_CONTINUE:
            if (loopDepth == 0)
                D.error(s->line, s->col, "'continue' outside of a loop statement");
            break;

        case N_RETURN:
            if (s->kid(0)) {
                Type* t = expr(s->kid(0));
                decay(s->kid(0));
                if (isVoid(retType)) {
                    /* at the returned expression, which is the part that is wrong */
                    D.error(s->kid(0)->line, s->kid(0)->col,
                            "'return' with a value in a function returning void");
                } else {
                    (void)t;
                    checkAssignable(retType, s->kid(0)->type, s->kid(0), "return");
                }
            } else {
                if (!isVoid(retType) && !isError(retType))
                    D.error(s->line, s->col, "'return' with no value in a function returning " +
                            typeName(retType));
            }
            break;

        default:
            expr(s);      /* an expression used as a statement */
            break;
    }
}

void Sema::condition(Node* e) {
    if (!e) return;
    Type* t = expr(e);
    decay(e);
    t = e->type;
    if (!isError(t) && !isScalar(t))
        D.error(e->line, e->col, "a condition must have scalar type, got " + typeName(t));
}

/* ================= expressions ================= */

Type* Sema::decay(Node* e) {
    if (!e || !e->type) return T.tyError();
    /* The pre-decay type is kept: for a[i][j], the inner a[i] is an array that
       has decayed to a pointer, but its ARRAY type is what gives the row
       stride, so the IR generator must still be able to see it. */
    if (isArray(e->type)) { e->origType = e->type; e->type = T.ptrTo(e->type->base); e->lvalue = false; e->decayed = true; }
    else if (e->type->kind == TY_FUNC) {
        /* A function designator used as a value becomes a pointer to it. */
        e->origType = e->type; e->type = T.ptrTo(e->type);
        e->lvalue = false; e->decayed = true;
        if (e->kind == N_ID) useFunc(e->sym);
    }
    return e->type;
}

void Sema::markAddrTaken(Node* e) {
    if (!e) return;
    switch (e->kind) {
        case N_ID:
            if (e->sym && (e->sym->kind == SK_VAR || e->sym->kind == SK_PARAM))
                e->sym->addrTaken = true;
            break;
        case N_MEMBER:  markAddrTaken(e->kid(0)); break;
        /* &a[i], &*p and &p->m do not force p itself into memory */
        default: break;
    }
}

/* The usual arithmetic conversions, C's rule reduced to the three arithmetic
   types this compiler has: if either operand is double the common type is
   double, otherwise if either is float it is float, otherwise int (char and
   enum are promoted to int first, exactly as in C). */
Type* Sema::usualArith(Type* a, Type* b) {
    int ra = arithRank(a), rb = arithRank(b);
    int r = ra > rb ? ra : rb;
    if (r == 3) return T.tyDouble();
    if (r == 2) return T.tyFloat();
    return T.tyInt();
}

/* One root cause, one message.  A binary operator applied to operands it is
   not defined on is reported once, naming both types the way gcc does, and the
   result is given the error type so that nothing enclosing it -- the
   assignment it feeds, the condition it controls -- is reported a second time
   for the same mistake.  `why' may add a clause explaining the rule. */
Type* Sema::badOperands(Node* e, Type* lt, Type* rt, const std::string& why) {
    if (!isError(lt) && !isError(rt))
        D.error(e->line, e->col, "invalid operands to '" + e->sval + "': " +
                typeName(lt) + " and " + typeName(rt) + why);
    e->type = T.tyError();
    return e->type;
}

/* Checks that a value of type rhs may be assigned to lhs (used for =,
   initialisation, argument passing and return; `what' names which in the
   message).  Arithmetic types convert freely; pointers need compatible
   targets, void*, or a null pointer constant; structs must be the same
   type; arrays and void are never assignable. */
void Sema::checkAssignable(Type* lhs, Type* rhs, Node* at, const char* what) {
    if (isError(lhs) || isError(rhs)) return;
    if (isVoid(lhs) || isVoid(rhs)) {
        D.error(at->line, at->col, std::string("invalid ") + what + ": " + typeName(rhs) +
                " to " + typeName(lhs));
        return;
    }
    if (isArray(lhs)) {
        D.error(at->line, at->col, std::string("invalid ") + what + ": " + typeName(lhs) +
                " is not assignable");
        return;
    }
    /* A floating-point value and a pointer never convert to one another. */
    if ((isFloat(lhs) && isPointer(rhs)) || (isPointer(lhs) && isFloat(rhs))) {
        D.error(at->line, at->col, std::string("invalid ") + what + ": " + typeName(rhs) +
                " to " + typeName(lhs) +
                " (there is no conversion between a floating-point type and a pointer)");
        return;
    }
    if (isArith(lhs) && isArith(rhs)) return;      /* char/int <-> float <-> double */
    if (isPointer(lhs) && isPointer(rhs)) {
        Type* a = lhs->base; Type* b = rhs->base;
        if (isVoid(a) || isVoid(b)) return;            /* void * converts freely */
        if (sameType(a, b)) return;
        D.error(at->line, at->col, std::string("incompatible pointer types in ") + what + ": " +
                typeName(rhs) + " to " + typeName(lhs) + " (an explicit cast is required)");
        return;
    }
    if (isPointer(lhs) && isInteger(rhs)) {
        if (at->isConst && at->constVal == 0) return;  /* the null pointer constant */
        D.error(at->line, at->col, std::string("invalid ") + what + ": " + typeName(rhs) +
                " to " + typeName(lhs) + " (an explicit cast is required)");
        return;
    }
    if (isInteger(lhs) && isPointer(rhs)) {
        D.error(at->line, at->col, std::string("invalid ") + what + ": " + typeName(rhs) +
                " to " + typeName(lhs) + " (an explicit cast is required)");
        return;
    }
    if (isAggregate(lhs) && isAggregate(rhs)) {
        if (sameType(lhs, rhs)) return;
        D.error(at->line, at->col, std::string("invalid ") + what + ": " + typeName(rhs) +
                " to " + typeName(lhs));
        return;
    }
    D.error(at->line, at->col, std::string("invalid ") + what + ": " + typeName(rhs) +
            " to " + typeName(lhs));
}

std::string Sema::internString(const std::string& bytes) {
    std::map<std::string,std::string>::iterator it = strPool.find(bytes);
    if (it != strPool.end()) return it->second;
    std::string label = ".str" + std::to_string(strCounter++);
    strPool[bytes] = label;
    R->strings.push_back(std::make_pair(label, bytes));
    return label;
}

long long Sema::constExpr(Node* e, bool* ok) {
    if (!e) { *ok = false; return 0; }
    expr(e);
    if (!e->isConst) { *ok = false; return 0; }
    *ok = true;
    return e->constVal;
}

void Sema::useFunc(Sym* s) {
    if (!s || s->kind != SK_FUNC) return;
    s->used = true;
    if (!s->isExternal) return;
    for (size_t i = 0; i < R->externsUsed.size(); ++i)
        if (R->externsUsed[i] == s) return;
    R->externsUsed.push_back(s);
}

/* Checks a function call: resolves the callee (a function name or an
   expression yielding a pointer to function), checks the argument count
   against the prototype (variadic functions take extra arguments, which
   get the default promotions) and each argument's assignability. */
void Sema::checkCall(Node* call) {
    Node* callee = call->kid(0);
    Node* args   = call->kid(1);
    size_t nargs = args ? args->kids.size() : 0;

    Type*       ft   = 0;                     /* the function type being called */
    std::string what = "the called function"; /* how a diagnostic names it */

    /* A plain name that resolves to a function is called directly.  Anything
       else -- a variable holding a function pointer, a struct member, an array
       element, `*fp' -- is an expression that must yield a pointer to a
       function, and the call goes through that pointer.  irgen tells the two
       apart by the same test: callee->sym is a function symbol. */
    if (callee->kind == N_ID) {
        Sym* s = S.lookup(callee->sval);
        if (!s) {
            if (firstUndeclared(callee->sval))
                D.error(callee->line, callee->col,
                        "call to undeclared function '" + callee->sval +
                        "' (first use in this function)");
            for (size_t i = 0; i < nargs; ++i) { expr(args->kids[i]); decay(args->kids[i]); }
            call->type = T.tyError();
            return;
        }
        if (s->kind == SK_FUNC) {
            callee->sym  = s;
            callee->type = s->type;
            useFunc(s);
            ft   = s->type;
            what = "function '" + callee->sval + "'";
        }
    }

    if (!ft) {
        Type* ct = expr(callee);
        decay(callee);                      /* a function designator -> pointer */
        ct = callee->type;
        if (isError(ct)) {
            for (size_t i = 0; i < nargs; ++i) { expr(args->kids[i]); decay(args->kids[i]); }
            call->type = T.tyError();
            return;
        }
        if (isPointer(ct) && ct->base && ct->base->kind == TY_FUNC) {
            ft = ct->base;
            if (callee->kind == N_ID) what = "function '" + callee->sval + "'";
        } else {
            /* gcc's wording, which names the object when there is one. */
            std::string nm = (callee->kind == N_ID) ? ("'" + callee->sval + "' ") : "";
            D.error(callee->line, callee->col,
                    "called object " + nm + "is not a function or function pointer");
            for (size_t i = 0; i < nargs; ++i) { expr(args->kids[i]); decay(args->kids[i]); }
            call->type = T.tyError();
            return;
        }
    }

    size_t nfixed = ft->params.size();
    if (ft->variadic ? (nargs < nfixed) : (nargs != nfixed)) {
        std::ostringstream os;
        os << what << " expects "
           << (ft->variadic ? "at least " : "") << nfixed
           << " argument" << (nfixed == 1 ? "" : "s") << " but " << nargs
           << (nargs == 1 ? " was" : " were") << " given";
        D.error(call->line, call->col, os.str());
    }
    for (size_t i = 0; i < nargs; ++i) {
        Node* a = args->kids[i];
        expr(a);
        decay(a);
        if (i < nfixed) {
            checkAssignable(ft->params[i], a->type, a, "argument passing");
        } else if (!isError(a->type) && !isScalar(a->type)) {
            D.error(a->line, a->col,
                    "cannot pass " + typeName(a->type) + " as a variadic argument");
        }
    }
    /* Calling a function that returns a struct needs the struct's size, so the
       tag has to be complete here even though the declaration alone was fine. */
    if (isAggregate(ft->base) && (!ft->base->tag || !ft->base->tag->complete)) {
        D.error(call->line, call->col,
                "invalid use of undefined type " + typeName(ft->base));
        call->type = T.tyError();
        call->lvalue = false;
        return;
    }
    call->type = ft->base;
    call->lvalue = false;
}

/* An undeclared name is one mistake, wherever it is used.  gcc reports it on
   the first use in the function and says so; repeating the message for every
   later use would turn a single missing declaration into a wall of
   diagnostics, and the expression already carries the error type, which keeps
   the rest of the statement silent.  The set is cleared for each function, so
   the same typo in two functions is reported in both. */
bool Sema::firstUndeclared(const std::string& name) {
    return undeclSeen.insert(name).second;
}

/* Analyses an expression and returns its type, caching it in e->type.  One
   case per node kind: identifiers, constants, unary and binary operators
   with the usual arithmetic conversions and pointer arithmetic rules,
   assignment, conditional, cast, sizeof, calls, indexing and member access.
   Constant subexpressions are folded into e->isConst/constVal. */
Type* Sema::expr(Node* e) {
    if (!e) return T.tyError();
    if (e->type) return e->type;        /* already analysed */
    e->type = T.tyError();

    switch (e->kind) {
    case N_ID: {
        Sym* s = S.lookup(e->sval);
        if (!s) {
            if (firstUndeclared(e->sval))
                D.error(e->line, e->col, "undeclared identifier '" + e->sval +
                                         "' (first use in this function)");
            return e->type;
        }
        e->sym = s;
        if (s->kind == SK_TYPEDEF) {
            D.error(e->line, e->col, "'" + e->sval + "' is a type name, not a value");
            return e->type;
        }
        if (s->kind == SK_ENUMCONST) {
            e->type = T.tyInt();
            e->isConst = true; e->constVal = s->enumVal;
            return e->type;
        }
        e->type = s->type;
        e->lvalue = (s->kind != SK_FUNC) && !isArray(s->type);
        if (isArray(s->type)) e->lvalue = true;   /* an object, but not assignable */
        s->used = true;
        return e->type;
    }

    case N_ICONST:
        e->type = T.tyInt(); e->isConst = true; e->constVal = e->ival;
        return e->type;

    case N_CCONST:
        e->type = T.tyInt(); e->isConst = true; e->constVal = e->ival;
        return e->type;

    case N_FCONST: {
        /* An unsuffixed floating constant has type double, as in C; an f/F
           suffix makes it a float (and parseFloatLiteral rounds it once, to
           float, so that 0.1f is the same bit pattern gcc produces). */
        double v = 0; bool single = false;
        if (!parseFloatLiteral(e->sval, &v, &single)) {
            D.error(e->line, e->col, "malformed floating constant '" + e->sval + "'");
            return e->type;
        }
        e->type = single ? T.tyFloat() : T.tyDouble();
        e->isFConst = true; e->fconstVal = v;
        return e->type;
    }

    case N_SCONST:
        e->aux = internString(e->sval);
        e->type = T.arrayOf(T.tyChar(), (long long)e->sval.size() + 1);
        e->lvalue = true;
        return e->type;

    case N_BINOP: {
        Node* l = e->kid(0); Node* r = e->kid(1);
        expr(l); expr(r); decay(l); decay(r);
        const std::string& o = e->sval;
        Type* lt = l->type; Type* rt = r->type;

        if (o == "&&" || o == "||") {
            if (!isError(lt) && !isScalar(lt))
                D.error(e->line, e->col, "left operand of '" + o + "' must be scalar, got " + typeName(lt));
            if (!isError(rt) && !isScalar(rt))
                D.error(e->line, e->col, "right operand of '" + o + "' must be scalar, got " + typeName(rt));
            e->type = T.tyInt();
            if (l->isConst && r->isConst) {
                e->isConst = true;
                e->constVal = (o == "&&") ? ((l->constVal && r->constVal) ? 1 : 0)
                                          : ((l->constVal || r->constVal) ? 1 : 0);
            }
            return e->type;
        }

        if (o == "+" || o == "-") {
            if (isPointer(lt) && isInteger(rt)) {
                if (isVoid(lt->base) || typeSize(lt->base) == 0)
                    D.error(e->line, e->col, "arithmetic on a pointer to incomplete type " + typeName(lt));
                e->type = lt; return e->type;
            }
            if (o == "+" && isInteger(lt) && isPointer(rt)) {
                if (isVoid(rt->base) || typeSize(rt->base) == 0)
                    D.error(e->line, e->col, "arithmetic on a pointer to incomplete type " + typeName(rt));
                e->type = rt; return e->type;
            }
            if (o == "-" && isPointer(lt) && isPointer(rt)) {
                if (!sameType(lt->base, rt->base))
                    D.error(e->line, e->col, "subtraction of incompatible pointer types " +
                            typeName(lt) + " and " + typeName(rt));
                else if (typeSize(lt->base) == 0)
                    D.error(e->line, e->col, "subtraction of pointers to incomplete type " + typeName(lt));
                e->type = T.tyInt(); return e->type;
            }
            /* fall through to the plain-integer case */
        }

        bool bitwise = (o == "&" || o == "|" || o == "^" || o == "<<" || o == ">>" || o == "%");
        bool relational = (o == "<" || o == ">" || o == "<=" || o == ">=" || o == "==" || o == "!=");

        /* These six have no floating form: they are defined on integers only.
           Reported here rather than by the generic "invalid operand" branch so
           that the message says why. */
        if (bitwise && (isFloat(lt) || isFloat(rt)))
            return badOperands(e, lt, rt, " (this operator requires an integer type)");

        /* A floating operand may not be mixed with a pointer in any operator. */
        if ((isFloat(lt) && isPointer(rt)) || (isPointer(lt) && isFloat(rt)))
            return badOperands(e, lt, rt,
                               " (a floating-point value and a pointer cannot be combined)");

        if (relational) {
            bool pl = isPointer(lt), pr = isPointer(rt);
            if (pl && pr) {
                if (!sameType(lt->base, rt->base) && !isVoid(lt->base) && !isVoid(rt->base))
                    D.error(e->line, e->col, "comparison of distinct pointer types " +
                            typeName(lt) + " and " + typeName(rt));
            } else if (pl || pr) {
                Node* other = pl ? r : l;
                if (!(other->isConst && other->constVal == 0))
                    D.error(e->line, e->col,
                            "comparison between " + typeName(lt) + " and " + typeName(rt) +
                            " (only the constant 0 may be compared with a pointer)");
            } else {
                if (!isArith(lt) || !isArith(rt)) return badOperands(e, lt, rt, "");
                /* The comparison itself happens in the common type; the result
                   is always int. */
                e->cmpType = usualArith(lt, rt);
            }
            e->type = T.tyInt();
        } else {
            (void)bitwise;
            if (!isArith(lt) || !isArith(rt)) return badOperands(e, lt, rt, "");
            e->type = usualArith(lt, rt);
        }

        if (l->isConst && r->isConst) {
            long long a = l->constVal, b = r->constVal, v = 0;
            bool okc = true;
            if (o == "+") v = a + b;
            else if (o == "-") v = a - b;
            else if (o == "*") v = a * b;
            else if (o == "/") { if (b == 0) okc = false; else v = a / b; }
            else if (o == "%") { if (b == 0) okc = false; else v = a % b; }
            else if (o == "<<") v = (long long)((int)a << ((int)b & 31));
            else if (o == ">>") v = (long long)((int)a >> ((int)b & 31));
            else if (o == "&") v = a & b;
            else if (o == "|") v = a | b;
            else if (o == "^") v = a ^ b;
            else if (o == "<") v = a < b;
            else if (o == ">") v = a > b;
            else if (o == "<=") v = a <= b;
            else if (o == ">=") v = a >= b;
            else if (o == "==") v = a == b;
            else if (o == "!=") v = a != b;
            else okc = false;
            if (okc && isInteger(e->type)) { e->isConst = true; e->constVal = (int)v; }
        }
        /* Floating constant folding, kept separate from the integer kind: a
           floating expression is never an *integer* constant expression, but a
           global initializer still has to be evaluated at translation time. */
        if (isFloat(e->type) && l->hasFConst() && r->hasFConst()) {
            double a = l->fvalue(), b = r->fvalue(), v = 0; bool okc = true;
            if      (o == "+") v = a + b;
            else if (o == "-") v = a - b;
            else if (o == "*") v = a * b;
            else if (o == "/") { if (b == 0) okc = false; else v = a / b; }
            else okc = false;
            if (okc) {
                e->isFConst = true;
                e->fconstVal = (e->type->kind == TY_FLOAT) ? (double)(float)v : v;
            }
        }
        return e->type;
    }

    case N_UNOP: {
        Node* a = e->kid(0);
        expr(a); decay(a);
        const std::string& o = e->sval;
        if (o == "!") {
            if (!isError(a->type) && !isScalar(a->type))
                D.error(e->line, e->col, "invalid operand to '!': " + typeName(a->type));
            e->type = T.tyInt();
            if (a->isConst) { e->isConst = true; e->constVal = a->constVal ? 0 : 1; }
            return e->type;
        }
        /* Unary '-' and '+' accept a floating operand; '~' does not. */
        bool intOnly = (o == "~");
        if (!isError(a->type) && !(intOnly ? isInteger(a->type) : isArith(a->type)))
            D.error(e->line, e->col, "invalid operand to unary '" + o + "': " + typeName(a->type) +
                    (intOnly && isFloat(a->type) ? " (this operator requires an integer type)" : ""));
        e->type = (!intOnly && isFloat(a->type)) ? a->type : T.tyInt();
        if (a->isConst && isInteger(e->type)) {
            e->isConst = true;
            e->constVal = (o == "-") ? -a->constVal : (o == "~") ? ~a->constVal : a->constVal;
        }
        if (isFloat(e->type) && a->hasFConst()) {
            e->isFConst = true;
            e->fconstVal = (o == "-") ? -a->fvalue() : a->fvalue();
        }
        return e->type;
    }

    case N_ADDR: {
        Node* a = e->kid(0);
        expr(a);
        if (isError(a->type)) return e->type;
        /* `&f' on a function.  A function designator is not an lvalue, so this
           has to come before the lvalue test; the result is the same pointer
           that the bare name `f' decays to. */
        if (a->type->kind == TY_FUNC) {
            if (a->kind == N_ID) useFunc(a->sym);
            e->type = T.ptrTo(a->type);
            return e->type;
        }
        if (!a->lvalue) {
            D.error(e->line, e->col, "cannot take the address of a non-lvalue expression");
            return e->type;
        }
        if (a->kind == N_ID && a->sym && a->sym->kind == SK_ENUMCONST) {
            D.error(e->line, e->col, "cannot take the address of an enumeration constant");
            return e->type;
        }
        markAddrTaken(a);
        e->type = T.ptrTo(a->type);
        return e->type;
    }

    case N_DEREF: {
        Node* a = e->kid(0);
        expr(a); decay(a);
        if (isError(a->type)) return e->type;
        if (!isPointer(a->type)) {
            D.error(e->line, e->col,
                    "cannot dereference a value of non-pointer type " + typeName(a->type));
            return e->type;
        }
        if (isVoid(a->type->base)) {
            D.error(e->line, e->col, "cannot dereference a void pointer");
            return e->type;
        }
        e->type = a->type->base;
        e->lvalue = true;
        return e->type;
    }

    case N_INDEX: {
        Node* a = e->kid(0); Node* i = e->kid(1);
        expr(a); expr(i); decay(a); decay(i);
        if (isError(a->type) || isError(i->type)) return e->type;
        if (!isPointer(a->type)) {
            D.error(e->line, e->col,
                    "cannot index a value of type " + typeName(a->type) +
                    " (an array or pointer is required)");
            return e->type;
        }
        if (!isInteger(i->type)) {
            D.error(e->line, e->col, "array subscript must have integer type, got " + typeName(i->type));
            return e->type;
        }
        if (isVoid(a->type->base)) {
            D.error(e->line, e->col, "cannot index a void pointer");
            return e->type;
        }
        e->type = a->type->base;
        e->lvalue = true;
        return e->type;
    }

    case N_MEMBER: case N_ARROW: {
        Node* a = e->kid(0);
        expr(a);
        Type* st = a->type;
        if (e->kind == N_ARROW) {
            decay(a);
            st = a->type;
            if (isError(st)) return e->type;
            if (!isPointer(st)) {
                D.error(e->line, e->col, "'->' applied to non-pointer type " + typeName(st));
                return e->type;
            }
            st = st->base;
        }
        if (isError(st)) return e->type;
        if (!isAggregate(st)) {
            std::string msg = std::string(e->kind == N_ARROW ? "'->'" : "'.'") +
                              " applied to " + typeName(st) +
                              ", which is not a struct or union";
            /* The common slip, which gcc also points out by name. */
            if (e->kind == N_MEMBER && isPointer(st) && isAggregate(st->base))
                msg += "; did you mean to use '->'?";
            D.error(e->line, e->col, msg);
            return e->type;
        }
        if (!st->tag || !st->tag->complete) {
            D.error(e->line, e->col, "member access into incomplete type " + typeName(st));
            return e->type;
        }
        for (size_t i = 0; i < st->tag->members.size(); ++i) {
            if (st->tag->members[i].name == e->sval) {
                e->member = &st->tag->members[i];
                e->type = st->tag->members[i].type;
                e->lvalue = (e->kind == N_ARROW) ? true : a->lvalue;
                return e->type;
            }
        }
        D.error(e->line, e->col, typeName(st) + " has no member named '" + e->sval + "'");
        return e->type;
    }

    case N_PREINC: case N_PREDEC: case N_POSTINC: case N_POSTDEC: {
        Node* a = e->kid(0);
        expr(a);
        if (isError(a->type)) return e->type;
        if (!a->lvalue || isArray(a->type)) {
            D.error(e->line, e->col, "operand of '" +
                    std::string(e->kind == N_PREINC || e->kind == N_POSTINC ? "++" : "--") +
                    "' is not a modifiable lvalue");
            return e->type;
        }
        if (!isScalar(a->type)) {
            D.error(e->line, e->col, "cannot increment or decrement a value of type " + typeName(a->type));
            return e->type;
        }
        if (isPointer(a->type) && typeSize(a->type->base) == 0) {
            D.error(e->line, e->col, "arithmetic on a pointer to incomplete type " + typeName(a->type));
            return e->type;
        }
        e->type = a->type;
        return e->type;
    }

    case N_ASSIGN: {
        Node* l = e->kid(0); Node* r = e->kid(1);
        expr(l); expr(r); decay(r);
        if (isError(l->type)) return e->type;
        if (!l->lvalue) {
            D.error(e->line, e->col, "assignment to a non-lvalue expression");
            return e->type;
        }
        if (isArray(l->type)) {
            D.error(e->line, e->col, "assignment to an expression of array type " + typeName(l->type));
            return e->type;
        }
        const std::string& o = e->sval;
        if (o == "=") {
            checkAssignable(l->type, r->type, r, "assignment");
        } else {
            /* compound assignment: the implied binary operation must be legal */
            std::string bo = o.substr(0, o.size() - 1);
            if (isPointer(l->type)) {
                if ((bo == "+" || bo == "-") && isInteger(r->type)) {
                    if (typeSize(l->type->base) == 0)
                        D.error(e->line, e->col, "arithmetic on a pointer to incomplete type " +
                                typeName(l->type));
                } else {
                    D.error(e->line, e->col, "invalid operands to '" + o + "': " +
                            typeName(l->type) + " and " + typeName(r->type));
                }
            } else {
                /* Only the five arithmetic forms have a floating version;
                   %=, <<=, >>=, &=, |= and ^= are integer-only. */
                bool intOnly = (bo == "%" || bo == "<<" || bo == ">>" ||
                                bo == "&" || bo == "|" || bo == "^");
                bool okl = intOnly ? isInteger(l->type) : isArith(l->type);
                bool okr = intOnly ? isInteger(r->type) : isArith(r->type);
                if (!okl || !okr)
                    D.error(e->line, e->col, "invalid operands to '" + o + "': " +
                            typeName(l->type) + " and " + typeName(r->type) +
                            (intOnly && (isFloat(l->type) || isFloat(r->type))
                                 ? " (this operator requires an integer type)" : ""));
            }
        }
        e->type = l->type;
        return e->type;
    }

    case N_COND: {
        Node* c = e->kid(0); Node* a = e->kid(1); Node* b = e->kid(2);
        expr(c); decay(c);
        if (!isError(c->type) && !isScalar(c->type))
            D.error(e->line, e->col, "condition of '?:' must have scalar type, got " + typeName(c->type));
        expr(a); expr(b); decay(a); decay(b);
        if (isError(a->type) || isError(b->type)) return e->type;
        if (isInteger(a->type) && isInteger(b->type)) e->type = T.tyInt();
        else if (isArith(a->type) && isArith(b->type)) e->type = usualArith(a->type, b->type);
        else if (isPointer(a->type) && isPointer(b->type)) {
            if (isVoid(a->type->base)) e->type = a->type;
            else if (isVoid(b->type->base)) e->type = b->type;
            else if (sameType(a->type->base, b->type->base)) e->type = a->type;
            else {
                D.error(e->line, e->col, "branches of '?:' have incompatible pointer types " +
                        typeName(a->type) + " and " + typeName(b->type));
                return e->type;
            }
        } else if (isPointer(a->type) && b->isConst && b->constVal == 0) e->type = a->type;
        else if (isPointer(b->type) && a->isConst && a->constVal == 0) e->type = b->type;
        else if (isVoid(a->type) && isVoid(b->type)) e->type = T.tyVoid();
        else if (isAggregate(a->type) && sameType(a->type, b->type)) e->type = a->type;
        else {
            D.error(e->line, e->col, "branches of '?:' have incompatible types " +
                    typeName(a->type) + " and " + typeName(b->type));
            return e->type;
        }
        if (c->isConst && a->isConst && b->isConst) {
            e->isConst = true;
            e->constVal = c->constVal ? a->constVal : b->constVal;
        }
        return e->type;
    }

    case N_COMMA: {
        Node* l = e->kid(0); Node* r = e->kid(1);
        expr(l); expr(r); decay(r);
        e->type = r->type;
        return e->type;
    }

    case N_CALL:
        checkCall(e);
        return e->type;

    case N_SIZEOF_EXPR: {
        Node* a = e->kid(0);
        expr(a);                      /* NOT decayed: sizeof(arr) is the array size */
        if (isError(a->type)) return e->type;
        if (a->type->kind == TY_FUNC) {
            D.error(e->line, e->col, "sizeof applied to a function type");
            return e->type;
        }
        int sz = typeSize(a->type);
        if (sz == 0) {
            D.error(e->line, e->col, "sizeof applied to incomplete type " + typeName(a->type));
            return e->type;
        }
        e->type = T.tyInt(); e->isConst = true; e->constVal = sz;
        return e->type;
    }

    case N_SIZEOF_TYPE: {
        Node* tn = e->kid(0);
        std::string nm;
        Type* t = buildType(typeSpec(tn->kid(0)), tn->kid(1), &nm);
        if (isError(t)) return e->type;
        int sz = typeSize(t);
        if (sz == 0) {
            D.error(e->line, e->col, "sizeof applied to incomplete type " + typeName(t));
            return e->type;
        }
        e->type = T.tyInt(); e->isConst = true; e->constVal = sz;
        return e->type;
    }

    case N_CAST: {
        Node* tn = e->kid(0); Node* a = e->kid(1);
        std::string nm;
        Type* t = buildType(typeSpec(tn->kid(0)), tn->kid(1), &nm);
        expr(a); decay(a);
        if (isError(t) || isError(a->type)) return e->type;
        if (isVoid(t)) { e->type = t; return e->type; }
        if (!isScalar(t)) {
            D.error(e->line, e->col, "cannot cast to non-scalar type " + typeName(t));
            return e->type;
        }
        if (!isScalar(a->type)) {
            D.error(e->line, e->col, "cannot cast from non-scalar type " + typeName(a->type));
            return e->type;
        }
        /* There is no conversion between a floating-point value and a pointer,
           not even an explicit one. */
        if ((isFloat(t) && isPointer(a->type)) || (isPointer(t) && isFloat(a->type))) {
            D.error(e->line, e->col, "cannot cast " + typeName(a->type) + " to " + typeName(t) +
                    " (there is no conversion between a floating-point type and a pointer)");
            return e->type;
        }
        e->type = t;
        if (a->isConst && isInteger(t)) {
            e->isConst = true;
            e->constVal = (t->kind == TY_CHAR) ? (long long)(signed char)a->constVal
                                               : (long long)(int)a->constVal;
        }
        if (isFloat(t) && a->hasFConst()) {
            e->isFConst = true;
            e->fconstVal = (t->kind == TY_FLOAT) ? (double)(float)a->fvalue() : a->fvalue();
        }
        if (isInteger(t) && a->isFConst) {         /* (int)1.9 truncates toward zero */
            e->isConst = true;
            double v = a->fvalue();
            long long tr = (long long)v;
            e->constVal = (t->kind == TY_CHAR) ? (long long)(signed char)tr : (long long)(int)tr;
        }
        return e->type;
    }

    default:
        return e->type;
    }
}

/* ================= driver ================= */

/* Semantic analysis entry point: analyses every top-level declaration and
   function definition in order, then checks that main is defined (unless
   compiling the runtime) and that every prototype that is not a builtin
   has a definition (there is no linker after this stage).  Results go to `out'; errors to the diagnostics. */
void Sema::run(Node* program, AnalysisResult& out) {
    R = &out;
    registerBuiltins();
    S.push();                     /* file scope, on top of the builtin scope */

    for (size_t i = 0; i < program->kids.size(); ++i) {
        Node* d = program->kids[i];
        if (!d) continue;
        if (d->kind == N_FUNCDEF) funcDefinition(d);
        else if (d->kind == N_DECL) declaration(d, true);
    }

    Sym* mainSym = S.lookup("main");
    if (!runtimeMode && (!mainSym || mainSym->kind != SK_FUNC || !mainSym->defined || mainSym->isExternal))
        D.error(0, 0, "no definition of 'main' was found in this translation unit");

    /* a prototype that was never defined and is not a built-in is an error,
       because there is no linker stage after this one */
    for (size_t i = 0; i < program->kids.size(); ++i) {
        Node* d = program->kids[i];
        if (!d || d->kind != N_DECL) continue;
        for (size_t j = 1; j < d->kids.size(); ++j) {
            Sym* s = d->kids[j]->sym;
            if (s && s->kind == SK_FUNC && !s->defined && s->used && !s->isExternal
                && !runtimeMode)
                D.error(s->line, 0, "function '" + s->name +
                        "' is declared and called but never defined");
        }
    }
    S.pop();

    /* The IR generator outlives this Sema, so it cannot keep borrowing our
       symbols: hand them over. */
    S.takeOwnership(out.symPool);
}

/* The lvalue e designates global storage at a constant offset. */
static bool constLvalue(const Node* e, std::string* sym, long long* off) {
    if (!e) return false;
    switch (e->kind) {
        case N_ID:
            if (!e->sym || e->sym->kind != SK_GLOBAL) return false;
            if (sym) *sym = e->sym->uniq;
            if (off) *off = 0;
            return true;
        case N_INDEX: {
            const Node* a = e->kid(0);
            const Node* i = e->kid(1);
            if (!a || !i || !a->decayed || !i->isConst || !e->type) return false;
            long long base = 0;
            if (!constLvalue(a, sym, &base)) return false;
            /* a decayed sub-array (a[1] in a[1][2]) is an array of rows */
            const Type* et = (e->decayed && e->origType) ? e->origType : e->type;
            if (off) *off = base + i->constVal * typeSize(et);
            return true;
        }
        case N_MEMBER: {
            long long base = 0;
            if (!e->member || !constLvalue(e->kid(0), sym, &base)) return false;
            if (off) *off = base + e->member->offset;
            return true;
        }
        default:
            return false;
    }
}

bool addressConstant(const Node* e, std::string* sym, long long* off) {
    if (!e) return false;
    if (e->kind == N_ADDR) return constLvalue(e->kid(0), sym, off);
    if (e->decayed && e->origType && isArray(e->origType)) return constLvalue(e, sym, off);
    return false;
}
