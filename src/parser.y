%{
/* parser.y -- grammar for the IR generator.
 *
 * Derived from ../../syntax-analyzer/src/parser.y (read-only original).  The
 * grammar itself is unchanged except for one added rule (UnknownTypeDecl, see
 * below); what changed is that every production now BUILDS AN AST NODE instead
 * of only printing a token table.  Semantic analysis and IR generation are
 * separate passes over that tree, because
 *   - an expression's type must be known before code can be emitted for it,
 *   - `goto` may target a label defined later in the function, and
 *   - struct/typedef/enum declarations supply layout information that uses of
 *     those types need.
 * None of that is available in a single bottom-up sweep inside the actions.
 */
#include <iostream>
#include <string>
#include <vector>
#include <cstdio>
#include <cstring>
#include "ast.h"

extern int   yylex();
extern int   line_num;
extern FILE* yyin;
extern std::string last_lexeme;

extern void register_typedef_name(const char* name);
/* The reverse of a typedef registration: an ordinary name that hides a
   typedef name of the same spelling for the rest of its scope, and the
   parameter names that belong to the scope the function body opens. */
extern void register_ordinary_name(const char* name);
extern void register_param_name(const char* name);
extern void clear_param_names(void);
extern void init_typedef_names(void);

void yyerror(const char* s);

int syntax_errors  = 0;
int lexical_errors = 0;

Node* g_program = 0;

static int in_typedef_decl = 0;

void report_lex_error(int line, int col,
                      const std::string& lexeme, const std::string& reason) {
    lexical_errors++;
    std::cerr << "Lexical Error [Line " << line << ", Col " << col << "]: "
              << reason << " -> '" << lexeme << "'" << std::endl;
}

/* Semantic mistakes the parser has to find itself; see ParseDiag in ast.h. */
std::vector<ParseDiag> g_parseDiags;
static void parseDiag(int line, int col, const std::string& msg) {
    ParseDiag d; d.line = line; d.col = col; d.msg = msg;
    g_parseDiags.push_back(d);
}

static Node* listNode(int line, int col) { return mk(N_ARGLIST, line, col); }
static Node* appendTo(Node* list, Node* item) { list->kids.push_back(item); return list; }

/* Wrap `count` pointer derivations around a declarator. */
static Node* wrapPointers(int count, Node* inner, int line, int col) {
    for (int i = 0; i < count; ++i) inner = mk1(N_DCL_PTR, line, col, inner);
    return inner;
}

/* Tell the lexer what a declarator just declared: a typedef name, or an
   ordinary name that hides one.  Both matter to the next identifier it reads. */
static void declaredName(const char* name) {
    if (in_typedef_decl) register_typedef_name(name);
    else                 register_ordinary_name(name);
}

/* A declaration whose type specifier is a plain identifier that is not a
   typedef name: `Foo x;' or, at file scope, `Foo *p;'.  The declaration is
   KEPT, with a type specifier that the semantic pass maps to the error type
   (Sema::typeSpec, specifier code 6), for two reasons: the one diagnostic is
   then a semantic one like every other type error, reported at the type name's
   own line and column as gcc reports it; and the declared names still exist,
   with the error type, so that later uses of them stay silent instead of
   cascading into "undeclared identifier".  The initializer, if any, is dropped
   -- there is no type to check it against, and reporting it again would be a
   second message for one root cause. */
/* The name node of a declarator.  A diagnostic about a declared object points
   at its name, like gcc; the declarator's own location is that of its pointer
   prefix -- empty for `int x', which bison then places at the end of the
   preceding token -- so it is not the name's position. */
static Node* declNameNode(Node* d) {
    while (d && d->kind != N_DCL_NAME) d = d->kid(0);
    return d;
}

/* One declarator of a declaration.  A declarator that declares no name is
   grammatically reachable here -- `int [3];', `int (*);' -- because one shared
   sub-grammar serves both the concrete and the abstract declarator, and the
   name is what the abstract form leaves out.  C requires a name here, and
   Sema::declaration already reports the missing one ("declaration declares
   nothing", at this same position), so nothing is said about it here: one root
   cause gets one diagnostic.  All this does is not announce an empty name to
   the lexer. */
static Node* initDeclarator(Node* dcl, Node* init, int line, int col) {
    Node* d = declNameNode(dcl);
    int l = d ? d->line : line, c = d ? d->col : col;
    if (d && !d->sval.empty()) declaredName(d->sval.c_str());
    return mk2(N_INIT_DECL, l, c, dcl, init);
}

static Node* unknownTypeDecl(int line, int col, const char* name,
                             int ptrCount, Node* declList) {
    Node* spec = mk(N_TYPESPEC, line, col);
    spec->ival = 6;
    spec->sval = name;
    Node* d = mk1(N_DECL, line, col, spec);
    d->ival = 0;
    for (size_t i = 0; i < declList->kids.size(); ++i) {
        Node* dcl = declList->kids[i];
        /* `Foo *p, q;' -- the stars belong to the first declarator only. */
        if (i == 0 && ptrCount) dcl = wrapPointers(ptrCount, dcl, dcl->line, dcl->col);
        d->kids.push_back(mk2(N_INIT_DECL, dcl->line, dcl->col, dcl, 0));
    }
    return d;
}
%}

%locations
%define parse.error detailed

%union {
    const char* str;
    Node*       node;
    int         ival;
}

