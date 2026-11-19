#include "ast.h"
#include <cstdlib>
#include <cstdio>
#include <sstream>

/* ================= TypeArena ================= */

Type* TypeArena::make(TypeKind k) {
    types_.push_back(std::unique_ptr<Type>(new Type()));
    Type* t = types_.back().get();
    t->kind = k;
    return t;
}
Type* TypeArena::ptrTo(Type* b)   { Type* t = make(TY_PTR);   t->base = b; return t; }
Type* TypeArena::arrayOf(Type* b, long long n) {
    Type* t = make(TY_ARRAY); t->base = b; t->nelem = n; return t;
}
Type* TypeArena::func(Type* ret, const std::vector<Type*>& ps, bool variadic) {
    Type* t = make(TY_FUNC); t->base = ret; t->params = ps; t->variadic = variadic;
    return t;
}
TagInfo* TypeArena::makeTag(TypeKind k, const std::string& tag) {
    tags_.push_back(std::unique_ptr<TagInfo>(new TagInfo()));
    TagInfo* ti = tags_.back().get();
    ti->kind = k; ti->tag = tag;
    ti->type = make(k);
    ti->type->tag = ti;
    if (k == TY_ENUM) { ti->complete = false; ti->size = 4; ti->align = 4; }
    return ti;
}
Type* TypeArena::tyVoid()  { if (!void_) void_ = make(TY_VOID); return void_; }
Type* TypeArena::tyChar()  { if (!char_) char_ = make(TY_CHAR); return char_; }
Type* TypeArena::tyInt()   { if (!int_)  int_  = make(TY_INT);  return int_;  }
Type* TypeArena::tyFloat() { if (!float_) float_ = make(TY_FLOAT); return float_; }
Type* TypeArena::tyDouble(){ if (!double_) double_ = make(TY_DOUBLE); return double_; }
Type* TypeArena::tyError() { if (!err_)  err_  = make(TY_ERROR);return err_;  }

/* ================= sizes and layout =================
 * The ONLY place these numbers are decided.  MIPS target:
 *   char = 1 (align 1), int = 4 (align 4), pointer = 4 (align 4),
 *   float = 4 (align 4), double = 8 (align 8), enum = int,
 *   array = n * elem, struct/union per the rules below.
 *
 * double's 8-byte alignment is the MIPS O32 rule, and it is what makes
 * `struct { char c; double d; }` 16 bytes here (offset 8 for d) where 32-bit
 * x86 Linux would make it 12.  See docs/REPORT.md.
 */
int alignUp(int v, int a) { if (a <= 1) return v; return (v + a - 1) / a * a; }

int typeSize(const Type* t) {
    if (!t) return 0;
    switch (t->kind) {
        case TY_CHAR: return 1;
        case TY_INT:  return 4;
        case TY_ENUM: return 4;
        case TY_FLOAT: return 4;
        case TY_DOUBLE: return 8;
        case TY_PTR:  return 4;
        case TY_ARRAY:
            if (t->nelem < 0) return 0;               /* incomplete */
            return (int)(t->nelem * typeSize(t->base));
        case TY_STRUCT:
        case TY_UNION:
            return t->tag ? t->tag->size : 0;
        case TY_VOID: case TY_FUNC: case TY_ERROR: default: return 0;
    }
}

int typeAlign(const Type* t) {
    if (!t) return 1;
    switch (t->kind) {
        case TY_CHAR: return 1;
        case TY_INT: case TY_ENUM: case TY_PTR: case TY_FLOAT: return 4;
        case TY_DOUBLE: return 8;
        case TY_ARRAY: return typeAlign(t->base);
        case TY_STRUCT: case TY_UNION: return t->tag ? t->tag->align : 1;
        default: return 1;
    }
}

