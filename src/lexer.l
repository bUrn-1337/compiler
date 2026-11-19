%{
/* lexer.l -- scanner for the IR generator.
 *
 * Derived from ../../syntax-analyzer/src/lexer.l (read-only original) with
 * three changes:
 *   1. it no longer builds a token list or a --tokens dump; it only feeds the
 *      parser and reports lexical errors;
 *   2. lexemes are interned in a pool that is freed at exit instead of being
 *      strdup'd and leaked;
 *   3. the typedef-name table ("lexer hack") is now SCOPED.  The original kept
 *      one flat std::set, so a typedef declared inside a function stayed a type
 *      name for the rest of the file.  Scopes are pushed and popped on '{' and
 *      '}' in the scanner itself, which stays exactly in step with scanning and
 *      therefore does not depend on the parser's one-token lookahead.
 */
#include <iostream>
#include <string>
#include <vector>
#include <set>
#include <map>
#include <cstring>
#include "ast.h"
#include "parser.tab.hh"

int line_num = 1;
int col_num  = 1;

int comment_start_line = 1;
int comment_start_col  = 1;
int lit_start_line = 1;
int lit_start_col  = 1;
std::string lit_buf;
bool lit_has_error = false;

extern void report_lex_error(int line, int col,
                             const std::string& lexeme, const std::string& reason);

/* ---------- the scoped "lexer hack" ----------
 * One map per scope: true for a name introduced by a typedef, false for an
 * ordinary name that HIDES a typedef name of the same spelling.  C allows
 *
 *     typedef int Count;
 *     void f(void) { int Count = 1; Count = Count + 1; }
 *
 * and the lexer must stop returning TYPE_NAME for Count inside that block, or
 * the assignment is a syntax error.  The innermost entry wins, so a name is a
 * type name only if the nearest scope that mentions it says so.
 */
static std::vector<std::map<std::string, bool> > typedef_scopes;

/* Parameter names, which are declared BEFORE the brace that opens the scope
 * they belong to; they are flushed into the scope that brace pushes.
 */
static std::vector<std::string> pending_ordinary;

void register_typedef_name(const char* n) {
    if (!n) return;
    if (typedef_scopes.empty()) typedef_scopes.push_back(std::map<std::string, bool>());
    typedef_scopes.back()[std::string(n)] = true;
}
/* An ordinary object or function name: it hides any typedef name it shadows
   for the rest of this scope. */
void register_ordinary_name(const char* n) {
    if (!n) return;
    if (typedef_scopes.empty()) typedef_scopes.push_back(std::map<std::string, bool>());
    typedef_scopes.back()[std::string(n)] = false;
}
void register_param_name(const char* n) {
    if (n) pending_ordinary.push_back(std::string(n));
}
/* A parameter list that belonged to a declaration, not to a definition: the
   names it introduced have no scope of their own and are dropped. */
void clear_param_names(void) { pending_ordinary.clear(); }

static bool is_typedef_name(const char* n) {
    if (!n) return false;
    std::string s(n);
    for (size_t i = typedef_scopes.size(); i-- > 0;) {
        std::map<std::string, bool>::const_iterator it = typedef_scopes[i].find(s);
        if (it != typedef_scopes[i].end()) return it->second;
    }
    return false;
}
void init_typedef_names(void) {
    typedef_scopes.clear();
    pending_ordinary.clear();
    typedef_scopes.push_back(std::map<std::string, bool>());
    /* There is no #include <stdio.h> in this language, so FILE is built in. */
    typedef_scopes.back()["FILE"] = true;
}
static void push_typedef_scope() {
    typedef_scopes.push_back(std::map<std::string, bool>());
    for (size_t i = 0; i < pending_ordinary.size(); ++i)
        typedef_scopes.back()[pending_ordinary[i]] = false;
    pending_ordinary.clear();
}
static void pop_typedef_scope()  { if (typedef_scopes.size() > 1) typedef_scopes.pop_back(); }

std::string last_lexeme;

static void seen(const char* lexeme) { last_lexeme = lexeme; }

#define YY_USER_ACTION                                   \
    yylloc.first_line   = yylloc.last_line = line_num;   \
    yylloc.first_column = col_num;                       \
    yylloc.last_column  = col_num + yyleng - 1;          \
    col_num += yyleng;
%}

%option noyywrap noinput nounput
%x COMMENT
%x STR
%x CHR

DIGIT       [0-9]
LETTER      [a-zA-Z_]
ID          {LETTER}({LETTER}|{DIGIT})*

DECCONST    ([1-9]{DIGIT}*)|"0"
OCTCONST    "0"[0-7]+
HEXCONST    "0"[xX][0-9a-fA-F]+