%token <str> IDENTIFIER TYPE_NAME ICONST FCONST CCONST SCONST
%token <str> FLOAT DOUBLE

%token INT CHAR VOID STRUCT UNION ENUM TYPEDEF
%token IF ELSE FOR WHILE DO UNTIL SWITCH CASE DEFAULT
%token BREAK CONTINUE GOTO RETURN SIZEOF

%token ADD_OP SUB_OP MUL_OP DIV_OP MOD_OP
%token EQ_OP NE_OP LT_OP GT_OP LE_OP GE_OP
%token LOG_AND LOG_OR LOG_NOT
%token BIT_AND BIT_OR BIT_XOR BIT_NOT LEFT_OP RIGHT_OP
%token INC_OP DEC_OP ARROW DOT
%token ASSIGN ADD_ASSIGN SUB_ASSIGN MUL_ASSIGN DIV_ASSIGN MOD_ASSIGN
%token AND_ASSIGN OR_ASSIGN XOR_ASSIGN LEFT_ASSIGN RIGHT_ASSIGN

%precedence LOWER_THAN_ELSE
%precedence ELSE

/* Part D.1: the left operand of an assignment is a full CondExpr, so that
   "3 = x", "x + 1 = 4" and "a ? b : c = x" all parse and are then rejected by
   the semantic pass with a precise "not an lvalue" message instead of a bare
   syntax error.  This needs no precedence declaration and adds no conflict:
   the third operand of '?' is a CondExpr, so AssignExpr is never predicted
   after the ':', and "a ? b : c = d" can only reduce the conditional first,
   giving (a ? b : c) = d -- exactly how gcc parses it. */

%type <node> Program TranslationUnit ExternalDecl Decl DeclSpec TypeSpec
%type <node> StructUnionSpec StructDeclList EnumSpec EnumList Enumerator
%type <node> InitDeclaratorList InitDeclarator Declarator DirectDeclarator
%type <node> AbstractDeclarator NonEmptyDirect GroupedDeclarator
%type <node> ParenContent GroupDirect GroupDirectOpt
%type <node> Initializer InitializerList FuncDef ParamList ParamDeclList ParamDecl
%type <node> CompoundStmt BlockItemList BlockItem Stmt ExprStmt SelectionStmt
%type <node> IterStmt ForInit LabeledStmt JumpStmt
%type <node> Expr AssignExpr CondExpr LogOrExpr LogAndExpr BitOrExpr BitXorExpr
%type <node> BitAndExpr EqExpr RelExpr ShiftExpr AddExpr MulExpr CastExpr
%type <node> UnaryExpr PostfixExpr PrimaryExpr ArgList TypeName
%type <str>  TagName
%type <node> PlainDeclarator PlainInitDecl PlainInitDeclList
%type <ival> Pointers PtrStars StructOrUnion
%type <str>  AssignOp

%start Program

%%

/* ================= top level ================= */

Program
    : TranslationUnit            { g_program = $1; $$ = $1; }
    | %empty                     { g_program = mk(N_PROGRAM, 1, 1); $$ = g_program; }
    ;

TranslationUnit
    : ExternalDecl               { $$ = mk(N_PROGRAM, @1.first_line, @1.first_column);
                                   if ($1) $$->kids.push_back($1); }
    | TranslationUnit ExternalDecl
                                 { $$ = $1; if ($2) $$->kids.push_back($2); }
    ;

ExternalDecl
    : FuncDef                    { $$ = $1; }
    | Decl                       { $$ = $1; }
    /* "Foo *p;" at file scope, where Foo is not a typedef name.  The plain-
       identifier declaration in Decl deliberately excludes '*' (at block scope
       "a * b;" would be ambiguous with multiplication), but at file scope an
       expression statement cannot occur, so the pointer form is unambiguous
       here and is accepted only in this context.  Reported at the type name's
       own line and column, like gcc. */
    | IDENTIFIER MUL_OP Pointers PlainInitDeclList ';'
        { in_typedef_decl = 0;
          $$ = unknownTypeDecl(@1.first_line, @1.first_column, $1, $3 + 1, $4); }
    | error ';'                  { yyerrok; in_typedef_decl = 0; $$ = 0; }
    | error '}'                  { yyerrok; in_typedef_decl = 0; $$ = 0; }
    ;

/* ================= declarations ================= */

Decl
    : DeclSpec InitDeclaratorList ';'
        { in_typedef_decl = 0; clear_param_names();
          $$ = $1;
          for (size_t i = 0; i < $2->kids.size(); ++i) $$->kids.push_back($2->kids[i]); }
    | DeclSpec ';'
        { in_typedef_decl = 0; clear_param_names(); $$ = $1; }
    /* A declaration whose type specifier is a plain identifier: the name is not
       (yet) a typedef name.  Accepting it here turns "type used before its
       typedef" into a precise semantic diagnostic instead of a bare syntax
       error.  Restricted to a declarator with no '*' and no '(' so that it adds
       no conflict with multiplication or with a function call. */
    | IDENTIFIER PlainInitDeclList ';'
        { in_typedef_decl = 0;
          $$ = unknownTypeDecl(@1.first_line, @1.first_column, $1, 0, $2); }
    ;

PlainInitDeclList
    : PlainInitDecl                          { $$ = listNode(@1.first_line, @1.first_column);
                                               appendTo($$, $1); }
    | PlainInitDeclList ',' PlainInitDecl    { $$ = appendTo($1, $3); }
    ;