void layoutTag(TagInfo* ti) {
    if (ti->kind == TY_ENUM) { ti->size = 4; ti->align = 4; return; }
    int off = 0, maxAlign = 1;
    for (size_t i = 0; i < ti->members.size(); ++i) {
        Member& m = ti->members[i];
        int a = typeAlign(m.type);
        int s = typeSize(m.type);
        if (a > maxAlign) maxAlign = a;
        if (ti->kind == TY_UNION) {
            m.offset = 0;                   /* every union member is at 0 */
            if (s > off) off = s;
        } else {
            off = alignUp(off, a);          /* pad to the field's alignment */
            m.offset = off;
            off += s;
        }
    }
    ti->align = maxAlign;
    ti->size  = alignUp(off, maxAlign);     /* round the whole thing up */
    if (ti->size == 0) ti->size = 0;
}

/* ================= predicates ================= */
bool isInteger(const Type* t)   { return t && (t->kind==TY_CHAR||t->kind==TY_INT||t->kind==TY_ENUM); }
bool isFloat(const Type* t)     { return t && (t->kind==TY_FLOAT||t->kind==TY_DOUBLE); }
bool isArith(const Type* t)     { return isInteger(t) || isFloat(t); }
bool isPointer(const Type* t)   { return t && t->kind==TY_PTR; }
bool isArray(const Type* t)     { return t && t->kind==TY_ARRAY; }
bool isScalar(const Type* t)    { return isArith(t) || isPointer(t); }
bool isAggregate(const Type* t) { return t && (t->kind==TY_STRUCT||t->kind==TY_UNION); }
bool isVoid(const Type* t)      { return t && t->kind==TY_VOID; }
bool isError(const Type* t)     { return !t || t->kind==TY_ERROR; }

bool sameType(const Type* a, const Type* b) {
    if (a == b) return true;
    if (!a || !b) return false;
    if (a->kind != b->kind) return false;
    switch (a->kind) {
        case TY_PTR:   return sameType(a->base, b->base);
        case TY_ARRAY: return sameType(a->base, b->base) &&
                              (a->nelem == b->nelem || a->nelem < 0 || b->nelem < 0);
        case TY_STRUCT: case TY_UNION: case TY_ENUM: return a->tag == b->tag;
        case TY_FUNC: {
            if (!sameType(a->base, b->base)) return false;
            if (a->params.size() != b->params.size()) return false;
            for (size_t i = 0; i < a->params.size(); ++i)
                if (!sameType(a->params[i], b->params[i])) return false;
            return a->variadic == b->variadic;
        }
        default: return true;
    }
}

/* The innermost type a declarator wraps: everything that is not a pointer,
   array or function derivation. */
static std::string baseTypeName(const Type* t) {
    switch (t->kind) {
        case TY_ERROR:  return "<error>";
        case TY_VOID:   return "void";
        case TY_CHAR:   return "char";
        case TY_INT:    return "int";
        case TY_FLOAT:  return "float";
        case TY_DOUBLE: return "double";
        case TY_ENUM:   return "enum "   + (t->tag && !t->tag->tag.empty() ? t->tag->tag : std::string("<anonymous>"));
        case TY_STRUCT: return "struct " + (t->tag && !t->tag->tag.empty() ? t->tag->tag : std::string("<anonymous>"));
        case TY_UNION:  return "union "  + (t->tag && !t->tag->tag.empty() ? t->tag->tag : std::string("<anonymous>"));
        default:        return "?";
    }
}

/* Spell a type the way C spells it: as the declarator that would declare it,
   wrapped around a name that for a diagnostic is empty.  `inner' is the text
   built so far, which starts empty and grows outwards, and `starred' says
   whether it currently ends in a pointer derivation -- which is what decides
   the parentheses, since `*X[3]' is an array of pointers while `(*X)[3]' is a
   pointer to an array.  That one rule is the whole algorithm, and it is why
   this is recursive rather than a set of special cases: handling pointer-to-
   function and array-of-function-pointer individually by string surgery, as
   this did before, left a pointer to an array printing as "int [3] *" and a
   pointer to a function returning a pointer to an array as
   "int [2] * (*)(int)" instead of "int (*(*)(int))[2]". */