EXPONENT    [eE][+-]?{DIGIT}+
FSUFFIX     [fF]
FCONST      ({DIGIT}+"."{DIGIT}*{EXPONENT}?|{DIGIT}*"."{DIGIT}+{EXPONENT}?|{DIGIT}+{EXPONENT}){FSUFFIX}?

INVALID_NUM       {DIGIT}+{LETTER}({LETTER}|{DIGIT})*
INVALID_FCONST    {DIGIT}+"."{DIGIT}+{LETTER}({LETTER}|{DIGIT})*
INVALID_OCT       "0"[0-7]*[89][0-9]*
INVALID_HEX       "0"[xX][0-9a-zA-Z]*[g-zG-Z][0-9a-zA-Z]*
INVALID_HEX_EMPTY "0"[xX]

ESCAPE      \\([abfnrtv\\'\"?]|[0-7]{1,3}|x[0-9a-fA-F]+)

%%

"/*"                    { comment_start_line = line_num;
                          comment_start_col  = yylloc.first_column;
                          BEGIN(COMMENT); }
<COMMENT>"*/"           { BEGIN(INITIAL); }
<COMMENT>\n             { line_num++; col_num = 1; }
<COMMENT>.              { /* comment body */ }
<COMMENT><<EOF>>        { report_lex_error(comment_start_line, comment_start_col, "/*",
                                           "Unterminated block comment");
                          BEGIN(INITIAL); yyterminate(); }

"//".*                  { /* single-line comment */ }

[ \t\r]+                { /* whitespace */ }
\n                      { line_num++; col_num = 1; }

"int"       { seen(yytext); return INT; }
"char"      { seen(yytext); return CHAR; }
"float"     { seen(yytext); yylval.str = internLexeme(yytext); return FLOAT; }
"double"    { seen(yytext); yylval.str = internLexeme(yytext); return DOUBLE; }
"void"      { seen(yytext); return VOID; }
"struct"    { seen(yytext); return STRUCT; }
"union"     { seen(yytext); return UNION; }
"enum"      { seen(yytext); return ENUM; }
"typedef"   { seen(yytext); return TYPEDEF; }

"if"        { seen(yytext); return IF; }
"else"      { seen(yytext); return ELSE; }
"for"       { seen(yytext); return FOR; }
"while"     { seen(yytext); return WHILE; }
"do"        { seen(yytext); return DO; }
"until"     { seen(yytext); return UNTIL; }
"switch"    { seen(yytext); return SWITCH; }
"case"      { seen(yytext); return CASE; }
"default"   { seen(yytext); return DEFAULT; }
"break"     { seen(yytext); return BREAK; }
"continue"  { seen(yytext); return CONTINUE; }
"goto"      { seen(yytext); return GOTO; }
"return"    { seen(yytext); return RETURN; }
"sizeof"    { seen(yytext); return SIZEOF; }

"<<="       { seen(yytext); return LEFT_ASSIGN; }
">>="       { seen(yytext); return RIGHT_ASSIGN; }
"=="        { seen(yytext); return EQ_OP; }
"!="        { seen(yytext); return NE_OP; }
"<="        { seen(yytext); return LE_OP; }
">="        { seen(yytext); return GE_OP; }
"&&"        { seen(yytext); return LOG_AND; }
"||"        { seen(yytext); return LOG_OR; }
"++"        { seen(yytext); return INC_OP; }
"--"        { seen(yytext); return DEC_OP; }
"+="        { seen(yytext); return ADD_ASSIGN; }
"-="        { seen(yytext); return SUB_ASSIGN; }
"*="        { seen(yytext); return MUL_ASSIGN; }
"/="        { seen(yytext); return DIV_ASSIGN; }
"%="        { seen(yytext); return MOD_ASSIGN; }
"&="        { seen(yytext); return AND_ASSIGN; }
"|="        { seen(yytext); return OR_ASSIGN; }
"^="        { seen(yytext); return XOR_ASSIGN; }
"<<"        { seen(yytext); return LEFT_OP; }
">>"        { seen(yytext); return RIGHT_OP; }
"->"        { seen(yytext); return ARROW; }

"<"         { seen(yytext); return LT_OP; }
">"         { seen(yytext); return GT_OP; }
"+"         { seen(yytext); return ADD_OP; }
"-"         { seen(yytext); return SUB_OP; }
"*"         { seen(yytext); return MUL_OP; }
"/"         { seen(yytext); return DIV_OP; }
"%"         { seen(yytext); return MOD_OP; }
"="         { seen(yytext); return ASSIGN; }
"!"         { seen(yytext); return LOG_NOT; }
"&"         { seen(yytext); return BIT_AND; }
"|"         { seen(yytext); return BIT_OR; }
"^"         { seen(yytext); return BIT_XOR; }
"~"         { seen(yytext); return BIT_NOT; }
"."         { seen(yytext); return DOT; }

"("         { seen(yytext); return '('; }
")"         { seen(yytext); return ')'; }
"{"         { seen(yytext); push_typedef_scope(); return '{'; }
"}"         { seen(yytext); pop_typedef_scope();  return '}'; }
"["         { seen(yytext); return '['; }
"]"         { seen(yytext); return ']'; }
","         { seen(yytext); return ','; }
";"         { seen(yytext); return ';'; }
":"         { seen(yytext); return ':'; }
"?"         { seen(yytext); return '?'; }

{FCONST}    { seen(yytext); yylval.str = internLexeme(yytext); return FCONST; }
{HEXCONST}  { seen(yytext); yylval.str = internLexeme(yytext); return ICONST; }
{OCTCONST}  { seen(yytext); yylval.str = internLexeme(yytext); return ICONST; }
{DECCONST}  { seen(yytext); yylval.str = internLexeme(yytext); return ICONST; }

{INVALID_FCONST}    { report_lex_error(line_num, yylloc.first_column, yytext,
                                       "Invalid number (malformed float constant)"); }
{INVALID_HEX_EMPTY} { report_lex_error(line_num, yylloc.first_column, yytext,
                                       "Invalid number (hex constant has no digits after 0x)"); }
{INVALID_HEX}       { report_lex_error(line_num, yylloc.first_column, yytext,
                                       "Invalid number (invalid digit in hex constant)"); }
{INVALID_OCT}       { report_lex_error(line_num, yylloc.first_column, yytext,
                                       "Invalid number (invalid digit in octal constant)"); }
{INVALID_NUM}       { report_lex_error(line_num, yylloc.first_column, yytext,
                                       "Invalid identifier (cannot start with a digit)"); }

{ID}        {
                seen(yytext);
                yylval.str = internLexeme(yytext);
                if (is_typedef_name(yytext)) return TYPE_NAME;
                return IDENTIFIER;
            }

\"                      { lit_buf = "\""; lit_start_line = line_num;
                          lit_start_col = yylloc.first_column;
                          lit_has_error = false; BEGIN(STR); }
<STR>[^\"\\\n]+        { lit_buf += yytext; }
<STR>{ESCAPE}           { lit_buf += yytext; }
<STR>\\.                { report_lex_error(line_num, yylloc.first_column, yytext,
                                           "Invalid escape sequence in string literal");
                          lit_buf += yytext; lit_has_error = true; }
<STR>\\                 { lit_buf += yytext; }
<STR>\"                 { lit_buf += "\"";
                          BEGIN(INITIAL);
                          if (!lit_has_error) {
                              yylloc.first_line   = lit_start_line;
                              yylloc.first_column = lit_start_col;
                              seen(lit_buf.c_str());
                              yylval.str = internLexeme(lit_buf.c_str());
                              return SCONST;
                          }
                        }
<STR>\n                 { report_lex_error(lit_start_line, lit_start_col, lit_buf,
                                           "Unterminated string literal");
                          line_num++; col_num = 1; BEGIN(INITIAL); }
<STR><<EOF>>            { report_lex_error(lit_start_line, lit_start_col, lit_buf,
                                           "Unterminated string literal");
                          BEGIN(INITIAL); yyterminate(); }

\'                      { lit_buf = "'"; lit_start_line = line_num;
                          lit_start_col = yylloc.first_column;
                          lit_has_error = false; BEGIN(CHR); }
<CHR>[^\'\\\n]+        { lit_buf += yytext; }
<CHR>{ESCAPE}           { lit_buf += yytext; }
<CHR>\\.                { report_lex_error(line_num, yylloc.first_column, yytext,
                                           "Invalid escape sequence in character literal");
                          lit_buf += yytext; lit_has_error = true; }
<CHR>\\                 { lit_buf += yytext; }
<CHR>\'                 { lit_buf += "'";
                          BEGIN(INITIAL);
                          if (!lit_has_error) {
                              yylloc.first_line   = lit_start_line;
                              yylloc.first_column = lit_start_col;
                              seen(lit_buf.c_str());
                              yylval.str = internLexeme(lit_buf.c_str());
                              return CCONST;
                          }
                        }
<CHR>\n                 { report_lex_error(lit_start_line, lit_start_col, lit_buf,
                                           "Unterminated character literal");
                          line_num++; col_num = 1; BEGIN(INITIAL); }
<CHR><<EOF>>            { report_lex_error(lit_start_line, lit_start_col, lit_buf,
                                           "Unterminated character literal");
                          BEGIN(INITIAL); yyterminate(); }

.           { report_lex_error(line_num, yylloc.first_column, yytext,
                               "Unrecognized character"); }

%%