PlainInitDecl
    : PlainDeclarator                        { $$ = $1; }
    | PlainDeclarator ASSIGN Initializer     { $$ = $1; }
    ;

PlainDeclarator
    : IDENTIFIER                                  { $$ = mk(N_DCL_NAME, @1.first_line, @1.first_column);
                                                    $$->sval = $1; }
    | PlainDeclarator '[' ']'                     { $$ = mk2(N_DCL_ARRAY, @1.first_line, @1.first_column, $1, 0); }
    | PlainDeclarator '[' CondExpr ']'            { $$ = mk2(N_DCL_ARRAY, @1.first_line, @1.first_column, $1, $3); }
    ;

DeclSpec
    /* `in_typedef_decl' is deliberately NOT cleared here.  A declarator may
       contain a whole nested declaration -- the parameter list of
       `typedef int (*BinOp)(int, int);' -- whose specifiers reduce through this
       rule BEFORE the outer declarator is reduced, and clearing the flag there
       would lose the name BinOp.  The flag is cleared where a declaration
       really does end: in Decl, in FuncDef, and in the error recoveries. */
    : TypeSpec            { $$ = mk1(N_DECL, @1.first_line, @1.first_column, $1);
                            $$->ival = 0; }
    | TYPEDEF TypeSpec    { in_typedef_decl = 1;
                            $$ = mk1(N_DECL, @1.first_line, @1.first_column, $2);
                            $$->ival = 1; }
    ;

TypeSpec
    : INT             { $$ = mk(N_TYPESPEC, @1.first_line, @1.first_column); $$->ival = 0; }
    | CHAR            { $$ = mk(N_TYPESPEC, @1.first_line, @1.first_column); $$->ival = 1; }
    | FLOAT           { $$ = mk(N_TYPESPEC, @1.first_line, @1.first_column); $$->ival = 2;
                        $$->sval = "float"; }
    | DOUBLE          { $$ = mk(N_TYPESPEC, @1.first_line, @1.first_column); $$->ival = 3;
                        $$->sval = "double"; }
    | VOID            { $$ = mk(N_TYPESPEC, @1.first_line, @1.first_column); $$->ival = 4; }
    | TYPE_NAME       { $$ = mk(N_TYPESPEC, @1.first_line, @1.first_column); $$->ival = 5;
                        $$->sval = $1; }
    | StructUnionSpec { $$ = $1; }
    | EnumSpec        { $$ = $1; }
    ;

StructUnionSpec
    : StructOrUnion TagName '{' StructDeclList '}'
        { $$ = $4; $$->kind = N_STRUCTSPEC; $$->sval = $2; $$->ival = $1 | 2;
          $$->line = @1.first_line; $$->col = @1.first_column; }
    | StructOrUnion '{' StructDeclList '}'
        { $$ = $3; $$->kind = N_STRUCTSPEC; $$->sval = ""; $$->ival = $1 | 2;
          $$->line = @1.first_line; $$->col = @1.first_column; }
    | StructOrUnion TagName
        { $$ = mk(N_STRUCTSPEC, @1.first_line, @1.first_column); $$->sval = $2; $$->ival = $1; }
    ;

/* After `struct`, `union` or `enum` the identifier is a TAG, and tags live in
   a namespace of their own.  The scanner cannot know that, so after
   `typedef struct Item Item;` it classifies the tag in `struct Item { ... }`
   as a TYPE_NAME.  Accepting either token here keeps that idiom working; there
   is no ambiguity, because only a tag can follow these keywords. */
TagName
    : IDENTIFIER    { $$ = $1; }
    | TYPE_NAME     { $$ = $1; }
    ;

StructOrUnion
    : STRUCT    { $$ = 0; }
    | UNION     { $$ = 1; }
    ;

StructDeclList
    : Decl                    { $$ = listNode(@1.first_line, @1.first_column);
                                if ($1) appendTo($$, $1); }
    | StructDeclList Decl     { $$ = $1; if ($2) appendTo($$, $2); }
    ;

EnumSpec
    : ENUM TagName '{' EnumList '}'
        { $$ = $4; $$->kind = N_ENUMSPEC; $$->sval = $2; $$->ival = 2;
          $$->line = @1.first_line; $$->col = @1.first_column; }
    | ENUM '{' EnumList '}'
        { $$ = $3; $$->kind = N_ENUMSPEC; $$->sval = ""; $$->ival = 2;
          $$->line = @1.first_line; $$->col = @1.first_column; }
    | ENUM TagName
        { $$ = mk(N_ENUMSPEC, @1.first_line, @1.first_column); $$->sval = $2; $$->ival = 0; }
    ;

EnumList
    : Enumerator                   { $$ = listNode(@1.first_line, @1.first_column);
                                     appendTo($$, $1); }
    | EnumList ',' Enumerator      { $$ = appendTo($1, $3); }
    ;

Enumerator
    : IDENTIFIER
        { $$ = mk1(N_ENUMERATOR, @1.first_line, @1.first_column, 0);
          $$->kids.clear(); $$->kids.push_back(0); $$->sval = $1; }
    | IDENTIFIER ASSIGN CondExpr
        { $$ = mk1(N_ENUMERATOR, @1.first_line, @1.first_column, $3); $$->sval = $1; }
    ;

InitDeclaratorList
    : InitDeclarator                          { $$ = listNode(@1.first_line, @1.first_column);
                                                appendTo($$, $1); }
    | InitDeclaratorList ',' InitDeclarator   { $$ = appendTo($1, $3); }
    ;