static std::string renderDecl(const Type* t, const std::string& inner, bool starred) {
    if (!t) return "<null>";
    switch (t->kind) {
        case TY_PTR:
            return renderDecl(t->base, "*" + inner, true);
        case TY_ARRAY: {
            std::ostringstream os;
            os << (starred ? "(" + inner + ")" : inner) << "[";
            if (t->nelem >= 0) os << t->nelem;
            os << "]";
            return renderDecl(t->base, os.str(), false);
        }
        case TY_FUNC: {
            std::ostringstream os;
            os << (starred ? "(" + inner + ")" : inner) << "(";
            for (size_t i = 0; i < t->params.size(); ++i) {
                if (i) os << ", ";
                os << typeName(t->params[i]);
            }
            if (t->variadic)          os << (t->params.empty() ? "..." : ", ...");
            else if (t->params.empty()) os << "void";   /* as gcc spells it */
            os << ")";
            return renderDecl(t->base, os.str(), false);
        }
        default: {
            std::string b = baseTypeName(t);
            return inner.empty() ? b : b + " " + inner;
        }
    }
}

std::string typeName(const Type* t) {
    if (!t) return "<null>";
    return renderDecl(t, "", false);
}

/* The coarse tag carried on `arg` lines and parameter declarations, which is
   all the MIPS stage needs in order to lower printf/scanf. */
std::string irTypeTag(const Type* t) {
    if (!t) return "int";
    switch (t->kind) {
        case TY_CHAR: return "char";
        case TY_INT: case TY_ENUM: return "int";
        case TY_FLOAT: return "float";
        case TY_DOUBLE: return "double";
        case TY_PTR: return t->base && t->base->kind == TY_CHAR ? "str" : "ptr";
        case TY_ARRAY: return t->base && t->base->kind == TY_CHAR ? "str" : "ptr";
        case TY_VOID: return "void";
        case TY_STRUCT: case TY_UNION: return "agg";
        default: return "int";
    }
}

int arithRank(const Type* t) {
    if (!t) return 0;
    switch (t->kind) {
        case TY_CHAR: case TY_INT: case TY_ENUM: return 1;
        case TY_FLOAT:  return 2;
        case TY_DOUBLE: return 3;
        default: return 0;
    }
}

char floatSuffix(const Type* t) { return (t && t->kind == TY_FLOAT) ? 's' : 'd'; }

/* ================= NodeArena ================= */

Node* NodeArena::make(NodeKind k, int line, int col) {
    nodes_.push_back(std::unique_ptr<Node>(new Node(k, line, col)));
    return nodes_.back().get();
}
void NodeArena::clear() { nodes_.clear(); }

NodeArena* g_nodes = 0;
TypeArena* g_types = 0;

Node* mk(NodeKind k, int line, int col) { return g_nodes->make(k, line, col); }
Node* mk1(NodeKind k, int l, int c, Node* a) { Node* n = mk(k,l,c); n->kids.push_back(a); return n; }
Node* mk2(NodeKind k, int l, int c, Node* a, Node* b) {
    Node* n = mk(k,l,c); n->kids.push_back(a); n->kids.push_back(b); return n;
}
Node* mk3(NodeKind k, int l, int c, Node* a, Node* b, Node* d) {
    Node* n = mk(k,l,c); n->kids.push_back(a); n->kids.push_back(b); n->kids.push_back(d); return n;
}

/* ================= literal decoding =================
 * The lexer hands us the raw lexeme including quotes and with escape
 * sequences unprocessed.  Escapes are converted here, once, so the IR's data
 * section holds real bytes ("\n" is byte 10).
 */
static bool readEscape(const std::string& s, size_t& i, int* out) {
    /* s[i] is the character after the backslash */
    if (i >= s.size()) return false;
    char c = s[i++];
    switch (c) {
        case 'a': *out = 7;  return true;
        case 'b': *out = 8;  return true;
        case 'f': *out = 12; return true;
        case 'n': *out = 10; return true;
        case 'r': *out = 13; return true;
        case 't': *out = 9;  return true;
        case 'v': *out = 11; return true;
        case '\\': *out = 92; return true;
        case '\'': *out = 39; return true;
        case '"': *out = 34; return true;
        case '?': *out = 63; return true;
        case '0': case '1': case '2': case '3':
        case '4': case '5': case '6': case '7': {
            int v = c - '0';
            for (int k = 0; k < 2 && i < s.size() && s[i] >= '0' && s[i] <= '7'; ++k)
                v = v * 8 + (s[i++] - '0');
            *out = v & 0xFF;
            return true;
        }
        case 'x': {
            if (i >= s.size() || !isxdigit((unsigned char)s[i])) return false;
            int v = 0;
            while (i < s.size() && isxdigit((unsigned char)s[i])) {
                char h = s[i++];
                int d = (h >= '0' && h <= '9') ? h - '0'
                      : (h >= 'a' && h <= 'f') ? h - 'a' + 10 : h - 'A' + 10;
                v = v * 16 + d;
            }
            *out = v & 0xFF;
            return true;
        }
        default: return false;
    }
}

bool decodeCharLiteral(const std::string& lexeme, long long* out) {
    if (lexeme.size() < 3 || lexeme.front() != '\'' || lexeme.back() != '\'') return false;
    std::string body = lexeme.substr(1, lexeme.size() - 2);
    size_t i = 0;
    int v = 0;
    if (body.empty()) return false;
    if (body[0] == '\\') { i = 1; if (!readEscape(body, i, &v)) return false; }
    else { v = (unsigned char)body[0]; i = 1; }
    if (i != body.size()) return false;          /* multi-character constant */
    *out = (signed char)v;                       /* char is signed on MIPS gcc */
    return true;
}

bool decodeStringLiteral(const std::string& lexeme, std::string* out) {
    if (lexeme.size() < 2 || lexeme.front() != '"' || lexeme.back() != '"') return false;
    std::string body = lexeme.substr(1, lexeme.size() - 2);
    out->clear();
    for (size_t i = 0; i < body.size();) {
        if (body[i] == '\\') {
            ++i;
            int v = 0;
            if (!readEscape(body, i, &v)) return false;
            out->push_back((char)v);
        } else {
            out->push_back(body[i++]);
        }
    }
    return true;
}

long long parseIntLiteral(const std::string& s) {
    if (s.size() > 2 && s[0] == '0' && (s[1] == 'x' || s[1] == 'X'))
        return (long long)strtoll(s.c_str() + 2, 0, 16);
    if (s.size() > 1 && s[0] == '0')
        return (long long)strtoll(s.c_str() + 1, 0, 8);
    return (long long)strtoll(s.c_str(), 0, 10);
}

/* A floating constant with no suffix has type double, exactly as in C; an
   f/F suffix makes it a float.  strtod does the decimal->binary conversion, so
   the value is the host's (and therefore gcc's) correctly-rounded one. */
bool parseFloatLiteral(const std::string& s, double* out, bool* isFloat) {
    std::string body = s;
    *isFloat = false;
    if (!body.empty() && (body.back() == 'f' || body.back() == 'F')) {
        *isFloat = true;
        body.erase(body.size() - 1);
    }
    const char* b = body.c_str();
    char* end = 0;
    double v = strtod(b, &end);
    if (end == b || *end != 0) return false;
    *out = *isFloat ? (double)(float)v : v;      /* round once, to the real type */
    return true;
}

/* %.9g round-trips every binary32 and %.17g every binary64, so the IR text
   carries the exact value and the back end's assembler reproduces the same
   bits.  Trailing ".0" is added when the image would otherwise look integral,
   purely so a reader can tell a float constant at a glance. */
std::string floatImage(double v, bool single) {
    char buf[64];
    if (single) snprintf(buf, sizeof buf, "%.9g", (double)(float)v);
    else        snprintf(buf, sizeof buf, "%.17g", v);
    std::string s(buf);
    if (s.find_first_of(".eEnN") == std::string::npos) s += ".0";
    return s;
}

/* ================= lexeme pool ================= */
namespace {
std::vector<std::unique_ptr<std::string> > g_lexemes;
}
const char* internLexeme(const char* s) {
    g_lexemes.push_back(std::unique_ptr<std::string>(new std::string(s ? s : "")));
    return g_lexemes.back()->c_str();
}
void clearLexemePool() { g_lexemes.clear(); }