InitDeclarator
    : Declarator
        { $$ = initDeclarator($1, 0, @1.first_line, @1.first_column); }
    | Declarator ASSIGN Initializer
        { $$ = initDeclarator($1, $3, @1.first_line, @1.first_column); }
    ;

/* A declarator and an abstract declarator differ in exactly one thing: the
   abstract one leaves the name out.  They are therefore ONE sub-grammar here,
   entered either requiring a name (Declarator) or not (AbstractDeclarator),
   and sharing everything below.  Writing the abstract form as a separate
   hand-made subset is what let the two drift apart, so that `int (*p)[6]' was
   accepted as a declarator while `sizeof(int (*)[6])' was a syntax error, and
   so that an unnamed parameter could be no more than `T', `T *' or `T **'. */

Declarator
    /* The entry that requires a name: a declaration and a function definition.
       It cannot derive the empty string, which is what keeps `int;' -- the
       `DeclSpec ";"' rule in Decl -- unambiguous. */
    : Pointers NonEmptyDirect
        { $$ = wrapPointers($1, $2, @2.first_line, @2.first_column); }
    ;

AbstractDeclarator
    /* The entry where the name is optional: an unnamed parameter and a type
       name.  `int', `int *', `int [3]', `int (*)[6]', `int (*)(int)',
       `int (*[2])(int)'. */
    : Pointers DirectDeclarator
        { $$ = wrapPointers($1, $2, @2.first_line, @2.first_column); }
    ;

DirectDeclarator
    /* The nameless innermost declarator.  Everything an abstract declarator
       can do that a concrete one cannot comes from this one production. */
    : %empty                                { $$ = mk(N_DCL_NAME, @$.first_line, @$.first_column);
                                              $$->sval = ""; }
    | NonEmptyDirect                        { $$ = $1; }
    ;

NonEmptyDirect
    : IDENTIFIER                            { $$ = mk(N_DCL_NAME, @1.first_line, @1.first_column);
                                              $$->sval = $1; }
    /* A name being DECLARED may be one the lexer already classifies as a
       typedef name, as in `typedef char Int;` inside a block where Int is
       already a typedef, or in `int printf;`.  The lexer hack cannot tell
       declarator position from type-specifier position, so the grammar accepts
       a TYPE_NAME here; there is no ambiguity, because a declaration in this
       language has exactly one type specifier and it has already been read. */
    | TYPE_NAME                             { $$ = mk(N_DCL_NAME, @1.first_line, @1.first_column);
                                              $$->sval = $1; }
    | '(' ParenContent ')'                  { $$ = $2; }
    | DirectDeclarator '[' ']'              { $$ = mk2(N_DCL_ARRAY, @1.first_line, @1.first_column, $1, 0); }
    | DirectDeclarator '[' CondExpr ']'     { $$ = mk2(N_DCL_ARRAY, @1.first_line, @1.first_column, $1, $3); }
    /* A function derivation after something that is already a direct
       declarator: `f(int)', `(*p)(int)'.  The nameless `(int)' is the
       ParenContent rule below instead, because at that point the '(' has
       already been shifted and there is nothing to its left. */
    | NonEmptyDirect '(' ParamList ')'      { $$ = mk2(N_DCL_FUNC, @1.first_line, @1.first_column, $1, $3); }
    ;

ParenContent
    /* A '(' in declarator position opens one of two different things, and C
       resolves which by what follows it:

         a GROUP, the derivations that bind tighter than what comes after the
         closing parenthesis -- `(*p)[3]', `(*)(int)', `(x)', `([3])';

         a PARAMETER LIST, making a nameless function type -- `int (int)',
         `int (void)', `int ()', whose one legal use in C is as a parameter,
         where it is adjusted to a pointer to function.

       Both alternatives are reached by shifting the same '(', so the parser
       never has to choose between them on the parenthesis itself: it decides
       on the NEXT token, and the two first sets are disjoint.  A group starts
       with '*', an identifier, '(' or '['; a parameter list starts with a type
       specifier or is empty.  The one token in both is a typedef name, and
       `int (Byte)' is where C itself has to choose -- it reads the parameter
       list, a function taking a Byte.  GroupDirect below is therefore the
       group's direct declarator with the bare typedef-name leaf left out, so
       that this grammar makes the same choice. */
    : GroupedDeclarator   { $$ = $1; }
    | ParamList
        { Node* nm = mk(N_DCL_NAME, @$.first_line, @$.first_column); nm->sval = "";
          $$ = mk2(N_DCL_FUNC, @$.first_line, @$.first_column, nm, $1); }
    ;

GroupedDeclarator
    /* The group reading: a declarator carrying at least one derivation, named
       or not -- `(x)', `(*x)', `(*)', `(**)', `(*x[3])', `(*[3])', `([3])'.
       The empty declarator is excluded, so `()' can only be the empty
       parameter list above. */
    : PtrStars DirectDeclarator
        { $$ = wrapPointers($1, $2, @1.first_line, @1.first_column); }
    | GroupDirect
        { $$ = $1; }
    ;

GroupDirect
    /* NonEmptyDirect without the bare TYPE_NAME leaf, for the reason given in
       ParenContent.  A typedef name is still reachable inside parentheses
       behind a star, `(*Byte)', where no parameter list can begin. */
    : IDENTIFIER                            { $$ = mk(N_DCL_NAME, @1.first_line, @1.first_column);
                                              $$->sval = $1; }
    | '(' ParenContent ')'                  { $$ = $2; }
    | GroupDirectOpt '[' ']'                { $$ = mk2(N_DCL_ARRAY, @1.first_line, @1.first_column, $1, 0); }
    | GroupDirectOpt '[' CondExpr ']'       { $$ = mk2(N_DCL_ARRAY, @1.first_line, @1.first_column, $1, $3); }
    | GroupDirect '(' ParamList ')'         { $$ = mk2(N_DCL_FUNC, @1.first_line, @1.first_column, $1, $3); }
    ;

GroupDirectOpt
    : %empty                                { $$ = mk(N_DCL_NAME, @$.first_line, @$.first_column);
                                              $$->sval = ""; }
    | GroupDirect                           { $$ = $1; }
    ;

Pointers
    : %empty              { $$ = 0; }
    | PtrStars            { $$ = $1; }
    ;

PtrStars
    /* Non-empty and left-recursive.  Splitting the nullable part off into
       `Pointers' is what lets a '*' just inside a group's parentheses be
       shifted: with one nullable `Pointers' used in both places the parser
       would have to decide, on seeing '*', whether to reduce an empty
       `Pointers' for the named path or shift for the abstract one. */
    : MUL_OP              { $$ = 1; }
    | PtrStars MUL_OP     { $$ = $1 + 1; }
    ;

Initializer
    : AssignExpr                        { $$ = $1; }
    | '{' '}'                           { $$ = mk(N_INIT_LIST, @1.first_line, @1.first_column); }
    | '{' InitializerList '}'           { $$ = $2; $$->kind = N_INIT_LIST; }
    | '{' InitializerList ',' '}'       { $$ = $2; $$->kind = N_INIT_LIST; }
    ;

InitializerList
    : Initializer                       { $$ = listNode(@1.first_line, @1.first_column);
                                          appendTo($$, $1); }
    | InitializerList ',' Initializer   { $$ = appendTo($1, $3); }
    ;

/* ================= functions ================= */

FuncDef
    : DeclSpec Declarator CompoundStmt
        { $$ = mk3(N_FUNCDEF, @1.first_line, @1.first_column, $1->kid(0), $2, $3);
          if ($1->ival)
              parseDiag(@1.first_line, @1.first_column,
                        "'typedef' cannot be used on a function definition");
          in_typedef_decl = 0; }
    ;

ParamList
    : %empty              { $$ = listNode(yylloc.first_line, yylloc.first_column); }
    | ParamDeclList       { $$ = $1; }
    ;

ParamDeclList
    : ParamDecl                       { $$ = listNode(@1.first_line, @1.first_column);
                                        appendTo($$, $1); }
    | ParamDeclList ',' ParamDecl     { $$ = appendTo($1, $3); }
    ;

ParamDecl
    /* A parameter name belongs to the scope the function body opens, which the
       lexer has not pushed yet, so it is remembered until the body's brace.
       One rule covers the named and the unnamed parameter, since the name is
       optional in an AbstractDeclarator.  The two rules this replaces were a
       named declarator and bare pointer stars, which is why an unnamed
       parameter could only ever be `T', `T *' or `T **'. */
    : DeclSpec AbstractDeclarator
        { Node* d = declNameNode($2);
          if (d && !d->sval.empty()) register_param_name(d->sval.c_str());
          $$ = mk2(N_PARAM, @1.first_line, @1.first_column, $1->kid(0), $2); }
    ;

/* ================= statements ================= */

CompoundStmt
    : '{' '}'                    { $$ = mk(N_COMPOUND, @1.first_line, @1.first_column); }
    | '{' BlockItemList '}'      { $$ = $2; $$->kind = N_COMPOUND; }
    | '{' error '}'              { yyerrok; $$ = mk(N_COMPOUND, @1.first_line, @1.first_column); }
    ;

BlockItemList
    : BlockItem                  { $$ = listNode(@1.first_line, @1.first_column);
                                   if ($1) appendTo($$, $1); }
    | BlockItemList BlockItem    { $$ = $1; if ($2) appendTo($$, $2); }
    ;

BlockItem
    : Decl        { $$ = $1; }
    | Stmt        { $$ = $1; }
    | error ';'   { yyerrok; $$ = 0; }
    ;

Stmt
    : CompoundStmt   { $$ = $1; }
    | ExprStmt       { $$ = $1; }
    | SelectionStmt  { $$ = $1; }
    | IterStmt       { $$ = $1; }
    | JumpStmt       { $$ = $1; }
    | LabeledStmt    { $$ = $1; }
    ;

ExprStmt
    : ';'            { $$ = mk(N_EXPRSTMT, @1.first_line, @1.first_column);
                       $$->kids.push_back(0); }
    | Expr ';'       { $$ = mk1(N_EXPRSTMT, @1.first_line, @1.first_column, $1); }
    ;

SelectionStmt
    : IF '(' Expr ')' Stmt   %prec LOWER_THAN_ELSE
        { $$ = mk3(N_IF, @1.first_line, @1.first_column, $3, $5, 0); }
    | IF '(' Expr ')' Stmt ELSE Stmt
        { $$ = mk3(N_IF, @1.first_line, @1.first_column, $3, $5, $7); }
    | SWITCH '(' Expr ')' Stmt
        { $$ = mk2(N_SWITCH, @1.first_line, @1.first_column, $3, $5); }
    | IF '(' error ')' Stmt  %prec LOWER_THAN_ELSE { yyerrok; $$ = 0; }
    | SWITCH '(' error ')' Stmt                    { yyerrok; $$ = 0; }
    | IF '(' error ';'                             { yyerrok; $$ = 0; }
    | SWITCH '(' error ';'                         { yyerrok; $$ = 0; }
    | IF '(' error CompoundStmt  %prec LOWER_THAN_ELSE { yyerrok; $$ = 0; }
    | SWITCH '(' error CompoundStmt                    { yyerrok; $$ = 0; }
    ;

/* `until (cond) stmt` is a PRE-CHECK loop, equivalent to while (!cond). */
IterStmt
    : WHILE '(' Expr ')' Stmt
        { $$ = mk2(N_WHILE, @1.first_line, @1.first_column, $3, $5); }
    | DO Stmt WHILE '(' Expr ')' ';'
        { $$ = mk2(N_DO, @1.first_line, @1.first_column, $2, $5); }
    | UNTIL '(' Expr ')' Stmt
        { $$ = mk2(N_UNTIL, @1.first_line, @1.first_column, $3, $5); }
    | FOR '(' ForInit ExprStmt ')' Stmt
        { $$ = mk(N_FOR, @1.first_line, @1.first_column);
          $$->kids.push_back($3); $$->kids.push_back($4 ? $4->kid(0) : 0);
          $$->kids.push_back(0);  $$->kids.push_back($6); }
    | FOR '(' ForInit ExprStmt Expr ')' Stmt
        { $$ = mk(N_FOR, @1.first_line, @1.first_column);
          $$->kids.push_back($3); $$->kids.push_back($4 ? $4->kid(0) : 0);
          $$->kids.push_back($5); $$->kids.push_back($7); }
    | WHILE '(' error ')' Stmt      { yyerrok; $$ = 0; }
    | UNTIL '(' error ')' Stmt      { yyerrok; $$ = 0; }
    | FOR   '(' error ')' Stmt      { yyerrok; $$ = 0; }
    | WHILE '(' error ';'           { yyerrok; $$ = 0; }
    | UNTIL '(' error ';'           { yyerrok; $$ = 0; }
    | WHILE '(' error CompoundStmt  { yyerrok; $$ = 0; }
    | UNTIL '(' error CompoundStmt  { yyerrok; $$ = 0; }
    | FOR   '(' error CompoundStmt  { yyerrok; $$ = 0; }
    ;

ForInit
    : ExprStmt   { $$ = $1; }
    | Decl       { $$ = $1; }
    ;

LabeledStmt
    : IDENTIFIER ':' Stmt      { $$ = mk1(N_LABEL, @1.first_line, @1.first_column, $3);
                                 $$->sval = $1; }
    /* Labels have their own namespace too, so a label may be spelled like a
       typedef name.  `C:' and a declaration `C x;' are told apart by the token
       after the name, which is within the one token of lookahead. */
    | TYPE_NAME ':' Stmt       { $$ = mk1(N_LABEL, @1.first_line, @1.first_column, $3);
                                 $$->sval = $1; }
    | CASE CondExpr ':' Stmt   { $$ = mk2(N_CASE, @1.first_line, @1.first_column, $2, $4); }
    | DEFAULT ':' Stmt         { $$ = mk1(N_DEFAULT, @1.first_line, @1.first_column, $3); }
    | CASE error ':' Stmt      { yyerrok; $$ = 0; }
    ;

JumpStmt
    : GOTO IDENTIFIER ';'   { $$ = mk(N_GOTO, @1.first_line, @1.first_column); $$->sval = $2; }
    | GOTO TYPE_NAME ';'    { $$ = mk(N_GOTO, @1.first_line, @1.first_column); $$->sval = $2; }
    | CONTINUE ';'          { $$ = mk(N_CONTINUE, @1.first_line, @1.first_column); }
    | BREAK ';'             { $$ = mk(N_BREAK, @1.first_line, @1.first_column); }
    | RETURN ';'            { $$ = mk(N_RETURN, @1.first_line, @1.first_column);
                              $$->kids.push_back(0); }
    | RETURN Expr ';'       { $$ = mk1(N_RETURN, @1.first_line, @1.first_column, $2); }
    ;

/* ================= expressions ================= */

Expr
    : AssignExpr             { $$ = $1; }
    | Expr ',' AssignExpr    { $$ = mk2(N_COMMA, @2.first_line, @2.first_column, $1, $3); }
    ;

AssignExpr
    : CondExpr                           { $$ = $1; }
    /* Part D.1: a full CondExpr, not just a UnaryExpr, on the left.  Whether
       the left operand is assignable is decided in the semantic pass, which can
       name the real problem ("not an lvalue") and point at the operator. */
    | CondExpr AssignOp AssignExpr       { $$ = mk2(N_ASSIGN, @2.first_line, @2.first_column, $1, $3);
                                           $$->sval = $2; }
    ;

AssignOp
    : ASSIGN        { $$ = "=";   }
    | ADD_ASSIGN    { $$ = "+=";  }
    | SUB_ASSIGN    { $$ = "-=";  }
    | MUL_ASSIGN    { $$ = "*=";  }
    | DIV_ASSIGN    { $$ = "/=";  }
    | MOD_ASSIGN    { $$ = "%=";  }
    | AND_ASSIGN    { $$ = "&=";  }
    | OR_ASSIGN     { $$ = "|=";  }
    | XOR_ASSIGN    { $$ = "^=";  }
    | LEFT_ASSIGN   { $$ = "<<="; }
    | RIGHT_ASSIGN  { $$ = ">>="; }
    ;

CondExpr
    : LogOrExpr                             { $$ = $1; }
    | LogOrExpr '?' Expr ':' CondExpr       { $$ = mk3(N_COND, @2.first_line, @2.first_column,
                                                       $1, $3, $5); }
    ;

LogOrExpr
    : LogAndExpr                     { $$ = $1; }
    | LogOrExpr LOG_OR LogAndExpr    { $$ = mk2(N_BINOP, @2.first_line, @2.first_column, $1, $3);
                                       $$->sval = "||"; }
    ;

LogAndExpr
    : BitOrExpr                      { $$ = $1; }
    | LogAndExpr LOG_AND BitOrExpr   { $$ = mk2(N_BINOP, @2.first_line, @2.first_column, $1, $3);
                                       $$->sval = "&&"; }
    ;

BitOrExpr
    : BitXorExpr                     { $$ = $1; }
    | BitOrExpr BIT_OR BitXorExpr    { $$ = mk2(N_BINOP, @2.first_line, @2.first_column, $1, $3);
                                       $$->sval = "|"; }
    ;

BitXorExpr
    : BitAndExpr                     { $$ = $1; }
    | BitXorExpr BIT_XOR BitAndExpr  { $$ = mk2(N_BINOP, @2.first_line, @2.first_column, $1, $3);
                                       $$->sval = "^"; }
    ;

BitAndExpr
    : EqExpr                         { $$ = $1; }
    | BitAndExpr BIT_AND EqExpr      { $$ = mk2(N_BINOP, @2.first_line, @2.first_column, $1, $3);
                                       $$->sval = "&"; }
    ;

EqExpr
    : RelExpr                        { $$ = $1; }
    | EqExpr EQ_OP RelExpr           { $$ = mk2(N_BINOP, @2.first_line, @2.first_column, $1, $3);
                                       $$->sval = "=="; }
    | EqExpr NE_OP RelExpr           { $$ = mk2(N_BINOP, @2.first_line, @2.first_column, $1, $3);
                                       $$->sval = "!="; }
    ;

RelExpr
    : ShiftExpr                      { $$ = $1; }
    | RelExpr LT_OP ShiftExpr        { $$ = mk2(N_BINOP, @2.first_line, @2.first_column, $1, $3);
                                       $$->sval = "<"; }
    | RelExpr GT_OP ShiftExpr        { $$ = mk2(N_BINOP, @2.first_line, @2.first_column, $1, $3);
                                       $$->sval = ">"; }
    | RelExpr LE_OP ShiftExpr        { $$ = mk2(N_BINOP, @2.first_line, @2.first_column, $1, $3);
                                       $$->sval = "<="; }
    | RelExpr GE_OP ShiftExpr        { $$ = mk2(N_BINOP, @2.first_line, @2.first_column, $1, $3);
                                       $$->sval = ">="; }
    ;

ShiftExpr
    : AddExpr                        { $$ = $1; }
    | ShiftExpr LEFT_OP AddExpr      { $$ = mk2(N_BINOP, @2.first_line, @2.first_column, $1, $3);
                                       $$->sval = "<<"; }
    | ShiftExpr RIGHT_OP AddExpr     { $$ = mk2(N_BINOP, @2.first_line, @2.first_column, $1, $3);
                                       $$->sval = ">>"; }
    ;

AddExpr
    : MulExpr                        { $$ = $1; }
    | AddExpr ADD_OP MulExpr         { $$ = mk2(N_BINOP, @2.first_line, @2.first_column, $1, $3);
                                       $$->sval = "+"; }
    | AddExpr SUB_OP MulExpr         { $$ = mk2(N_BINOP, @2.first_line, @2.first_column, $1, $3);
                                       $$->sval = "-"; }
    ;

MulExpr
    : CastExpr                       { $$ = $1; }
    | MulExpr MUL_OP CastExpr        { $$ = mk2(N_BINOP, @2.first_line, @2.first_column, $1, $3);
                                       $$->sval = "*"; }
    | MulExpr DIV_OP CastExpr        { $$ = mk2(N_BINOP, @2.first_line, @2.first_column, $1, $3);
                                       $$->sval = "/"; }
    | MulExpr MOD_OP CastExpr        { $$ = mk2(N_BINOP, @2.first_line, @2.first_column, $1, $3);
                                       $$->sval = "%"; }
    ;

CastExpr
    : UnaryExpr                      { $$ = $1; }
    | '(' TypeName ')' CastExpr      { $$ = mk2(N_CAST, @1.first_line, @1.first_column, $2, $4); }
    ;

UnaryExpr
    : PostfixExpr            { $$ = $1; }
    | INC_OP UnaryExpr       { $$ = mk1(N_PREINC, @1.first_line, @1.first_column, $2); }
    | DEC_OP UnaryExpr       { $$ = mk1(N_PREDEC, @1.first_line, @1.first_column, $2); }
    | ADD_OP CastExpr        { $$ = mk1(N_UNOP, @1.first_line, @1.first_column, $2); $$->sval = "+"; }
    | SUB_OP CastExpr        { $$ = mk1(N_UNOP, @1.first_line, @1.first_column, $2); $$->sval = "-"; }
    | LOG_NOT CastExpr       { $$ = mk1(N_UNOP, @1.first_line, @1.first_column, $2); $$->sval = "!"; }
    | BIT_NOT CastExpr       { $$ = mk1(N_UNOP, @1.first_line, @1.first_column, $2); $$->sval = "~"; }
    | BIT_AND CastExpr       { $$ = mk1(N_ADDR,  @1.first_line, @1.first_column, $2); }
    | MUL_OP CastExpr        { $$ = mk1(N_DEREF, @1.first_line, @1.first_column, $2); }
    | SIZEOF UnaryExpr       { $$ = mk1(N_SIZEOF_EXPR, @1.first_line, @1.first_column, $2); }
    | SIZEOF '(' TypeName ')'{ $$ = mk1(N_SIZEOF_TYPE, @1.first_line, @1.first_column, $3); }
    ;

PostfixExpr
    : PrimaryExpr                       { $$ = $1; }
    | PostfixExpr '[' Expr ']'          { $$ = mk2(N_INDEX, @2.first_line, @2.first_column, $1, $3); }
    | PostfixExpr '(' ')'               { $$ = mk2(N_CALL, @1.first_line, @1.first_column, $1, 0); }
    | PostfixExpr '(' ArgList ')'       { $$ = mk2(N_CALL, @1.first_line, @1.first_column, $1, $3); }
    | PostfixExpr '(' error ')'         { yyerrok; $$ = mk2(N_CALL, @1.first_line, @1.first_column, $1, 0); }
    | PostfixExpr DOT IDENTIFIER        { $$ = mk1(N_MEMBER, @2.first_line, @2.first_column, $1);
                                          $$->sval = $3; }
    | PostfixExpr ARROW IDENTIFIER      { $$ = mk1(N_ARROW, @2.first_line, @2.first_column, $1);
                                          $$->sval = $3; }
    /* Members live in their own namespace, so a member may be spelled like a
       typedef name: `typedef int C; struct S { int C; }; s.C = 1;' is valid C.
       Only a name can follow `.' or `->', so accepting TYPE_NAME here is
       unambiguous. */
    | PostfixExpr DOT TYPE_NAME         { $$ = mk1(N_MEMBER, @2.first_line, @2.first_column, $1);
                                          $$->sval = $3; }
    | PostfixExpr ARROW TYPE_NAME       { $$ = mk1(N_ARROW, @2.first_line, @2.first_column, $1);
                                          $$->sval = $3; }
    | PostfixExpr INC_OP                { $$ = mk1(N_POSTINC, @2.first_line, @2.first_column, $1); }
    | PostfixExpr DEC_OP                { $$ = mk1(N_POSTDEC, @2.first_line, @2.first_column, $1); }
    ;

PrimaryExpr
    : IDENTIFIER   { $$ = mk(N_ID, @1.first_line, @1.first_column); $$->sval = $1; }
    | ICONST       { $$ = mk(N_ICONST, @1.first_line, @1.first_column);
                     $$->ival = parseIntLiteral($1); }
    | FCONST       { $$ = mk(N_FCONST, @1.first_line, @1.first_column); $$->sval = $1; }
    | CCONST       { $$ = mk(N_CCONST, @1.first_line, @1.first_column);
                     long long v = 0;
                     if (!decodeCharLiteral($1, &v))
                         parseDiag(@1.first_line, @1.first_column,
                                   std::string("invalid character constant ") + $1);
                     $$->ival = v; }
    | SCONST       { $$ = mk(N_SCONST, @1.first_line, @1.first_column);
                     std::string bytes;
                     if (!decodeStringLiteral($1, &bytes))
                         parseDiag(@1.first_line, @1.first_column,
                                   std::string("invalid string literal ") + $1);
                     $$->sval = bytes; }
    | '(' Expr ')' { $$ = $2; }
    ;

ArgList
    : AssignExpr                { $$ = listNode(@1.first_line, @1.first_column);
                                  appendTo($$, $1); }
    | ArgList ',' AssignExpr    { $$ = appendTo($1, $3); }
    ;

TypeName
    /* A type name -- what `sizeof' and a cast take -- is a declaration with
       the declarator's name left out, so it is exactly TypeSpec followed by an
       abstract declarator, the same one an unnamed parameter uses.  Sharing it
       is what keeps the two in step: every form one accepts, the other
       accepts.  A name is grammatically reachable through that shared
       sub-grammar and is what C forbids here, so it is reported rather than
       parsed around. */
    : TypeSpec AbstractDeclarator
        { Node* d = declNameNode($2);
          if (d && !d->sval.empty()) {
              std::string m = "a type name cannot declare the identifier '";
              m += d->sval; m += "'";
              parseDiag(d->line, d->col, m.c_str());
          }
          $$ = mk2(N_TYPENAME, @1.first_line, @1.first_column, $1, $2); }
    ;

%%

void yyerror(const char* s) {
    std::string msg(s ? s : "syntax error");
    const std::string prefix = "syntax error, ";
    if (msg.compare(0, prefix.size(), prefix) == 0)
        msg = msg.substr(prefix.size());

    std::cerr << "Syntax Error [Line " << yylloc.first_line
              << ", Col " << yylloc.first_column << "]: " << msg;
    if (!last_lexeme.empty())
        std::cerr << " (found '" << last_lexeme << "')";
    std::cerr << std::endl;

    syntax_errors++;
}
