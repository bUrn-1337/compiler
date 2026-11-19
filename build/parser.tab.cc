/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison implementation for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output, and Bison version.  */
#define YYBISON 30802

/* Bison version string.  */
#define YYBISON_VERSION "3.8.2"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* First part of user prologue.  */
#line 1 "src/parser.y"

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

#line 196 "build/parser.tab.cc"

# ifndef YY_CAST
#  ifdef __cplusplus
#   define YY_CAST(Type, Val) static_cast<Type> (Val)
#   define YY_REINTERPRET_CAST(Type, Val) reinterpret_cast<Type> (Val)
#  else
#   define YY_CAST(Type, Val) ((Type) (Val))
#   define YY_REINTERPRET_CAST(Type, Val) ((Type) (Val))
#  endif
# endif
# ifndef YY_NULLPTR
#  if defined __cplusplus
#   if 201103L <= __cplusplus
#    define YY_NULLPTR nullptr
#   else
#    define YY_NULLPTR 0
#   endif
#  else
#   define YY_NULLPTR ((void*)0)
#  endif
# endif

#include "parser.tab.hh"
/* Symbol kind.  */
enum yysymbol_kind_t
{
  YYSYMBOL_YYEMPTY = -2,
  YYSYMBOL_YYEOF = 0,                      /* "end of file"  */
  YYSYMBOL_YYerror = 1,                    /* error  */
  YYSYMBOL_YYUNDEF = 2,                    /* "invalid token"  */
  YYSYMBOL_IDENTIFIER = 3,                 /* IDENTIFIER  */
  YYSYMBOL_TYPE_NAME = 4,                  /* TYPE_NAME  */
  YYSYMBOL_ICONST = 5,                     /* ICONST  */
  YYSYMBOL_FCONST = 6,                     /* FCONST  */
  YYSYMBOL_CCONST = 7,                     /* CCONST  */
  YYSYMBOL_SCONST = 8,                     /* SCONST  */
  YYSYMBOL_FLOAT = 9,                      /* FLOAT  */
  YYSYMBOL_DOUBLE = 10,                    /* DOUBLE  */
  YYSYMBOL_INT = 11,                       /* INT  */
  YYSYMBOL_CHAR = 12,                      /* CHAR  */
  YYSYMBOL_VOID = 13,                      /* VOID  */
  YYSYMBOL_STRUCT = 14,                    /* STRUCT  */
  YYSYMBOL_UNION = 15,                     /* UNION  */
  YYSYMBOL_ENUM = 16,                      /* ENUM  */
  YYSYMBOL_TYPEDEF = 17,                   /* TYPEDEF  */
  YYSYMBOL_IF = 18,                        /* IF  */
  YYSYMBOL_ELSE = 19,                      /* ELSE  */
  YYSYMBOL_FOR = 20,                       /* FOR  */
  YYSYMBOL_WHILE = 21,                     /* WHILE  */
  YYSYMBOL_DO = 22,                        /* DO  */
  YYSYMBOL_UNTIL = 23,                     /* UNTIL  */
  YYSYMBOL_SWITCH = 24,                    /* SWITCH  */
  YYSYMBOL_CASE = 25,                      /* CASE  */
  YYSYMBOL_DEFAULT = 26,                   /* DEFAULT  */
  YYSYMBOL_BREAK = 27,                     /* BREAK  */
  YYSYMBOL_CONTINUE = 28,                  /* CONTINUE  */
  YYSYMBOL_GOTO = 29,                      /* GOTO  */
  YYSYMBOL_RETURN = 30,                    /* RETURN  */
  YYSYMBOL_SIZEOF = 31,                    /* SIZEOF  */
  YYSYMBOL_ADD_OP = 32,                    /* ADD_OP  */
  YYSYMBOL_SUB_OP = 33,                    /* SUB_OP  */
  YYSYMBOL_MUL_OP = 34,                    /* MUL_OP  */
  YYSYMBOL_DIV_OP = 35,                    /* DIV_OP  */
  YYSYMBOL_MOD_OP = 36,                    /* MOD_OP  */
  YYSYMBOL_EQ_OP = 37,                     /* EQ_OP  */
  YYSYMBOL_NE_OP = 38,                     /* NE_OP  */
  YYSYMBOL_LT_OP = 39,                     /* LT_OP  */
  YYSYMBOL_GT_OP = 40,                     /* GT_OP  */
  YYSYMBOL_LE_OP = 41,                     /* LE_OP  */
  YYSYMBOL_GE_OP = 42,                     /* GE_OP  */
  YYSYMBOL_LOG_AND = 43,                   /* LOG_AND  */
  YYSYMBOL_LOG_OR = 44,                    /* LOG_OR  */
  YYSYMBOL_LOG_NOT = 45,                   /* LOG_NOT  */
  YYSYMBOL_BIT_AND = 46,                   /* BIT_AND  */
  YYSYMBOL_BIT_OR = 47,                    /* BIT_OR  */
  YYSYMBOL_BIT_XOR = 48,                   /* BIT_XOR  */
  YYSYMBOL_BIT_NOT = 49,                   /* BIT_NOT  */
  YYSYMBOL_LEFT_OP = 50,                   /* LEFT_OP  */
  YYSYMBOL_RIGHT_OP = 51,                  /* RIGHT_OP  */
  YYSYMBOL_INC_OP = 52,                    /* INC_OP  */
  YYSYMBOL_DEC_OP = 53,                    /* DEC_OP  */
  YYSYMBOL_ARROW = 54,                     /* ARROW  */
  YYSYMBOL_DOT = 55,                       /* DOT  */
  YYSYMBOL_ASSIGN = 56,                    /* ASSIGN  */
  YYSYMBOL_ADD_ASSIGN = 57,                /* ADD_ASSIGN  */
  YYSYMBOL_SUB_ASSIGN = 58,                /* SUB_ASSIGN  */
  YYSYMBOL_MUL_ASSIGN = 59,                /* MUL_ASSIGN  */
  YYSYMBOL_DIV_ASSIGN = 60,                /* DIV_ASSIGN  */
  YYSYMBOL_MOD_ASSIGN = 61,                /* MOD_ASSIGN  */
  YYSYMBOL_AND_ASSIGN = 62,                /* AND_ASSIGN  */
  YYSYMBOL_OR_ASSIGN = 63,                 /* OR_ASSIGN  */
  YYSYMBOL_XOR_ASSIGN = 64,                /* XOR_ASSIGN  */
  YYSYMBOL_LEFT_ASSIGN = 65,               /* LEFT_ASSIGN  */
  YYSYMBOL_RIGHT_ASSIGN = 66,              /* RIGHT_ASSIGN  */
  YYSYMBOL_LOWER_THAN_ELSE = 67,           /* LOWER_THAN_ELSE  */
  YYSYMBOL_68_ = 68,                       /* ';'  */
  YYSYMBOL_69_ = 69,                       /* '}'  */
  YYSYMBOL_70_ = 70,                       /* ','  */
  YYSYMBOL_71_ = 71,                       /* '['  */
  YYSYMBOL_72_ = 72,                       /* ']'  */
  YYSYMBOL_73_ = 73,                       /* '{'  */
  YYSYMBOL_74_ = 74,                       /* '('  */
  YYSYMBOL_75_ = 75,                       /* ')'  */
  YYSYMBOL_76_ = 76,                       /* ':'  */
  YYSYMBOL_77_ = 77,                       /* '?'  */
  YYSYMBOL_YYACCEPT = 78,                  /* $accept  */
  YYSYMBOL_Program = 79,                   /* Program  */
  YYSYMBOL_TranslationUnit = 80,           /* TranslationUnit  */
  YYSYMBOL_ExternalDecl = 81,              /* ExternalDecl  */
  YYSYMBOL_Decl = 82,                      /* Decl  */
  YYSYMBOL_PlainInitDeclList = 83,         /* PlainInitDeclList  */
  YYSYMBOL_PlainInitDecl = 84,             /* PlainInitDecl  */
  YYSYMBOL_PlainDeclarator = 85,           /* PlainDeclarator  */
  YYSYMBOL_DeclSpec = 86,                  /* DeclSpec  */
  YYSYMBOL_TypeSpec = 87,                  /* TypeSpec  */
  YYSYMBOL_StructUnionSpec = 88,           /* StructUnionSpec  */
  YYSYMBOL_TagName = 89,                   /* TagName  */
  YYSYMBOL_StructOrUnion = 90,             /* StructOrUnion  */
  YYSYMBOL_StructDeclList = 91,            /* StructDeclList  */
  YYSYMBOL_EnumSpec = 92,                  /* EnumSpec  */
  YYSYMBOL_EnumList = 93,                  /* EnumList  */
  YYSYMBOL_Enumerator = 94,                /* Enumerator  */
  YYSYMBOL_InitDeclaratorList = 95,        /* InitDeclaratorList  */
  YYSYMBOL_InitDeclarator = 96,            /* InitDeclarator  */
  YYSYMBOL_Declarator = 97,                /* Declarator  */
  YYSYMBOL_AbstractDeclarator = 98,        /* AbstractDeclarator  */
  YYSYMBOL_DirectDeclarator = 99,          /* DirectDeclarator  */
  YYSYMBOL_NonEmptyDirect = 100,           /* NonEmptyDirect  */
  YYSYMBOL_ParenContent = 101,             /* ParenContent  */
  YYSYMBOL_GroupedDeclarator = 102,        /* GroupedDeclarator  */
  YYSYMBOL_GroupDirect = 103,              /* GroupDirect  */
  YYSYMBOL_GroupDirectOpt = 104,           /* GroupDirectOpt  */
  YYSYMBOL_Pointers = 105,                 /* Pointers  */
  YYSYMBOL_PtrStars = 106,                 /* PtrStars  */
  YYSYMBOL_Initializer = 107,              /* Initializer  */
  YYSYMBOL_InitializerList = 108,          /* InitializerList  */
  YYSYMBOL_FuncDef = 109,                  /* FuncDef  */
  YYSYMBOL_ParamList = 110,                /* ParamList  */
  YYSYMBOL_ParamDeclList = 111,            /* ParamDeclList  */
  YYSYMBOL_ParamDecl = 112,                /* ParamDecl  */
  YYSYMBOL_CompoundStmt = 113,             /* CompoundStmt  */
  YYSYMBOL_BlockItemList = 114,            /* BlockItemList  */
  YYSYMBOL_BlockItem = 115,                /* BlockItem  */
  YYSYMBOL_Stmt = 116,                     /* Stmt  */
  YYSYMBOL_ExprStmt = 117,                 /* ExprStmt  */
  YYSYMBOL_SelectionStmt = 118,            /* SelectionStmt  */
  YYSYMBOL_IterStmt = 119,                 /* IterStmt  */
  YYSYMBOL_ForInit = 120,                  /* ForInit  */
  YYSYMBOL_LabeledStmt = 121,              /* LabeledStmt  */
  YYSYMBOL_JumpStmt = 122,                 /* JumpStmt  */
  YYSYMBOL_Expr = 123,                     /* Expr  */
  YYSYMBOL_AssignExpr = 124,               /* AssignExpr  */
  YYSYMBOL_AssignOp = 125,                 /* AssignOp  */
  YYSYMBOL_CondExpr = 126,                 /* CondExpr  */
  YYSYMBOL_LogOrExpr = 127,                /* LogOrExpr  */
  YYSYMBOL_LogAndExpr = 128,               /* LogAndExpr  */
  YYSYMBOL_BitOrExpr = 129,                /* BitOrExpr  */
  YYSYMBOL_BitXorExpr = 130,               /* BitXorExpr  */
  YYSYMBOL_BitAndExpr = 131,               /* BitAndExpr  */
  YYSYMBOL_EqExpr = 132,                   /* EqExpr  */
  YYSYMBOL_RelExpr = 133,                  /* RelExpr  */
  YYSYMBOL_ShiftExpr = 134,                /* ShiftExpr  */
  YYSYMBOL_AddExpr = 135,                  /* AddExpr  */
  YYSYMBOL_MulExpr = 136,                  /* MulExpr  */
  YYSYMBOL_CastExpr = 137,                 /* CastExpr  */
  YYSYMBOL_UnaryExpr = 138,                /* UnaryExpr  */
  YYSYMBOL_PostfixExpr = 139,              /* PostfixExpr  */
  YYSYMBOL_PrimaryExpr = 140,              /* PrimaryExpr  */
  YYSYMBOL_ArgList = 141,                  /* ArgList  */
  YYSYMBOL_TypeName = 142                  /* TypeName  */
};
typedef enum yysymbol_kind_t yysymbol_kind_t;




#ifdef short
# undef short
#endif

/* On compilers that do not define __PTRDIFF_MAX__ etc., make sure
   <limits.h> and (if available) <stdint.h> are included
   so that the code can choose integer types of a good width.  */

#ifndef __PTRDIFF_MAX__
# include <limits.h> /* INFRINGES ON USER NAME SPACE */
# if defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stdint.h> /* INFRINGES ON USER NAME SPACE */
#  define YY_STDINT_H
# endif
#endif

/* Narrow types that promote to a signed type and that can represent a
   signed or unsigned integer of at least N bits.  In tables they can
   save space and decrease cache pressure.  Promoting to a signed type
   helps avoid bugs in integer arithmetic.  */

#ifdef __INT_LEAST8_MAX__
typedef __INT_LEAST8_TYPE__ yytype_int8;
#elif defined YY_STDINT_H
typedef int_least8_t yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef __INT_LEAST16_MAX__
typedef __INT_LEAST16_TYPE__ yytype_int16;
#elif defined YY_STDINT_H
typedef int_least16_t yytype_int16;
#else
typedef short yytype_int16;
#endif

/* Work around bug in HP-UX 11.23, which defines these macros
   incorrectly for preprocessor constants.  This workaround can likely
   be removed in 2023, as HPE has promised support for HP-UX 11.23
   (aka HP-UX 11i v2) only through the end of 2022; see Table 2 of
   <https://h20195.www2.hpe.com/V2/getpdf.aspx/4AA4-7673ENW.pdf>.  */
#ifdef __hpux
# undef UINT_LEAST8_MAX
# undef UINT_LEAST16_MAX
# define UINT_LEAST8_MAX 255
# define UINT_LEAST16_MAX 65535
#endif

#if defined __UINT_LEAST8_MAX__ && __UINT_LEAST8_MAX__ <= __INT_MAX__
typedef __UINT_LEAST8_TYPE__ yytype_uint8;
#elif (!defined __UINT_LEAST8_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST8_MAX <= INT_MAX)
typedef uint_least8_t yytype_uint8;
#elif !defined __UINT_LEAST8_MAX__ && UCHAR_MAX <= INT_MAX
typedef unsigned char yytype_uint8;
#else
typedef short yytype_uint8;
#endif

#if defined __UINT_LEAST16_MAX__ && __UINT_LEAST16_MAX__ <= __INT_MAX__
typedef __UINT_LEAST16_TYPE__ yytype_uint16;
#elif (!defined __UINT_LEAST16_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST16_MAX <= INT_MAX)
typedef uint_least16_t yytype_uint16;
#elif !defined __UINT_LEAST16_MAX__ && USHRT_MAX <= INT_MAX
typedef unsigned short yytype_uint16;
#else
typedef int yytype_uint16;
#endif

#ifndef YYPTRDIFF_T
# if defined __PTRDIFF_TYPE__ && defined __PTRDIFF_MAX__
#  define YYPTRDIFF_T __PTRDIFF_TYPE__
#  define YYPTRDIFF_MAXIMUM __PTRDIFF_MAX__
# elif defined PTRDIFF_MAX
#  ifndef ptrdiff_t
#   include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  endif
#  define YYPTRDIFF_T ptrdiff_t
#  define YYPTRDIFF_MAXIMUM PTRDIFF_MAX
# else
#  define YYPTRDIFF_T long
#  define YYPTRDIFF_MAXIMUM LONG_MAX
# endif
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned
# endif
#endif

#define YYSIZE_MAXIMUM                                  \
  YY_CAST (YYPTRDIFF_T,                                 \
           (YYPTRDIFF_MAXIMUM < YY_CAST (YYSIZE_T, -1)  \
            ? YYPTRDIFF_MAXIMUM                         \
            : YY_CAST (YYSIZE_T, -1)))

#define YYSIZEOF(X) YY_CAST (YYPTRDIFF_T, sizeof (X))


/* Stored state numbers (used for stacks). */
typedef yytype_int16 yy_state_t;

/* State numbers in computations.  */
typedef int yy_state_fast_t;

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif


#ifndef YY_ATTRIBUTE_PURE
# if defined __GNUC__ && 2 < __GNUC__ + (96 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_PURE __attribute__ ((__pure__))
# else
#  define YY_ATTRIBUTE_PURE
# endif
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# if defined __GNUC__ && 2 < __GNUC__ + (7 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_UNUSED __attribute__ ((__unused__))
# else
#  define YY_ATTRIBUTE_UNUSED
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YY_USE(E) ((void) (E))
#else
# define YY_USE(E) /* empty */
#endif

/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
#if defined __GNUC__ && ! defined __ICC && 406 <= __GNUC__ * 100 + __GNUC_MINOR__
# if __GNUC__ * 100 + __GNUC_MINOR__ < 407
#  define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                           \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")
# else
#  define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                           \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")              \
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# endif
# define YY_IGNORE_MAYBE_UNINITIALIZED_END      \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif

#if defined __cplusplus && defined __GNUC__ && ! defined __ICC && 6 <= __GNUC__
# define YY_IGNORE_USELESS_CAST_BEGIN                          \
    _Pragma ("GCC diagnostic push")                            \
    _Pragma ("GCC diagnostic ignored \"-Wuseless-cast\"")
# define YY_IGNORE_USELESS_CAST_END            \
    _Pragma ("GCC diagnostic pop")
#endif
#ifndef YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_END
#endif


#define YY_ASSERT(E) ((void) (0 && (E)))

#if 1

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* 1 */

#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL \
             && defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yy_state_t yyss_alloc;
  YYSTYPE yyvs_alloc;
  YYLTYPE yyls_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (YYSIZEOF (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (YYSIZEOF (yy_state_t) + YYSIZEOF (YYSTYPE) \
             + YYSIZEOF (YYLTYPE)) \
      + 2 * YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYPTRDIFF_T yynewbytes;                                         \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * YYSIZEOF (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / YYSIZEOF (*yyptr);                        \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, YY_CAST (YYSIZE_T, (Count)) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYPTRDIFF_T yyi;                      \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  35
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   1237

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  78
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  65
/* YYNRULES -- Number of rules.  */
#define YYNRULES  216
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  378

/* YYMAXUTOK -- Last valid token kind.  */
#define YYMAXUTOK   322


/* YYTRANSLATE(TOKEN-NUM) -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, with out-of-bounds checking.  */
#define YYTRANSLATE(YYX)                                \
  (0 <= (YYX) && (YYX) <= YYMAXUTOK                     \
   ? YY_CAST (yysymbol_kind_t, yytranslate[YYX])        \
   : YYSYMBOL_YYUNDEF)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex.  */
static const yytype_int8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
      74,    75,     2,     2,    70,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,    76,    68,
       2,     2,     2,    77,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,    71,     2,    72,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    73,     2,    69,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45,    46,    47,    48,    49,    50,    51,    52,    53,    54,
      55,    56,    57,    58,    59,    60,    61,    62,    63,    64,
      65,    66,    67
};

#if YYDEBUG
/* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_int16 yyrline[] =
{
       0,   184,   184,   185,   189,   191,   196,   197,   204,   207,
     208,   214,   218,   225,   231,   233,   237,   238,   242,   244,
     245,   255,   257,   263,   264,   265,   267,   269,   270,   272,
     273,   277,   280,   283,   293,   294,   298,   299,   303,   305,
     309,   312,   315,   320,   322,   326,   329,   334,   336,   340,
     342,   358,   366,   373,   375,   379,   387,   389,   390,   391,
     396,   419,   420,   430,   432,   440,   442,   443,   444,   445,
     449,   451,   455,   456,   465,   466,   470,   471,   472,   473,
     477,   479,   485,   494,   495,   499,   501,   511,   520,   521,
     522,   526,   528,   532,   533,   534,   538,   539,   540,   541,
     542,   543,   547,   549,   553,   555,   557,   559,   560,   561,
     562,   563,   564,   569,   571,   573,   575,   579,   583,   584,
     585,   586,   587,   588,   589,   590,   594,   595,   599,   604,
     606,   607,   608,   612,   613,   614,   615,   616,   618,   624,
     625,   629,   633,   638,   639,   640,   641,   642,   643,   644,
     645,   646,   647,   648,   652,   653,   658,   659,   664,   665,
     670,   671,   676,   677,   682,   683,   688,   689,   691,   696,
     697,   699,   701,   703,   708,   709,   711,   716,   717,   719,
     724,   725,   727,   729,   734,   735,   739,   740,   741,   742,
     743,   744,   745,   746,   747,   748,   749,   753,   754,   755,
     756,   757,   758,   760,   766,   768,   770,   771,   775,   776,
     778,   779,   785,   791,   795,   797,   808
};
#endif

/** Accessing symbol of state STATE.  */
#define YY_ACCESSING_SYMBOL(State) YY_CAST (yysymbol_kind_t, yystos[State])

#if 1
/* The user-facing name of the symbol whose (internal) number is
   YYSYMBOL.  No bounds checking.  */
static const char *yysymbol_name (yysymbol_kind_t yysymbol) YY_ATTRIBUTE_UNUSED;

static const char *
yysymbol_name (yysymbol_kind_t yysymbol)
{
  static const char *const yy_sname[] =
  {
  "end of file", "error", "invalid token", "IDENTIFIER", "TYPE_NAME",
  "ICONST", "FCONST", "CCONST", "SCONST", "FLOAT", "DOUBLE", "INT", "CHAR",
  "VOID", "STRUCT", "UNION", "ENUM", "TYPEDEF", "IF", "ELSE", "FOR",
  "WHILE", "DO", "UNTIL", "SWITCH", "CASE", "DEFAULT", "BREAK", "CONTINUE",
  "GOTO", "RETURN", "SIZEOF", "ADD_OP", "SUB_OP", "MUL_OP", "DIV_OP",
  "MOD_OP", "EQ_OP", "NE_OP", "LT_OP", "GT_OP", "LE_OP", "GE_OP",
  "LOG_AND", "LOG_OR", "LOG_NOT", "BIT_AND", "BIT_OR", "BIT_XOR",
  "BIT_NOT", "LEFT_OP", "RIGHT_OP", "INC_OP", "DEC_OP", "ARROW", "DOT",
  "ASSIGN", "ADD_ASSIGN", "SUB_ASSIGN", "MUL_ASSIGN", "DIV_ASSIGN",
  "MOD_ASSIGN", "AND_ASSIGN", "OR_ASSIGN", "XOR_ASSIGN", "LEFT_ASSIGN",
  "RIGHT_ASSIGN", "LOWER_THAN_ELSE", "';'", "'}'", "','", "'['", "']'",
  "'{'", "'('", "')'", "':'", "'?'", "$accept", "Program",
  "TranslationUnit", "ExternalDecl", "Decl", "PlainInitDeclList",
  "PlainInitDecl", "PlainDeclarator", "DeclSpec", "TypeSpec",
  "StructUnionSpec", "TagName", "StructOrUnion", "StructDeclList",
  "EnumSpec", "EnumList", "Enumerator", "InitDeclaratorList",
  "InitDeclarator", "Declarator", "AbstractDeclarator", "DirectDeclarator",
  "NonEmptyDirect", "ParenContent", "GroupedDeclarator", "GroupDirect",
  "GroupDirectOpt", "Pointers", "PtrStars", "Initializer",
  "InitializerList", "FuncDef", "ParamList", "ParamDeclList", "ParamDecl",
  "CompoundStmt", "BlockItemList", "BlockItem", "Stmt", "ExprStmt",
  "SelectionStmt", "IterStmt", "ForInit", "LabeledStmt", "JumpStmt",
  "Expr", "AssignExpr", "AssignOp", "CondExpr", "LogOrExpr", "LogAndExpr",
  "BitOrExpr", "BitXorExpr", "BitAndExpr", "EqExpr", "RelExpr",
  "ShiftExpr", "AddExpr", "MulExpr", "CastExpr", "UnaryExpr",
  "PostfixExpr", "PrimaryExpr", "ArgList", "TypeName", YY_NULLPTR
  };
  return yy_sname[yysymbol];
}
#endif

#define YYPACT_NINF (-211)

#define yypact_value_is_default(Yyn) \
  ((Yyn) == YYPACT_NINF)

#define YYTABLE_NINF (-84)

#define yytable_value_is_error(Yyn) \
  0

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
static const yytype_int16 yypact[] =
{
     363,   -47,    38,  -211,  -211,  -211,  -211,  -211,  -211,  -211,
    -211,    33,   563,    18,   437,  -211,  -211,   -10,  -211,  -211,
      36,  -211,  -211,  -211,  -211,  -211,    77,    67,  -211,     6,
    -211,  -211,    99,    50,  -211,  -211,  -211,  -211,  -211,    90,
    -211,   -14,    16,   111,   490,    84,   184,  -211,   184,   915,
     924,     7,   -24,  -211,    99,  -211,    77,   915,   316,  -211,
    -211,  -211,    40,     8,     4,  -211,   184,  -211,   -10,   165,
     490,    93,  -211,  -211,  -211,  -211,  -211,  -211,  1099,  1154,
    1154,  1154,  1154,  1154,  1154,  1163,  1163,   832,   800,  -211,
    -211,   426,   -12,    24,   144,   149,   155,   114,   131,   153,
     175,    60,  -211,  -211,    29,  -211,  -211,   127,  1154,  -211,
      99,   143,  -211,   160,  -211,   146,     9,   129,   135,   151,
     156,   749,   166,   167,   517,   142,   164,   191,   218,   975,
    -211,  -211,  -211,  -211,   390,  -211,  -211,  -211,  -211,  -211,
    -211,  -211,    96,  -211,  -211,    40,    77,   148,  -211,    76,
     172,    13,  -211,   196,  -211,  1007,   530,  -211,  -211,   288,
    -211,   800,  -211,  -211,  -211,  -211,  -211,  -211,  -211,  1154,
    -211,  -211,  -211,  -211,   158,    77,    -4,   186,  -211,  -211,
    -211,  -211,  -211,  -211,  -211,  -211,  -211,  -211,  -211,  1154,
    1154,  1154,  1154,  1154,  1154,  1154,  1154,  1154,  1154,  1154,
    1154,  1154,  1154,  1154,  1154,  1154,  1154,  1154,  1154,  -211,
    -211,   233,   235,  1154,   241,  -211,  -211,  -211,  -211,  -211,
    -211,   749,   749,   551,   464,   587,   192,   129,   250,   621,
     657,   200,   201,   749,  -211,  -211,   210,   211,  -211,   120,
     213,  -211,  -211,  -211,  1154,   208,  -211,    16,  -211,   530,
    1039,     8,   214,   530,  -211,   212,   220,  -211,   221,  -211,
     864,  -211,  -211,  1154,  -211,    24,    -6,   144,   149,   155,
     114,   131,   131,   153,   153,   153,   153,   175,   175,    60,
      60,  -211,  -211,  -211,  -211,  -211,  -211,  -211,   124,   231,
    -211,  -211,    22,  -211,  -211,    44,    23,   125,   184,  -211,
    -211,  1090,    45,    55,   215,    53,    61,    54,    64,   749,
     749,  -211,  -211,  -211,  -211,  -211,  -211,     8,   232,  -211,
     236,  -211,  -211,  -211,  -211,  -211,  -211,  -211,  1154,  -211,
    -211,  1154,  -211,  -211,   749,  -211,   749,   749,  -211,   691,
    -211,   749,  -211,   749,  1154,  -211,   749,  -211,   749,  -211,
     749,  -211,   749,  -211,  -211,  -211,  -211,  -211,  -211,  -211,
     266,  -211,   749,    68,  -211,  -211,    71,  -211,  -211,  -211,
    -211,   749,  -211,   749,   242,  -211,  -211,  -211
};

/* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
   Performed when YYTABLE does not specify something else to do.  Zero
   means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       0,     0,     0,    28,    25,    26,    23,    24,    27,    36,
      37,     0,     0,     0,     0,     4,     7,    72,    21,    29,
       0,    30,     6,     9,    10,    18,    72,     0,    14,    16,
      34,    35,     0,    42,    22,     1,     5,    74,    12,     0,
      47,    49,    53,    73,     0,    33,     0,    13,     0,     0,
       0,    45,     0,    43,     0,    11,    72,     0,     0,    82,
      55,    56,    70,     0,    51,    75,     0,    38,    72,     0,
       0,     0,    15,   208,   209,   210,   211,   212,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,    17,
      76,   141,   154,   156,   158,   160,   162,   164,   166,   169,
     174,   177,   180,   184,   186,   197,    19,     0,     0,    41,
       0,     0,    48,    49,    50,     0,   208,    28,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
     102,    88,    93,    96,     0,    91,    94,    97,    98,    99,
     101,   100,     0,   139,    65,    70,    72,     0,    61,    64,
       0,    53,    62,    84,    85,     0,    83,    32,    39,     0,
       8,     0,   195,   189,   190,   194,   191,   193,   192,     0,
     187,   188,    77,    80,     0,    72,     0,     0,   143,   144,
     145,   146,   147,   148,   149,   150,   151,   152,   153,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,   206,
     207,     0,     0,     0,     0,    20,    46,    44,    40,    95,
      90,     0,     0,     0,     0,     0,   208,     0,     0,     0,
       0,     0,     0,     0,   136,   135,     0,     0,   137,     0,
       0,    89,    92,   103,     0,     0,    87,    53,    57,    83,
       0,    63,    54,     0,    58,     0,     0,    31,     0,    78,
       0,   216,   213,     0,   142,   157,     0,   159,   161,   163,
     165,   167,   168,   170,   171,   172,   173,   175,   176,   178,
     179,   181,   182,   183,   203,   205,   202,   204,     0,     0,
     199,   214,     0,   128,   129,     0,     0,     0,   208,   127,
     126,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,   131,   133,   134,   138,   140,    66,    52,     0,    67,
       0,    86,    59,    60,   196,    79,    81,   185,     0,   198,
     201,     0,   200,   109,     0,   111,     0,     0,   125,     0,
     121,     0,   123,     0,     0,   122,     0,   124,     0,   110,
       0,   112,     0,   132,   130,    69,    68,   155,   215,   107,
     104,   120,     0,     0,   118,   113,     0,   119,   115,   108,
     106,     0,   116,     0,     0,   105,   117,   114
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -211,  -211,  -211,   295,   -35,   265,   264,  -211,    11,    -2,
    -211,   293,  -211,   244,  -211,   281,   243,  -211,   262,   334,
     177,  -146,   312,   225,  -211,  -211,  -211,   -13,   -56,   -54,
    -211,  -211,  -141,  -211,   102,   -40,  -211,   222,  -117,  -210,
    -211,  -211,  -211,  -211,  -211,   -81,   -49,  -211,   -48,  -211,
     168,   179,   188,   189,   187,    56,   -15,    48,    65,   -53,
     -17,  -211,  -211,  -211,   198
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
       0,    13,    14,    15,    16,    27,    28,    29,    68,    18,
      19,    33,    20,    69,    21,    52,    53,    39,    40,   113,
     246,    63,   252,   147,   148,   149,   150,    42,    43,    89,
     174,    22,   152,   153,   154,   133,   134,   135,   136,   137,
     138,   139,   301,   140,   141,   142,   143,   189,    91,    92,
      93,    94,    95,    96,    97,    98,    99,   100,   101,   102,
     103,   104,   105,   292,   177
};

/* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule whose
   number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int16 yytable[] =
{
      90,    59,   107,   114,   228,   251,   151,   176,    90,    67,
      34,    17,    25,    46,   300,   256,    60,    61,    35,    60,
      61,    23,    24,   132,    37,    17,   163,   164,   165,   166,
     167,   168,   190,   173,   158,    67,    30,    31,    90,    30,
      31,    25,    57,   144,     3,   109,   110,    65,   239,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    38,    58,
     216,   162,    49,   108,   244,   191,   244,   192,   170,   171,
     328,   262,    26,   146,    37,   -54,   232,    50,   156,   155,
     176,   209,   210,   211,   212,   221,   175,    62,   176,   151,
      62,   339,   331,   244,   206,   207,   208,   332,   336,   132,
     213,   317,    51,   214,   293,   294,    32,   255,   318,    44,
     266,    37,   333,   340,   145,   -83,   311,    58,    58,   334,
     341,   345,   349,    54,   158,   244,    58,    58,   346,   350,
     343,   244,   288,   247,   244,    47,   348,    48,   244,   352,
     264,   244,   296,   373,   303,    65,   374,   -71,   306,   308,
     249,   196,   197,   281,   282,   283,   146,    70,    55,   175,
      56,   160,   247,    48,   243,   291,   244,   146,    66,     3,
     198,   199,   200,   201,     4,     5,     6,     7,     8,     9,
      10,    11,    12,   273,   274,   275,   276,    25,   314,   299,
     244,   193,   353,   354,   244,   315,   329,   194,    58,   215,
     337,   195,   320,   202,   203,   222,   326,   204,   205,   223,
     327,    90,   218,   110,   219,   220,    57,   359,   233,   360,
     361,   236,   237,   248,   364,   224,   365,   259,   260,   367,
     225,   368,   234,   369,   157,   370,   284,   285,   286,   287,
     229,   230,   289,   250,    73,   372,    74,    75,    76,    77,
     277,   278,   271,   272,   375,   335,   376,   338,   363,   235,
     146,   263,   342,   366,   146,   347,   253,   351,   221,   279,
     280,   304,    78,    79,    80,    81,   309,   310,   312,   313,
     357,   219,   358,   316,   322,   371,    82,    83,   156,   344,
      84,    66,     3,    85,    86,   323,   324,     4,     5,     6,
       7,     8,     9,    10,    11,    12,   330,   355,   356,    36,
     377,    71,    72,    45,   159,    88,   290,   115,   112,   116,
     117,    74,    75,    76,    77,     4,     5,     6,     7,     8,
       9,    10,    11,    12,   118,   111,   119,   120,   121,   122,
     123,   124,   125,   126,   127,   128,   129,    78,    79,    80,
      81,    41,   261,   217,    64,   321,   242,   257,   265,   258,
       0,    82,    83,    -3,     1,    84,     2,     3,    85,    86,
     245,   267,     4,     5,     6,     7,     8,     9,    10,    11,
      12,   268,   270,   269,   130,   131,     0,     0,     0,    58,
      88,   240,     0,   116,   117,    74,    75,    76,    77,     4,
       5,     6,     7,     8,     9,    10,    11,    12,   118,     0,
     119,   120,   121,   122,   123,   124,   125,   126,   127,   128,
     129,    78,    79,    80,    81,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,    82,    83,    -2,     1,    84,
       2,     3,    85,    86,     0,     0,     4,     5,     6,     7,
       8,     9,    10,    11,    12,     0,     0,     0,   130,   241,
       0,     0,     0,    58,    88,   297,     0,   298,     3,    74,
      75,    76,    77,     4,     5,     6,     7,     8,     9,    10,
      11,    12,   178,   179,   180,   181,   182,   183,   184,   185,
     186,   187,   188,    66,     3,    78,    79,    80,    81,     4,
       5,     6,     7,     8,     9,    10,    11,    12,     0,    82,
      83,     0,     0,    84,     0,     0,    85,    86,   231,     0,
      73,     0,    74,    75,    76,    77,     0,     0,     0,     0,
       0,     0,   130,     0,     3,     0,     0,     0,    88,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    78,    79,
      80,    81,   295,     0,    73,     0,    74,    75,    76,    77,
       0,     0,    82,    83,     0,     0,    84,     3,     0,    85,
      86,     0,     4,     5,     6,     7,     8,     9,    10,    11,
       0,     0,    78,    79,    80,    81,     0,     0,   302,     0,
      73,    88,    74,    75,    76,    77,    82,    83,     0,     0,
      84,     0,     0,    85,    86,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,    78,    79,
      80,    81,   305,     0,    73,    88,    74,    75,    76,    77,
       0,     0,    82,    83,     0,     0,    84,     0,     0,    85,
      86,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,    78,    79,    80,    81,     0,     0,   307,     0,
      73,    88,    74,    75,    76,    77,    82,    83,     0,     0,
      84,     0,     0,    85,    86,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,    78,    79,
      80,    81,     0,     0,    73,    88,    74,    75,    76,    77,
       0,     0,    82,    83,     0,     0,    84,     0,     0,    85,
      86,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,    78,    79,    80,    81,     0,     0,     0,     0,
       0,    88,     0,     0,     0,     0,    82,    83,     0,     0,
      84,     0,     0,    85,    86,     0,     0,     0,     0,     0,
       0,     0,   226,   227,    74,    75,    76,    77,     0,     0,
       0,     0,     0,     0,     0,    88,   362,   118,     0,   119,
     120,   121,   122,   123,   124,   125,   126,   127,   128,   129,
      78,    79,    80,    81,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,    82,    83,     0,     0,    84,     0,
       0,    85,    86,    73,     3,    74,    75,    76,    77,     4,
       5,     6,     7,     8,     9,    10,    11,   130,     0,     0,
       0,     0,    58,    88,     0,     0,     0,     0,     0,     0,
       0,    78,    79,    80,    81,    73,     0,    74,    75,    76,
      77,     0,     0,     0,     0,    82,    83,     0,     0,    84,
       0,     0,    85,    86,     0,     0,     0,     0,     0,     0,
       0,     0,     0,    78,    79,    80,    81,    73,     0,    74,
      75,    76,    77,     0,    88,     0,     0,    82,    83,     0,
       0,    84,     0,     0,    85,    86,     0,     0,     0,     0,
       0,     0,     0,     0,     0,    78,    79,    80,    81,     0,
       0,   172,     0,     0,     0,    87,    88,     0,     0,    82,
      83,     0,     0,    84,     0,     0,    85,    86,    73,     0,
      74,    75,    76,    77,     0,     0,     0,    73,     0,    74,
      75,    76,    77,   325,     0,     0,     0,    87,    88,     0,
       0,     0,     0,     0,     0,     0,    78,    79,    80,    81,
       0,     0,     0,     0,     0,    78,    79,    80,    81,     0,
      82,    83,     0,     0,    84,     0,     0,    85,    86,    82,
      83,     0,     0,    84,     0,     0,    85,    86,    73,     0,
      74,    75,    76,    77,     0,     0,     0,     0,    87,    88,
       0,     0,     0,     0,     0,     0,   106,     0,    88,     0,
       0,     0,     0,     0,     0,     0,    78,    79,    80,    81,
      73,     0,    74,    75,    76,    77,     0,     0,     0,     0,
      82,    83,     0,     0,    84,     0,     0,    85,    86,     0,
       0,     0,     0,     0,     0,     0,     0,     0,    78,    79,
      80,    81,    73,   238,    74,    75,    76,    77,     0,    88,
       0,     0,    82,    83,     0,     0,    84,     0,     0,    85,
      86,     0,     0,     0,     0,     0,     0,     0,     0,     0,
      78,    79,    80,    81,     0,     0,     0,     0,     0,   254,
       0,    88,     0,     0,    82,    83,     0,     0,    84,     0,
       0,    85,    86,    73,     0,    74,    75,    76,    77,     0,
       0,     0,    73,     0,    74,    75,    76,    77,     0,     0,
       0,   319,     0,    88,     0,     0,     0,     0,     0,     0,
       0,    78,    79,    80,    81,     0,     0,     0,     0,     0,
      78,    79,    80,    81,     0,    82,    83,     0,     0,    84,
       0,     0,    85,    86,    82,    83,     0,     0,    84,     0,
       0,    85,    86,     0,     0,     0,     0,    73,   130,    74,
      75,    76,    77,     0,    88,     0,    73,     0,    74,    75,
      76,    77,     0,   161,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,    78,    79,    80,    81,     0,
       0,     0,     0,     0,    78,    79,    80,    81,     0,    82,
      83,     0,     0,    84,     0,     0,    85,    86,    82,    83,
       0,     0,    84,     0,     0,    85,    86,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,    88,     0,
       0,     0,     0,     0,     0,     0,     0,   169
};

static const yytype_int16 yycheck[] =
{
      49,    41,    50,    57,   121,   151,    62,    88,    57,    44,
      12,     0,     3,    26,   224,   156,     3,     4,     0,     3,
       4,    68,    69,    58,    34,    14,    79,    80,    81,    82,
      83,    84,    44,    87,    69,    70,     3,     4,    87,     3,
       4,     3,    56,     3,     4,    69,    70,    34,   129,     9,
      10,    11,    12,    13,    14,    15,    16,    17,    68,    73,
     108,    78,    56,    56,    70,    77,    70,    43,    85,    86,
      76,    75,    34,    62,    34,    71,   124,    71,    74,    71,
     161,    52,    53,    54,    55,    76,    88,    74,   169,   145,
      74,   301,    70,    70,    34,    35,    36,    75,    75,   134,
      71,   247,     3,    74,   221,   222,    73,   155,   249,    73,
     191,    34,    68,    68,    74,    75,   233,    73,    73,    75,
      75,    68,    68,    73,   159,    70,    73,    73,    75,    75,
      75,    70,   213,   146,    70,    68,    75,    70,    70,    75,
     189,    70,   223,    75,   225,    34,    75,    71,   229,   230,
      74,    37,    38,   206,   207,   208,   145,    73,    68,   161,
      70,    68,   175,    70,    68,   214,    70,   156,     3,     4,
      39,    40,    41,    42,     9,    10,    11,    12,    13,    14,
      15,    16,    17,   198,   199,   200,   201,     3,    68,   224,
      70,    47,   309,   310,    70,   244,    72,    48,    73,    72,
      75,    46,   250,    50,    51,    76,   260,    32,    33,    74,
     263,   260,    69,    70,    68,    69,    56,   334,    76,   336,
     337,     3,     4,    75,   341,    74,   343,    69,    70,   346,
      74,   348,    68,   350,    69,   352,     3,     4,     3,     4,
      74,    74,     1,    71,     3,   362,     5,     6,     7,     8,
     202,   203,   196,   197,   371,   295,   373,   297,   339,    68,
     249,    75,   302,   344,   253,   305,    70,   307,    76,   204,
     205,    21,    31,    32,    33,    34,    76,    76,    68,    68,
     328,    68,   331,    75,    72,    19,    45,    46,    74,    74,
      49,     3,     4,    52,    53,    75,    75,     9,    10,    11,
      12,    13,    14,    15,    16,    17,    75,    75,    72,    14,
      68,    46,    48,    20,    70,    74,    75,     1,    56,     3,
       4,     5,     6,     7,     8,     9,    10,    11,    12,    13,
      14,    15,    16,    17,    18,    54,    20,    21,    22,    23,
      24,    25,    26,    27,    28,    29,    30,    31,    32,    33,
      34,    17,   175,   110,    42,   253,   134,    69,   190,   161,
      -1,    45,    46,     0,     1,    49,     3,     4,    52,    53,
     145,   192,     9,    10,    11,    12,    13,    14,    15,    16,
      17,   193,   195,   194,    68,    69,    -1,    -1,    -1,    73,
      74,     1,    -1,     3,     4,     5,     6,     7,     8,     9,
      10,    11,    12,    13,    14,    15,    16,    17,    18,    -1,
      20,    21,    22,    23,    24,    25,    26,    27,    28,    29,
      30,    31,    32,    33,    34,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    45,    46,     0,     1,    49,
       3,     4,    52,    53,    -1,    -1,     9,    10,    11,    12,
      13,    14,    15,    16,    17,    -1,    -1,    -1,    68,    69,
      -1,    -1,    -1,    73,    74,     1,    -1,     3,     4,     5,
       6,     7,     8,     9,    10,    11,    12,    13,    14,    15,
      16,    17,    56,    57,    58,    59,    60,    61,    62,    63,
      64,    65,    66,     3,     4,    31,    32,    33,    34,     9,
      10,    11,    12,    13,    14,    15,    16,    17,    -1,    45,
      46,    -1,    -1,    49,    -1,    -1,    52,    53,     1,    -1,
       3,    -1,     5,     6,     7,     8,    -1,    -1,    -1,    -1,
      -1,    -1,    68,    -1,     4,    -1,    -1,    -1,    74,     9,
      10,    11,    12,    13,    14,    15,    16,    17,    31,    32,
      33,    34,     1,    -1,     3,    -1,     5,     6,     7,     8,
      -1,    -1,    45,    46,    -1,    -1,    49,     4,    -1,    52,
      53,    -1,     9,    10,    11,    12,    13,    14,    15,    16,
      -1,    -1,    31,    32,    33,    34,    -1,    -1,     1,    -1,
       3,    74,     5,     6,     7,     8,    45,    46,    -1,    -1,
      49,    -1,    -1,    52,    53,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    31,    32,
      33,    34,     1,    -1,     3,    74,     5,     6,     7,     8,
      -1,    -1,    45,    46,    -1,    -1,    49,    -1,    -1,    52,
      53,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    31,    32,    33,    34,    -1,    -1,     1,    -1,
       3,    74,     5,     6,     7,     8,    45,    46,    -1,    -1,
      49,    -1,    -1,    52,    53,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    31,    32,
      33,    34,    -1,    -1,     3,    74,     5,     6,     7,     8,
      -1,    -1,    45,    46,    -1,    -1,    49,    -1,    -1,    52,
      53,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    31,    32,    33,    34,    -1,    -1,    -1,    -1,
      -1,    74,    -1,    -1,    -1,    -1,    45,    46,    -1,    -1,
      49,    -1,    -1,    52,    53,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,     3,     4,     5,     6,     7,     8,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    74,    75,    18,    -1,    20,
      21,    22,    23,    24,    25,    26,    27,    28,    29,    30,
      31,    32,    33,    34,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    45,    46,    -1,    -1,    49,    -1,
      -1,    52,    53,     3,     4,     5,     6,     7,     8,     9,
      10,    11,    12,    13,    14,    15,    16,    68,    -1,    -1,
      -1,    -1,    73,    74,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    31,    32,    33,    34,     3,    -1,     5,     6,     7,
       8,    -1,    -1,    -1,    -1,    45,    46,    -1,    -1,    49,
      -1,    -1,    52,    53,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    31,    32,    33,    34,     3,    -1,     5,
       6,     7,     8,    -1,    74,    -1,    -1,    45,    46,    -1,
      -1,    49,    -1,    -1,    52,    53,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    31,    32,    33,    34,    -1,
      -1,    69,    -1,    -1,    -1,    73,    74,    -1,    -1,    45,
      46,    -1,    -1,    49,    -1,    -1,    52,    53,     3,    -1,
       5,     6,     7,     8,    -1,    -1,    -1,     3,    -1,     5,
       6,     7,     8,    69,    -1,    -1,    -1,    73,    74,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    31,    32,    33,    34,
      -1,    -1,    -1,    -1,    -1,    31,    32,    33,    34,    -1,
      45,    46,    -1,    -1,    49,    -1,    -1,    52,    53,    45,
      46,    -1,    -1,    49,    -1,    -1,    52,    53,     3,    -1,
       5,     6,     7,     8,    -1,    -1,    -1,    -1,    73,    74,
      -1,    -1,    -1,    -1,    -1,    -1,    72,    -1,    74,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    31,    32,    33,    34,
       3,    -1,     5,     6,     7,     8,    -1,    -1,    -1,    -1,
      45,    46,    -1,    -1,    49,    -1,    -1,    52,    53,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    31,    32,
      33,    34,     3,    68,     5,     6,     7,     8,    -1,    74,
      -1,    -1,    45,    46,    -1,    -1,    49,    -1,    -1,    52,
      53,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      31,    32,    33,    34,    -1,    -1,    -1,    -1,    -1,    72,
      -1,    74,    -1,    -1,    45,    46,    -1,    -1,    49,    -1,
      -1,    52,    53,     3,    -1,     5,     6,     7,     8,    -1,
      -1,    -1,     3,    -1,     5,     6,     7,     8,    -1,    -1,
      -1,    72,    -1,    74,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    31,    32,    33,    34,    -1,    -1,    -1,    -1,    -1,
      31,    32,    33,    34,    -1,    45,    46,    -1,    -1,    49,
      -1,    -1,    52,    53,    45,    46,    -1,    -1,    49,    -1,
      -1,    52,    53,    -1,    -1,    -1,    -1,     3,    68,     5,
       6,     7,     8,    -1,    74,    -1,     3,    -1,     5,     6,
       7,     8,    -1,    74,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    31,    32,    33,    34,    -1,
      -1,    -1,    -1,    -1,    31,    32,    33,    34,    -1,    45,
      46,    -1,    -1,    49,    -1,    -1,    52,    53,    45,    46,
      -1,    -1,    49,    -1,    -1,    52,    53,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    74,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    74
};

/* YYSTOS[STATE-NUM] -- The symbol kind of the accessing symbol of
   state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,     1,     3,     4,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    79,    80,    81,    82,    86,    87,    88,
      90,    92,   109,    68,    69,     3,    34,    83,    84,    85,
       3,     4,    73,    89,    87,     0,    81,    34,    68,    95,
      96,    97,   105,   106,    73,    89,   105,    68,    70,    56,
      71,     3,    93,    94,    73,    68,    70,    56,    73,   113,
       3,     4,    74,    99,   100,    34,     3,    82,    86,    91,
      73,    83,    84,     3,     5,     6,     7,     8,    31,    32,
      33,    34,    45,    46,    49,    52,    53,    73,    74,   107,
     124,   126,   127,   128,   129,   130,   131,   132,   133,   134,
     135,   136,   137,   138,   139,   140,    72,   126,    56,    69,
      70,    93,    96,    97,   107,     1,     3,     4,    18,    20,
      21,    22,    23,    24,    25,    26,    27,    28,    29,    30,
      68,    69,    82,   113,   114,   115,   116,   117,   118,   119,
     121,   122,   123,   124,     3,    74,    86,   101,   102,   103,
     104,   106,   110,   111,   112,    71,    74,    69,    82,    91,
      68,    74,   138,   137,   137,   137,   137,   137,   137,    74,
     138,   138,    69,   107,   108,    87,   123,   142,    56,    57,
      58,    59,    60,    61,    62,    63,    64,    65,    66,   125,
      44,    77,    43,    47,    48,    46,    37,    38,    39,    40,
      41,    42,    50,    51,    32,    33,    34,    35,    36,    52,
      53,    54,    55,    71,    74,    72,   126,    94,    69,    68,
      69,    76,    76,    74,    74,    74,     3,     4,   116,    74,
      74,     1,   126,    76,    68,    68,     3,     4,    68,   123,
       1,    69,   115,    68,    70,   101,    98,   105,    75,    74,
      71,    99,   100,    70,    72,   126,   110,    69,   142,    69,
      70,    98,    75,    75,   124,   128,   123,   129,   130,   131,
     132,   133,   133,   134,   134,   134,   134,   135,   135,   136,
     136,   137,   137,   137,     3,     4,     3,     4,   123,     1,
      75,   124,   141,   116,   116,     1,   123,     1,     3,    82,
     117,   120,     1,   123,    21,     1,   123,     1,   123,    76,
      76,   116,    68,    68,    68,   124,    75,    99,   110,    72,
     126,   112,    72,    75,    75,    69,   107,   137,    76,    72,
      75,    70,    75,    68,    75,   113,    75,    75,   113,   117,
      68,    75,   113,    75,    74,    68,    75,   113,    75,    68,
      75,   113,    75,   116,   116,    75,    72,   126,   124,   116,
     116,   116,    75,   123,   116,   116,   123,   116,   116,   116,
     116,    19,   116,    75,    75,   116,   116,    68
};

/* YYR1[RULE-NUM] -- Symbol kind of the left-hand side of rule RULE-NUM.  */
static const yytype_uint8 yyr1[] =
{
       0,    78,    79,    79,    80,    80,    81,    81,    81,    81,
      81,    82,    82,    82,    83,    83,    84,    84,    85,    85,
      85,    86,    86,    87,    87,    87,    87,    87,    87,    87,
      87,    88,    88,    88,    89,    89,    90,    90,    91,    91,
      92,    92,    92,    93,    93,    94,    94,    95,    95,    96,
      96,    97,    98,    99,    99,   100,   100,   100,   100,   100,
     100,   101,   101,   102,   102,   103,   103,   103,   103,   103,
     104,   104,   105,   105,   106,   106,   107,   107,   107,   107,
     108,   108,   109,   110,   110,   111,   111,   112,   113,   113,
     113,   114,   114,   115,   115,   115,   116,   116,   116,   116,
     116,   116,   117,   117,   118,   118,   118,   118,   118,   118,
     118,   118,   118,   119,   119,   119,   119,   119,   119,   119,
     119,   119,   119,   119,   119,   119,   120,   120,   121,   121,
     121,   121,   121,   122,   122,   122,   122,   122,   122,   123,
     123,   124,   124,   125,   125,   125,   125,   125,   125,   125,
     125,   125,   125,   125,   126,   126,   127,   127,   128,   128,
     129,   129,   130,   130,   131,   131,   132,   132,   132,   133,
     133,   133,   133,   133,   134,   134,   134,   135,   135,   135,
     136,   136,   136,   136,   137,   137,   138,   138,   138,   138,
     138,   138,   138,   138,   138,   138,   138,   139,   139,   139,
     139,   139,   139,   139,   139,   139,   139,   139,   140,   140,
     140,   140,   140,   140,   141,   141,   142
};

/* YYR2[RULE-NUM] -- Number of symbols on the right-hand side of rule RULE-NUM.  */
static const yytype_int8 yyr2[] =
{
       0,     2,     1,     0,     1,     2,     1,     1,     5,     2,
       2,     3,     2,     3,     1,     3,     1,     3,     1,     3,
       4,     1,     2,     1,     1,     1,     1,     1,     1,     1,
       1,     5,     4,     2,     1,     1,     1,     1,     1,     2,
       5,     4,     2,     1,     3,     1,     3,     1,     3,     1,
       3,     2,     2,     0,     1,     1,     1,     3,     3,     4,
       4,     1,     1,     2,     1,     1,     3,     3,     4,     4,
       0,     1,     0,     1,     1,     2,     1,     2,     3,     4,
       1,     3,     3,     0,     1,     1,     3,     2,     2,     3,
       3,     1,     2,     1,     1,     2,     1,     1,     1,     1,
       1,     1,     1,     2,     5,     7,     5,     5,     5,     4,
       4,     4,     4,     5,     7,     5,     6,     7,     5,     5,
       5,     4,     4,     4,     4,     4,     1,     1,     3,     3,
       4,     3,     4,     3,     3,     2,     2,     2,     3,     1,
       3,     1,     3,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     5,     1,     3,     1,     3,
       1,     3,     1,     3,     1,     3,     1,     3,     3,     1,
       3,     3,     3,     3,     1,     3,     3,     1,     3,     3,
       1,     3,     3,     3,     1,     4,     1,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     4,     1,     4,     3,
       4,     4,     3,     3,     3,     3,     2,     2,     1,     1,
       1,     1,     1,     3,     1,     3,     2
};


enum { YYENOMEM = -2 };

#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab
#define YYNOMEM         goto yyexhaustedlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                    \
  do                                                              \
    if (yychar == YYEMPTY)                                        \
      {                                                           \
        yychar = (Token);                                         \
        yylval = (Value);                                         \
        YYPOPSTACK (yylen);                                       \
        yystate = *yyssp;                                         \
        goto yybackup;                                            \
      }                                                           \
    else                                                          \
      {                                                           \
        yyerror (YY_("syntax error: cannot back up")); \
        YYERROR;                                                  \
      }                                                           \
  while (0)

/* Backward compatibility with an undocumented macro.
   Use YYerror or YYUNDEF. */
#define YYERRCODE YYUNDEF

/* YYLLOC_DEFAULT -- Set CURRENT to span from RHS[1] to RHS[N].
   If N is 0, then set CURRENT to the empty location which ends
   the previous symbol: RHS[0] (always defined).  */

#ifndef YYLLOC_DEFAULT
# define YYLLOC_DEFAULT(Current, Rhs, N)                                \
    do                                                                  \
      if (N)                                                            \
        {                                                               \
          (Current).first_line   = YYRHSLOC (Rhs, 1).first_line;        \
          (Current).first_column = YYRHSLOC (Rhs, 1).first_column;      \
          (Current).last_line    = YYRHSLOC (Rhs, N).last_line;         \
          (Current).last_column  = YYRHSLOC (Rhs, N).last_column;       \
        }                                                               \
      else                                                              \
        {                                                               \
          (Current).first_line   = (Current).last_line   =              \
            YYRHSLOC (Rhs, 0).last_line;                                \
          (Current).first_column = (Current).last_column =              \
            YYRHSLOC (Rhs, 0).last_column;                              \
        }                                                               \
    while (0)
#endif

#define YYRHSLOC(Rhs, K) ((Rhs)[K])


/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)


/* YYLOCATION_PRINT -- Print the location on the stream.
   This macro was not mandated originally: define only if we know
   we won't break user code: when these are the locations we know.  */

# ifndef YYLOCATION_PRINT

#  if defined YY_LOCATION_PRINT

   /* Temporary convenience wrapper in case some people defined the
      undocumented and private YY_LOCATION_PRINT macros.  */
#   define YYLOCATION_PRINT(File, Loc)  YY_LOCATION_PRINT(File, *(Loc))

#  elif defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL

/* Print *YYLOCP on YYO.  Private, do not rely on its existence. */

YY_ATTRIBUTE_UNUSED
static int
yy_location_print_ (FILE *yyo, YYLTYPE const * const yylocp)
{
  int res = 0;
  int end_col = 0 != yylocp->last_column ? yylocp->last_column - 1 : 0;
  if (0 <= yylocp->first_line)
    {
      res += YYFPRINTF (yyo, "%d", yylocp->first_line);
      if (0 <= yylocp->first_column)
        res += YYFPRINTF (yyo, ".%d", yylocp->first_column);
    }
  if (0 <= yylocp->last_line)
    {
      if (yylocp->first_line < yylocp->last_line)
        {
          res += YYFPRINTF (yyo, "-%d", yylocp->last_line);
          if (0 <= end_col)
            res += YYFPRINTF (yyo, ".%d", end_col);
        }
      else if (0 <= end_col && yylocp->first_column < end_col)
        res += YYFPRINTF (yyo, "-%d", end_col);
    }
  return res;
}

#   define YYLOCATION_PRINT  yy_location_print_

    /* Temporary convenience wrapper in case some people defined the
       undocumented and private YY_LOCATION_PRINT macros.  */
#   define YY_LOCATION_PRINT(File, Loc)  YYLOCATION_PRINT(File, &(Loc))

#  else

#   define YYLOCATION_PRINT(File, Loc) ((void) 0)
    /* Temporary convenience wrapper in case some people defined the
       undocumented and private YY_LOCATION_PRINT macros.  */
#   define YY_LOCATION_PRINT  YYLOCATION_PRINT

#  endif
# endif /* !defined YYLOCATION_PRINT */


# define YY_SYMBOL_PRINT(Title, Kind, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Kind, Value, Location); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*-----------------------------------.
| Print this symbol's value on YYO.  |
`-----------------------------------*/

static void
yy_symbol_value_print (FILE *yyo,
                       yysymbol_kind_t yykind, YYSTYPE const * const yyvaluep, YYLTYPE const * const yylocationp)
{
  FILE *yyoutput = yyo;
  YY_USE (yyoutput);
  YY_USE (yylocationp);
  if (!yyvaluep)
    return;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YY_USE (yykind);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/*---------------------------.
| Print this symbol on YYO.  |
`---------------------------*/

static void
yy_symbol_print (FILE *yyo,
                 yysymbol_kind_t yykind, YYSTYPE const * const yyvaluep, YYLTYPE const * const yylocationp)
{
  YYFPRINTF (yyo, "%s %s (",
             yykind < YYNTOKENS ? "token" : "nterm", yysymbol_name (yykind));

  YYLOCATION_PRINT (yyo, yylocationp);
  YYFPRINTF (yyo, ": ");
  yy_symbol_value_print (yyo, yykind, yyvaluep, yylocationp);
  YYFPRINTF (yyo, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yy_state_t *yybottom, yy_state_t *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yy_state_t *yyssp, YYSTYPE *yyvsp, YYLTYPE *yylsp,
                 int yyrule)
{
  int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %d):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       YY_ACCESSING_SYMBOL (+yyssp[yyi + 1 - yynrhs]),
                       &yyvsp[(yyi + 1) - (yynrhs)],
                       &(yylsp[(yyi + 1) - (yynrhs)]));
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, yylsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args) ((void) 0)
# define YY_SYMBOL_PRINT(Title, Kind, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


/* Context of a parse error.  */
typedef struct
{
  yy_state_t *yyssp;
  yysymbol_kind_t yytoken;
  YYLTYPE *yylloc;
} yypcontext_t;

/* Put in YYARG at most YYARGN of the expected tokens given the
   current YYCTX, and return the number of tokens stored in YYARG.  If
   YYARG is null, return the number of expected tokens (guaranteed to
   be less than YYNTOKENS).  Return YYENOMEM on memory exhaustion.
   Return 0 if there are more than YYARGN expected tokens, yet fill
   YYARG up to YYARGN. */
static int
yypcontext_expected_tokens (const yypcontext_t *yyctx,
                            yysymbol_kind_t yyarg[], int yyargn)
{
  /* Actual size of YYARG. */
  int yycount = 0;
  int yyn = yypact[+*yyctx->yyssp];
  if (!yypact_value_is_default (yyn))
    {
      /* Start YYX at -YYN if negative to avoid negative indexes in
         YYCHECK.  In other words, skip the first -YYN actions for
         this state because they are default actions.  */
      int yyxbegin = yyn < 0 ? -yyn : 0;
      /* Stay within bounds of both yycheck and yytname.  */
      int yychecklim = YYLAST - yyn + 1;
      int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
      int yyx;
      for (yyx = yyxbegin; yyx < yyxend; ++yyx)
        if (yycheck[yyx + yyn] == yyx && yyx != YYSYMBOL_YYerror
            && !yytable_value_is_error (yytable[yyx + yyn]))
          {
            if (!yyarg)
              ++yycount;
            else if (yycount == yyargn)
              return 0;
            else
              yyarg[yycount++] = YY_CAST (yysymbol_kind_t, yyx);
          }
    }
  if (yyarg && yycount == 0 && 0 < yyargn)
    yyarg[0] = YYSYMBOL_YYEMPTY;
  return yycount;
}




#ifndef yystrlen
# if defined __GLIBC__ && defined _STRING_H
#  define yystrlen(S) (YY_CAST (YYPTRDIFF_T, strlen (S)))
# else
/* Return the length of YYSTR.  */
static YYPTRDIFF_T
yystrlen (const char *yystr)
{
  YYPTRDIFF_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
# endif
#endif

#ifndef yystpcpy
# if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#  define yystpcpy stpcpy
# else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
# endif
#endif



static int
yy_syntax_error_arguments (const yypcontext_t *yyctx,
                           yysymbol_kind_t yyarg[], int yyargn)
{
  /* Actual size of YYARG. */
  int yycount = 0;
  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yyctx->yytoken != YYSYMBOL_YYEMPTY)
    {
      int yyn;
      if (yyarg)
        yyarg[yycount] = yyctx->yytoken;
      ++yycount;
      yyn = yypcontext_expected_tokens (yyctx,
                                        yyarg ? yyarg + 1 : yyarg, yyargn - 1);
      if (yyn == YYENOMEM)
        return YYENOMEM;
      else
        yycount += yyn;
    }
  return yycount;
}

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return -1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return YYENOMEM if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYPTRDIFF_T *yymsg_alloc, char **yymsg,
                const yypcontext_t *yyctx)
{
  enum { YYARGS_MAX = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat: reported tokens (one for the "unexpected",
     one per "expected"). */
  yysymbol_kind_t yyarg[YYARGS_MAX];
  /* Cumulated lengths of YYARG.  */
  YYPTRDIFF_T yysize = 0;

  /* Actual size of YYARG. */
  int yycount = yy_syntax_error_arguments (yyctx, yyarg, YYARGS_MAX);
  if (yycount == YYENOMEM)
    return YYENOMEM;

  switch (yycount)
    {
#define YYCASE_(N, S)                       \
      case N:                               \
        yyformat = S;                       \
        break
    default: /* Avoid compiler warnings. */
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
#undef YYCASE_
    }

  /* Compute error message size.  Don't count the "%s"s, but reserve
     room for the terminator.  */
  yysize = yystrlen (yyformat) - 2 * yycount + 1;
  {
    int yyi;
    for (yyi = 0; yyi < yycount; ++yyi)
      {
        YYPTRDIFF_T yysize1
          = yysize + yystrlen (yysymbol_name (yyarg[yyi]));
        if (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM)
          yysize = yysize1;
        else
          return YYENOMEM;
      }
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return -1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp = yystpcpy (yyp, yysymbol_name (yyarg[yyi++]));
          yyformat += 2;
        }
      else
        {
          ++yyp;
          ++yyformat;
        }
  }
  return 0;
}


/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg,
            yysymbol_kind_t yykind, YYSTYPE *yyvaluep, YYLTYPE *yylocationp)
{
  YY_USE (yyvaluep);
  YY_USE (yylocationp);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yykind, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YY_USE (yykind);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/* Lookahead token kind.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Location data for the lookahead symbol.  */
YYLTYPE yylloc
# if defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL
  = { 1, 1, 1, 1 }
# endif
;
/* Number of syntax errors so far.  */
int yynerrs;




/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    yy_state_fast_t yystate = 0;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus = 0;

    /* Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* Their size.  */
    YYPTRDIFF_T yystacksize = YYINITDEPTH;

    /* The state stack: array, bottom, top.  */
    yy_state_t yyssa[YYINITDEPTH];
    yy_state_t *yyss = yyssa;
    yy_state_t *yyssp = yyss;

    /* The semantic value stack: array, bottom, top.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs = yyvsa;
    YYSTYPE *yyvsp = yyvs;

    /* The location stack: array, bottom, top.  */
    YYLTYPE yylsa[YYINITDEPTH];
    YYLTYPE *yyls = yylsa;
    YYLTYPE *yylsp = yyls;

  int yyn;
  /* The return value of yyparse.  */
  int yyresult;
  /* Lookahead symbol kind.  */
  yysymbol_kind_t yytoken = YYSYMBOL_YYEMPTY;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;
  YYLTYPE yyloc;

  /* The locations where the error started and ended.  */
  YYLTYPE yyerror_range[3];

  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYPTRDIFF_T yymsg_alloc = sizeof yymsgbuf;

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N), yylsp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yychar = YYEMPTY; /* Cause a token to be read.  */

  yylsp[0] = yylloc;
  goto yysetstate;


/*------------------------------------------------------------.
| yynewstate -- push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;


/*--------------------------------------------------------------------.
| yysetstate -- set current state (the top of the stack) to yystate.  |
`--------------------------------------------------------------------*/
yysetstate:
  YYDPRINTF ((stderr, "Entering state %d\n", yystate));
  YY_ASSERT (0 <= yystate && yystate < YYNSTATES);
  YY_IGNORE_USELESS_CAST_BEGIN
  *yyssp = YY_CAST (yy_state_t, yystate);
  YY_IGNORE_USELESS_CAST_END
  YY_STACK_PRINT (yyss, yyssp);

  if (yyss + yystacksize - 1 <= yyssp)
#if !defined yyoverflow && !defined YYSTACK_RELOCATE
    YYNOMEM;
#else
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYPTRDIFF_T yysize = yyssp - yyss + 1;

# if defined yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        yy_state_t *yyss1 = yyss;
        YYSTYPE *yyvs1 = yyvs;
        YYLTYPE *yyls1 = yyls;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * YYSIZEOF (*yyssp),
                    &yyvs1, yysize * YYSIZEOF (*yyvsp),
                    &yyls1, yysize * YYSIZEOF (*yylsp),
                    &yystacksize);
        yyss = yyss1;
        yyvs = yyvs1;
        yyls = yyls1;
      }
# else /* defined YYSTACK_RELOCATE */
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        YYNOMEM;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yy_state_t *yyss1 = yyss;
        union yyalloc *yyptr =
          YY_CAST (union yyalloc *,
                   YYSTACK_ALLOC (YY_CAST (YYSIZE_T, YYSTACK_BYTES (yystacksize))));
        if (! yyptr)
          YYNOMEM;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
        YYSTACK_RELOCATE (yyls_alloc, yyls);
#  undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;
      yylsp = yyls + yysize - 1;

      YY_IGNORE_USELESS_CAST_BEGIN
      YYDPRINTF ((stderr, "Stack size increased to %ld\n",
                  YY_CAST (long, yystacksize)));
      YY_IGNORE_USELESS_CAST_END

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }
#endif /* !defined yyoverflow && !defined YYSTACK_RELOCATE */


  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;


/*-----------.
| yybackup.  |
`-----------*/
yybackup:
  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either empty, or end-of-input, or a valid lookahead.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token\n"));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = YYEOF;
      yytoken = YYSYMBOL_YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else if (yychar == YYerror)
    {
      /* The scanner already issued an error message, process directly
         to error recovery.  But do not keep the error token as
         lookahead, it is too special and may lead us to an endless
         loop in error recovery. */
      yychar = YYUNDEF;
      yytoken = YYSYMBOL_YYerror;
      yyerror_range[1] = yylloc;
      goto yyerrlab1;
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);
  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END
  *++yylsp = yylloc;

  /* Discard the shifted token.  */
  yychar = YYEMPTY;
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];

  /* Default location. */
  YYLLOC_DEFAULT (yyloc, (yylsp - yylen), yylen);
  yyerror_range[1] = yyloc;
  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
  case 2: /* Program: TranslationUnit  */
#line 184 "src/parser.y"
                                 { g_program = (yyvsp[0].node); (yyval.node) = (yyvsp[0].node); }
#line 2109 "build/parser.tab.cc"
    break;

  case 3: /* Program: %empty  */
#line 185 "src/parser.y"
                                 { g_program = mk(N_PROGRAM, 1, 1); (yyval.node) = g_program; }
#line 2115 "build/parser.tab.cc"
    break;

  case 4: /* TranslationUnit: ExternalDecl  */
#line 189 "src/parser.y"
                                 { (yyval.node) = mk(N_PROGRAM, (yylsp[0]).first_line, (yylsp[0]).first_column);
                                   if ((yyvsp[0].node)) (yyval.node)->kids.push_back((yyvsp[0].node)); }
#line 2122 "build/parser.tab.cc"
    break;

  case 5: /* TranslationUnit: TranslationUnit ExternalDecl  */
#line 192 "src/parser.y"
                                 { (yyval.node) = (yyvsp[-1].node); if ((yyvsp[0].node)) (yyval.node)->kids.push_back((yyvsp[0].node)); }
#line 2128 "build/parser.tab.cc"
    break;

  case 6: /* ExternalDecl: FuncDef  */
#line 196 "src/parser.y"
                                 { (yyval.node) = (yyvsp[0].node); }
#line 2134 "build/parser.tab.cc"
    break;

  case 7: /* ExternalDecl: Decl  */
#line 197 "src/parser.y"
                                 { (yyval.node) = (yyvsp[0].node); }
#line 2140 "build/parser.tab.cc"
    break;

  case 8: /* ExternalDecl: IDENTIFIER MUL_OP Pointers PlainInitDeclList ';'  */
#line 205 "src/parser.y"
        { in_typedef_decl = 0;
          (yyval.node) = unknownTypeDecl((yylsp[-4]).first_line, (yylsp[-4]).first_column, (yyvsp[-4].str), (yyvsp[-2].ival) + 1, (yyvsp[-1].node)); }
#line 2147 "build/parser.tab.cc"
    break;

  case 9: /* ExternalDecl: error ';'  */
#line 207 "src/parser.y"
                                 { yyerrok; in_typedef_decl = 0; (yyval.node) = 0; }
#line 2153 "build/parser.tab.cc"
    break;

  case 10: /* ExternalDecl: error '}'  */
#line 208 "src/parser.y"
                                 { yyerrok; in_typedef_decl = 0; (yyval.node) = 0; }
#line 2159 "build/parser.tab.cc"
    break;

  case 11: /* Decl: DeclSpec InitDeclaratorList ';'  */
#line 215 "src/parser.y"
        { in_typedef_decl = 0; clear_param_names();
          (yyval.node) = (yyvsp[-2].node);
          for (size_t i = 0; i < (yyvsp[-1].node)->kids.size(); ++i) (yyval.node)->kids.push_back((yyvsp[-1].node)->kids[i]); }
#line 2167 "build/parser.tab.cc"
    break;

  case 12: /* Decl: DeclSpec ';'  */
#line 219 "src/parser.y"
        { in_typedef_decl = 0; clear_param_names(); (yyval.node) = (yyvsp[-1].node); }
#line 2173 "build/parser.tab.cc"
    break;

  case 13: /* Decl: IDENTIFIER PlainInitDeclList ';'  */
#line 226 "src/parser.y"
        { in_typedef_decl = 0;
          (yyval.node) = unknownTypeDecl((yylsp[-2]).first_line, (yylsp[-2]).first_column, (yyvsp[-2].str), 0, (yyvsp[-1].node)); }
#line 2180 "build/parser.tab.cc"
    break;

  case 14: /* PlainInitDeclList: PlainInitDecl  */
#line 231 "src/parser.y"
                                             { (yyval.node) = listNode((yylsp[0]).first_line, (yylsp[0]).first_column);
                                               appendTo((yyval.node), (yyvsp[0].node)); }
#line 2187 "build/parser.tab.cc"
    break;

  case 15: /* PlainInitDeclList: PlainInitDeclList ',' PlainInitDecl  */
#line 233 "src/parser.y"
                                             { (yyval.node) = appendTo((yyvsp[-2].node), (yyvsp[0].node)); }
#line 2193 "build/parser.tab.cc"
    break;

  case 16: /* PlainInitDecl: PlainDeclarator  */
#line 237 "src/parser.y"
                                             { (yyval.node) = (yyvsp[0].node); }
#line 2199 "build/parser.tab.cc"
    break;

  case 17: /* PlainInitDecl: PlainDeclarator ASSIGN Initializer  */
#line 238 "src/parser.y"
                                             { (yyval.node) = (yyvsp[-2].node); }
#line 2205 "build/parser.tab.cc"
    break;

  case 18: /* PlainDeclarator: IDENTIFIER  */
#line 242 "src/parser.y"
                                                  { (yyval.node) = mk(N_DCL_NAME, (yylsp[0]).first_line, (yylsp[0]).first_column);
                                                    (yyval.node)->sval = (yyvsp[0].str); }
#line 2212 "build/parser.tab.cc"
    break;

  case 19: /* PlainDeclarator: PlainDeclarator '[' ']'  */
#line 244 "src/parser.y"
                                                  { (yyval.node) = mk2(N_DCL_ARRAY, (yylsp[-2]).first_line, (yylsp[-2]).first_column, (yyvsp[-2].node), 0); }
#line 2218 "build/parser.tab.cc"
    break;

  case 20: /* PlainDeclarator: PlainDeclarator '[' CondExpr ']'  */
#line 245 "src/parser.y"
                                                  { (yyval.node) = mk2(N_DCL_ARRAY, (yylsp[-3]).first_line, (yylsp[-3]).first_column, (yyvsp[-3].node), (yyvsp[-1].node)); }
#line 2224 "build/parser.tab.cc"
    break;

  case 21: /* DeclSpec: TypeSpec  */
#line 255 "src/parser.y"
                          { (yyval.node) = mk1(N_DECL, (yylsp[0]).first_line, (yylsp[0]).first_column, (yyvsp[0].node));
                            (yyval.node)->ival = 0; }
#line 2231 "build/parser.tab.cc"
    break;

  case 22: /* DeclSpec: TYPEDEF TypeSpec  */
#line 257 "src/parser.y"
                          { in_typedef_decl = 1;
                            (yyval.node) = mk1(N_DECL, (yylsp[-1]).first_line, (yylsp[-1]).first_column, (yyvsp[0].node));
                            (yyval.node)->ival = 1; }
#line 2239 "build/parser.tab.cc"
    break;

  case 23: /* TypeSpec: INT  */
#line 263 "src/parser.y"
                      { (yyval.node) = mk(N_TYPESPEC, (yylsp[0]).first_line, (yylsp[0]).first_column); (yyval.node)->ival = 0; }
#line 2245 "build/parser.tab.cc"
    break;

  case 24: /* TypeSpec: CHAR  */
#line 264 "src/parser.y"
                      { (yyval.node) = mk(N_TYPESPEC, (yylsp[0]).first_line, (yylsp[0]).first_column); (yyval.node)->ival = 1; }
#line 2251 "build/parser.tab.cc"
    break;

  case 25: /* TypeSpec: FLOAT  */
#line 265 "src/parser.y"
                      { (yyval.node) = mk(N_TYPESPEC, (yylsp[0]).first_line, (yylsp[0]).first_column); (yyval.node)->ival = 2;
                        (yyval.node)->sval = "float"; }
#line 2258 "build/parser.tab.cc"
    break;

  case 26: /* TypeSpec: DOUBLE  */
#line 267 "src/parser.y"
                      { (yyval.node) = mk(N_TYPESPEC, (yylsp[0]).first_line, (yylsp[0]).first_column); (yyval.node)->ival = 3;
                        (yyval.node)->sval = "double"; }
#line 2265 "build/parser.tab.cc"
    break;

  case 27: /* TypeSpec: VOID  */
#line 269 "src/parser.y"
                      { (yyval.node) = mk(N_TYPESPEC, (yylsp[0]).first_line, (yylsp[0]).first_column); (yyval.node)->ival = 4; }
#line 2271 "build/parser.tab.cc"
    break;

  case 28: /* TypeSpec: TYPE_NAME  */
#line 270 "src/parser.y"
                      { (yyval.node) = mk(N_TYPESPEC, (yylsp[0]).first_line, (yylsp[0]).first_column); (yyval.node)->ival = 5;
                        (yyval.node)->sval = (yyvsp[0].str); }
#line 2278 "build/parser.tab.cc"
    break;

  case 29: /* TypeSpec: StructUnionSpec  */
#line 272 "src/parser.y"
                      { (yyval.node) = (yyvsp[0].node); }
#line 2284 "build/parser.tab.cc"
    break;

  case 30: /* TypeSpec: EnumSpec  */
#line 273 "src/parser.y"
                      { (yyval.node) = (yyvsp[0].node); }
#line 2290 "build/parser.tab.cc"
    break;

  case 31: /* StructUnionSpec: StructOrUnion TagName '{' StructDeclList '}'  */
#line 278 "src/parser.y"
        { (yyval.node) = (yyvsp[-1].node); (yyval.node)->kind = N_STRUCTSPEC; (yyval.node)->sval = (yyvsp[-3].str); (yyval.node)->ival = (yyvsp[-4].ival) | 2;
          (yyval.node)->line = (yylsp[-4]).first_line; (yyval.node)->col = (yylsp[-4]).first_column; }
#line 2297 "build/parser.tab.cc"
    break;

  case 32: /* StructUnionSpec: StructOrUnion '{' StructDeclList '}'  */
#line 281 "src/parser.y"
        { (yyval.node) = (yyvsp[-1].node); (yyval.node)->kind = N_STRUCTSPEC; (yyval.node)->sval = ""; (yyval.node)->ival = (yyvsp[-3].ival) | 2;
          (yyval.node)->line = (yylsp[-3]).first_line; (yyval.node)->col = (yylsp[-3]).first_column; }
#line 2304 "build/parser.tab.cc"
    break;

  case 33: /* StructUnionSpec: StructOrUnion TagName  */
#line 284 "src/parser.y"
        { (yyval.node) = mk(N_STRUCTSPEC, (yylsp[-1]).first_line, (yylsp[-1]).first_column); (yyval.node)->sval = (yyvsp[0].str); (yyval.node)->ival = (yyvsp[-1].ival); }
#line 2310 "build/parser.tab.cc"
    break;

  case 34: /* TagName: IDENTIFIER  */
#line 293 "src/parser.y"
                    { (yyval.str) = (yyvsp[0].str); }
#line 2316 "build/parser.tab.cc"
    break;

  case 35: /* TagName: TYPE_NAME  */
#line 294 "src/parser.y"
                    { (yyval.str) = (yyvsp[0].str); }
#line 2322 "build/parser.tab.cc"
    break;

  case 36: /* StructOrUnion: STRUCT  */
#line 298 "src/parser.y"
                { (yyval.ival) = 0; }
#line 2328 "build/parser.tab.cc"
    break;

  case 37: /* StructOrUnion: UNION  */
#line 299 "src/parser.y"
                { (yyval.ival) = 1; }
#line 2334 "build/parser.tab.cc"
    break;

  case 38: /* StructDeclList: Decl  */
#line 303 "src/parser.y"
                              { (yyval.node) = listNode((yylsp[0]).first_line, (yylsp[0]).first_column);
                                if ((yyvsp[0].node)) appendTo((yyval.node), (yyvsp[0].node)); }
#line 2341 "build/parser.tab.cc"
    break;

  case 39: /* StructDeclList: StructDeclList Decl  */
#line 305 "src/parser.y"
                              { (yyval.node) = (yyvsp[-1].node); if ((yyvsp[0].node)) appendTo((yyval.node), (yyvsp[0].node)); }
#line 2347 "build/parser.tab.cc"
    break;

  case 40: /* EnumSpec: ENUM TagName '{' EnumList '}'  */
#line 310 "src/parser.y"
        { (yyval.node) = (yyvsp[-1].node); (yyval.node)->kind = N_ENUMSPEC; (yyval.node)->sval = (yyvsp[-3].str); (yyval.node)->ival = 2;
          (yyval.node)->line = (yylsp[-4]).first_line; (yyval.node)->col = (yylsp[-4]).first_column; }
#line 2354 "build/parser.tab.cc"
    break;

  case 41: /* EnumSpec: ENUM '{' EnumList '}'  */
#line 313 "src/parser.y"
        { (yyval.node) = (yyvsp[-1].node); (yyval.node)->kind = N_ENUMSPEC; (yyval.node)->sval = ""; (yyval.node)->ival = 2;
          (yyval.node)->line = (yylsp[-3]).first_line; (yyval.node)->col = (yylsp[-3]).first_column; }
#line 2361 "build/parser.tab.cc"
    break;

  case 42: /* EnumSpec: ENUM TagName  */
#line 316 "src/parser.y"
        { (yyval.node) = mk(N_ENUMSPEC, (yylsp[-1]).first_line, (yylsp[-1]).first_column); (yyval.node)->sval = (yyvsp[0].str); (yyval.node)->ival = 0; }
#line 2367 "build/parser.tab.cc"
    break;

  case 43: /* EnumList: Enumerator  */
#line 320 "src/parser.y"
                                   { (yyval.node) = listNode((yylsp[0]).first_line, (yylsp[0]).first_column);
                                     appendTo((yyval.node), (yyvsp[0].node)); }
#line 2374 "build/parser.tab.cc"
    break;

  case 44: /* EnumList: EnumList ',' Enumerator  */
#line 322 "src/parser.y"
                                   { (yyval.node) = appendTo((yyvsp[-2].node), (yyvsp[0].node)); }
#line 2380 "build/parser.tab.cc"
    break;

  case 45: /* Enumerator: IDENTIFIER  */
#line 327 "src/parser.y"
        { (yyval.node) = mk1(N_ENUMERATOR, (yylsp[0]).first_line, (yylsp[0]).first_column, 0);
          (yyval.node)->kids.clear(); (yyval.node)->kids.push_back(0); (yyval.node)->sval = (yyvsp[0].str); }
#line 2387 "build/parser.tab.cc"
    break;

  case 46: /* Enumerator: IDENTIFIER ASSIGN CondExpr  */
#line 330 "src/parser.y"
        { (yyval.node) = mk1(N_ENUMERATOR, (yylsp[-2]).first_line, (yylsp[-2]).first_column, (yyvsp[0].node)); (yyval.node)->sval = (yyvsp[-2].str); }
#line 2393 "build/parser.tab.cc"
    break;

  case 47: /* InitDeclaratorList: InitDeclarator  */
#line 334 "src/parser.y"
                                              { (yyval.node) = listNode((yylsp[0]).first_line, (yylsp[0]).first_column);
                                                appendTo((yyval.node), (yyvsp[0].node)); }
#line 2400 "build/parser.tab.cc"
    break;

  case 48: /* InitDeclaratorList: InitDeclaratorList ',' InitDeclarator  */
#line 336 "src/parser.y"
                                              { (yyval.node) = appendTo((yyvsp[-2].node), (yyvsp[0].node)); }
#line 2406 "build/parser.tab.cc"
    break;

  case 49: /* InitDeclarator: Declarator  */
#line 341 "src/parser.y"
        { (yyval.node) = initDeclarator((yyvsp[0].node), 0, (yylsp[0]).first_line, (yylsp[0]).first_column); }
#line 2412 "build/parser.tab.cc"
    break;

  case 50: /* InitDeclarator: Declarator ASSIGN Initializer  */
#line 343 "src/parser.y"
        { (yyval.node) = initDeclarator((yyvsp[-2].node), (yyvsp[0].node), (yylsp[-2]).first_line, (yylsp[-2]).first_column); }
#line 2418 "build/parser.tab.cc"
    break;

  case 51: /* Declarator: Pointers NonEmptyDirect  */
#line 359 "src/parser.y"
        { (yyval.node) = wrapPointers((yyvsp[-1].ival), (yyvsp[0].node), (yylsp[0]).first_line, (yylsp[0]).first_column); }
#line 2424 "build/parser.tab.cc"
    break;

  case 52: /* AbstractDeclarator: Pointers DirectDeclarator  */
#line 367 "src/parser.y"
        { (yyval.node) = wrapPointers((yyvsp[-1].ival), (yyvsp[0].node), (yylsp[0]).first_line, (yylsp[0]).first_column); }
#line 2430 "build/parser.tab.cc"
    break;

  case 53: /* DirectDeclarator: %empty  */
#line 373 "src/parser.y"
                                            { (yyval.node) = mk(N_DCL_NAME, (yyloc).first_line, (yyloc).first_column);
                                              (yyval.node)->sval = ""; }
#line 2437 "build/parser.tab.cc"
    break;

  case 54: /* DirectDeclarator: NonEmptyDirect  */
#line 375 "src/parser.y"
                                            { (yyval.node) = (yyvsp[0].node); }
#line 2443 "build/parser.tab.cc"
    break;

  case 55: /* NonEmptyDirect: IDENTIFIER  */
#line 379 "src/parser.y"
                                            { (yyval.node) = mk(N_DCL_NAME, (yylsp[0]).first_line, (yylsp[0]).first_column);
                                              (yyval.node)->sval = (yyvsp[0].str); }
#line 2450 "build/parser.tab.cc"
    break;

  case 56: /* NonEmptyDirect: TYPE_NAME  */
#line 387 "src/parser.y"
                                            { (yyval.node) = mk(N_DCL_NAME, (yylsp[0]).first_line, (yylsp[0]).first_column);
                                              (yyval.node)->sval = (yyvsp[0].str); }
#line 2457 "build/parser.tab.cc"
    break;

  case 57: /* NonEmptyDirect: '(' ParenContent ')'  */
#line 389 "src/parser.y"
                                            { (yyval.node) = (yyvsp[-1].node); }
#line 2463 "build/parser.tab.cc"
    break;

  case 58: /* NonEmptyDirect: DirectDeclarator '[' ']'  */
#line 390 "src/parser.y"
                                            { (yyval.node) = mk2(N_DCL_ARRAY, (yylsp[-2]).first_line, (yylsp[-2]).first_column, (yyvsp[-2].node), 0); }
#line 2469 "build/parser.tab.cc"
    break;

  case 59: /* NonEmptyDirect: DirectDeclarator '[' CondExpr ']'  */
#line 391 "src/parser.y"
                                            { (yyval.node) = mk2(N_DCL_ARRAY, (yylsp[-3]).first_line, (yylsp[-3]).first_column, (yyvsp[-3].node), (yyvsp[-1].node)); }
#line 2475 "build/parser.tab.cc"
    break;

  case 60: /* NonEmptyDirect: NonEmptyDirect '(' ParamList ')'  */
#line 396 "src/parser.y"
                                            { (yyval.node) = mk2(N_DCL_FUNC, (yylsp[-3]).first_line, (yylsp[-3]).first_column, (yyvsp[-3].node), (yyvsp[-1].node)); }
#line 2481 "build/parser.tab.cc"
    break;

  case 61: /* ParenContent: GroupedDeclarator  */
#line 419 "src/parser.y"
                          { (yyval.node) = (yyvsp[0].node); }
#line 2487 "build/parser.tab.cc"
    break;

  case 62: /* ParenContent: ParamList  */
#line 421 "src/parser.y"
        { Node* nm = mk(N_DCL_NAME, (yyloc).first_line, (yyloc).first_column); nm->sval = "";
          (yyval.node) = mk2(N_DCL_FUNC, (yyloc).first_line, (yyloc).first_column, nm, (yyvsp[0].node)); }
#line 2494 "build/parser.tab.cc"
    break;

  case 63: /* GroupedDeclarator: PtrStars DirectDeclarator  */
#line 431 "src/parser.y"
        { (yyval.node) = wrapPointers((yyvsp[-1].ival), (yyvsp[0].node), (yylsp[-1]).first_line, (yylsp[-1]).first_column); }
#line 2500 "build/parser.tab.cc"
    break;

  case 64: /* GroupedDeclarator: GroupDirect  */
#line 433 "src/parser.y"
        { (yyval.node) = (yyvsp[0].node); }
#line 2506 "build/parser.tab.cc"
    break;

  case 65: /* GroupDirect: IDENTIFIER  */
#line 440 "src/parser.y"
                                            { (yyval.node) = mk(N_DCL_NAME, (yylsp[0]).first_line, (yylsp[0]).first_column);
                                              (yyval.node)->sval = (yyvsp[0].str); }
#line 2513 "build/parser.tab.cc"
    break;

  case 66: /* GroupDirect: '(' ParenContent ')'  */
#line 442 "src/parser.y"
                                            { (yyval.node) = (yyvsp[-1].node); }
#line 2519 "build/parser.tab.cc"
    break;

  case 67: /* GroupDirect: GroupDirectOpt '[' ']'  */
#line 443 "src/parser.y"
                                            { (yyval.node) = mk2(N_DCL_ARRAY, (yylsp[-2]).first_line, (yylsp[-2]).first_column, (yyvsp[-2].node), 0); }
#line 2525 "build/parser.tab.cc"
    break;

  case 68: /* GroupDirect: GroupDirectOpt '[' CondExpr ']'  */
#line 444 "src/parser.y"
                                            { (yyval.node) = mk2(N_DCL_ARRAY, (yylsp[-3]).first_line, (yylsp[-3]).first_column, (yyvsp[-3].node), (yyvsp[-1].node)); }
#line 2531 "build/parser.tab.cc"
    break;

  case 69: /* GroupDirect: GroupDirect '(' ParamList ')'  */
#line 445 "src/parser.y"
                                            { (yyval.node) = mk2(N_DCL_FUNC, (yylsp[-3]).first_line, (yylsp[-3]).first_column, (yyvsp[-3].node), (yyvsp[-1].node)); }
#line 2537 "build/parser.tab.cc"
    break;

  case 70: /* GroupDirectOpt: %empty  */
#line 449 "src/parser.y"
                                            { (yyval.node) = mk(N_DCL_NAME, (yyloc).first_line, (yyloc).first_column);
                                              (yyval.node)->sval = ""; }
#line 2544 "build/parser.tab.cc"
    break;

  case 71: /* GroupDirectOpt: GroupDirect  */
#line 451 "src/parser.y"
                                            { (yyval.node) = (yyvsp[0].node); }
#line 2550 "build/parser.tab.cc"
    break;

  case 72: /* Pointers: %empty  */
#line 455 "src/parser.y"
                          { (yyval.ival) = 0; }
#line 2556 "build/parser.tab.cc"
    break;

  case 73: /* Pointers: PtrStars  */
#line 456 "src/parser.y"
                          { (yyval.ival) = (yyvsp[0].ival); }
#line 2562 "build/parser.tab.cc"
    break;

  case 74: /* PtrStars: MUL_OP  */
#line 465 "src/parser.y"
                          { (yyval.ival) = 1; }
#line 2568 "build/parser.tab.cc"
    break;

  case 75: /* PtrStars: PtrStars MUL_OP  */
#line 466 "src/parser.y"
                          { (yyval.ival) = (yyvsp[-1].ival) + 1; }
#line 2574 "build/parser.tab.cc"
    break;

  case 76: /* Initializer: AssignExpr  */
#line 470 "src/parser.y"
                                        { (yyval.node) = (yyvsp[0].node); }
#line 2580 "build/parser.tab.cc"
    break;

  case 77: /* Initializer: '{' '}'  */
#line 471 "src/parser.y"
                                        { (yyval.node) = mk(N_INIT_LIST, (yylsp[-1]).first_line, (yylsp[-1]).first_column); }
#line 2586 "build/parser.tab.cc"
    break;

  case 78: /* Initializer: '{' InitializerList '}'  */
#line 472 "src/parser.y"
                                        { (yyval.node) = (yyvsp[-1].node); (yyval.node)->kind = N_INIT_LIST; }
#line 2592 "build/parser.tab.cc"
    break;

  case 79: /* Initializer: '{' InitializerList ',' '}'  */
#line 473 "src/parser.y"
                                        { (yyval.node) = (yyvsp[-2].node); (yyval.node)->kind = N_INIT_LIST; }
#line 2598 "build/parser.tab.cc"
    break;

  case 80: /* InitializerList: Initializer  */
#line 477 "src/parser.y"
                                        { (yyval.node) = listNode((yylsp[0]).first_line, (yylsp[0]).first_column);
                                          appendTo((yyval.node), (yyvsp[0].node)); }
#line 2605 "build/parser.tab.cc"
    break;

  case 81: /* InitializerList: InitializerList ',' Initializer  */
#line 479 "src/parser.y"
                                        { (yyval.node) = appendTo((yyvsp[-2].node), (yyvsp[0].node)); }
#line 2611 "build/parser.tab.cc"
    break;

  case 82: /* FuncDef: DeclSpec Declarator CompoundStmt  */
#line 486 "src/parser.y"
        { (yyval.node) = mk3(N_FUNCDEF, (yylsp[-2]).first_line, (yylsp[-2]).first_column, (yyvsp[-2].node)->kid(0), (yyvsp[-1].node), (yyvsp[0].node));
          if ((yyvsp[-2].node)->ival)
              parseDiag((yylsp[-2]).first_line, (yylsp[-2]).first_column,
                        "'typedef' cannot be used on a function definition");
          in_typedef_decl = 0; }
#line 2621 "build/parser.tab.cc"
    break;

  case 83: /* ParamList: %empty  */
#line 494 "src/parser.y"
                          { (yyval.node) = listNode(yylloc.first_line, yylloc.first_column); }
#line 2627 "build/parser.tab.cc"
    break;

  case 84: /* ParamList: ParamDeclList  */
#line 495 "src/parser.y"
                          { (yyval.node) = (yyvsp[0].node); }
#line 2633 "build/parser.tab.cc"
    break;

  case 85: /* ParamDeclList: ParamDecl  */
#line 499 "src/parser.y"
                                      { (yyval.node) = listNode((yylsp[0]).first_line, (yylsp[0]).first_column);
                                        appendTo((yyval.node), (yyvsp[0].node)); }
#line 2640 "build/parser.tab.cc"
    break;

  case 86: /* ParamDeclList: ParamDeclList ',' ParamDecl  */
#line 501 "src/parser.y"
                                      { (yyval.node) = appendTo((yyvsp[-2].node), (yyvsp[0].node)); }
#line 2646 "build/parser.tab.cc"
    break;

  case 87: /* ParamDecl: DeclSpec AbstractDeclarator  */
#line 512 "src/parser.y"
        { Node* d = declNameNode((yyvsp[0].node));
          if (d && !d->sval.empty()) register_param_name(d->sval.c_str());
          (yyval.node) = mk2(N_PARAM, (yylsp[-1]).first_line, (yylsp[-1]).first_column, (yyvsp[-1].node)->kid(0), (yyvsp[0].node)); }
#line 2654 "build/parser.tab.cc"
    break;

  case 88: /* CompoundStmt: '{' '}'  */
#line 520 "src/parser.y"
                                 { (yyval.node) = mk(N_COMPOUND, (yylsp[-1]).first_line, (yylsp[-1]).first_column); }
#line 2660 "build/parser.tab.cc"
    break;

  case 89: /* CompoundStmt: '{' BlockItemList '}'  */
#line 521 "src/parser.y"
                                 { (yyval.node) = (yyvsp[-1].node); (yyval.node)->kind = N_COMPOUND; }
#line 2666 "build/parser.tab.cc"
    break;

  case 90: /* CompoundStmt: '{' error '}'  */
#line 522 "src/parser.y"
                                 { yyerrok; (yyval.node) = mk(N_COMPOUND, (yylsp[-2]).first_line, (yylsp[-2]).first_column); }
#line 2672 "build/parser.tab.cc"
    break;

  case 91: /* BlockItemList: BlockItem  */
#line 526 "src/parser.y"
                                 { (yyval.node) = listNode((yylsp[0]).first_line, (yylsp[0]).first_column);
                                   if ((yyvsp[0].node)) appendTo((yyval.node), (yyvsp[0].node)); }
#line 2679 "build/parser.tab.cc"
    break;

  case 92: /* BlockItemList: BlockItemList BlockItem  */
#line 528 "src/parser.y"
                                 { (yyval.node) = (yyvsp[-1].node); if ((yyvsp[0].node)) appendTo((yyval.node), (yyvsp[0].node)); }
#line 2685 "build/parser.tab.cc"
    break;

  case 93: /* BlockItem: Decl  */
#line 532 "src/parser.y"
                  { (yyval.node) = (yyvsp[0].node); }
#line 2691 "build/parser.tab.cc"
    break;

  case 94: /* BlockItem: Stmt  */
#line 533 "src/parser.y"
                  { (yyval.node) = (yyvsp[0].node); }
#line 2697 "build/parser.tab.cc"
    break;

  case 95: /* BlockItem: error ';'  */
#line 534 "src/parser.y"
                  { yyerrok; (yyval.node) = 0; }
#line 2703 "build/parser.tab.cc"
    break;

  case 96: /* Stmt: CompoundStmt  */
#line 538 "src/parser.y"
                     { (yyval.node) = (yyvsp[0].node); }
#line 2709 "build/parser.tab.cc"
    break;

  case 97: /* Stmt: ExprStmt  */
#line 539 "src/parser.y"
                     { (yyval.node) = (yyvsp[0].node); }
#line 2715 "build/parser.tab.cc"
    break;

  case 98: /* Stmt: SelectionStmt  */
#line 540 "src/parser.y"
                     { (yyval.node) = (yyvsp[0].node); }
#line 2721 "build/parser.tab.cc"
    break;

  case 99: /* Stmt: IterStmt  */
#line 541 "src/parser.y"
                     { (yyval.node) = (yyvsp[0].node); }
#line 2727 "build/parser.tab.cc"
    break;

  case 100: /* Stmt: JumpStmt  */
#line 542 "src/parser.y"
                     { (yyval.node) = (yyvsp[0].node); }
#line 2733 "build/parser.tab.cc"
    break;

  case 101: /* Stmt: LabeledStmt  */
#line 543 "src/parser.y"
                     { (yyval.node) = (yyvsp[0].node); }
#line 2739 "build/parser.tab.cc"
    break;

  case 102: /* ExprStmt: ';'  */
#line 547 "src/parser.y"
                     { (yyval.node) = mk(N_EXPRSTMT, (yylsp[0]).first_line, (yylsp[0]).first_column);
                       (yyval.node)->kids.push_back(0); }
#line 2746 "build/parser.tab.cc"
    break;

  case 103: /* ExprStmt: Expr ';'  */
#line 549 "src/parser.y"
                     { (yyval.node) = mk1(N_EXPRSTMT, (yylsp[-1]).first_line, (yylsp[-1]).first_column, (yyvsp[-1].node)); }
#line 2752 "build/parser.tab.cc"
    break;

  case 104: /* SelectionStmt: IF '(' Expr ')' Stmt  */
#line 554 "src/parser.y"
        { (yyval.node) = mk3(N_IF, (yylsp[-4]).first_line, (yylsp[-4]).first_column, (yyvsp[-2].node), (yyvsp[0].node), 0); }
#line 2758 "build/parser.tab.cc"
    break;

  case 105: /* SelectionStmt: IF '(' Expr ')' Stmt ELSE Stmt  */
#line 556 "src/parser.y"
        { (yyval.node) = mk3(N_IF, (yylsp[-6]).first_line, (yylsp[-6]).first_column, (yyvsp[-4].node), (yyvsp[-2].node), (yyvsp[0].node)); }
#line 2764 "build/parser.tab.cc"
    break;

  case 106: /* SelectionStmt: SWITCH '(' Expr ')' Stmt  */
#line 558 "src/parser.y"
        { (yyval.node) = mk2(N_SWITCH, (yylsp[-4]).first_line, (yylsp[-4]).first_column, (yyvsp[-2].node), (yyvsp[0].node)); }
#line 2770 "build/parser.tab.cc"
    break;

  case 107: /* SelectionStmt: IF '(' error ')' Stmt  */
#line 559 "src/parser.y"
                                                   { yyerrok; (yyval.node) = 0; }
#line 2776 "build/parser.tab.cc"
    break;

  case 108: /* SelectionStmt: SWITCH '(' error ')' Stmt  */
#line 560 "src/parser.y"
                                                   { yyerrok; (yyval.node) = 0; }
#line 2782 "build/parser.tab.cc"
    break;

  case 109: /* SelectionStmt: IF '(' error ';'  */
#line 561 "src/parser.y"
                                                   { yyerrok; (yyval.node) = 0; }
#line 2788 "build/parser.tab.cc"
    break;

  case 110: /* SelectionStmt: SWITCH '(' error ';'  */
#line 562 "src/parser.y"
                                                   { yyerrok; (yyval.node) = 0; }
#line 2794 "build/parser.tab.cc"
    break;

  case 111: /* SelectionStmt: IF '(' error CompoundStmt  */
#line 563 "src/parser.y"
                                                       { yyerrok; (yyval.node) = 0; }
#line 2800 "build/parser.tab.cc"
    break;

  case 112: /* SelectionStmt: SWITCH '(' error CompoundStmt  */
#line 564 "src/parser.y"
                                                       { yyerrok; (yyval.node) = 0; }
#line 2806 "build/parser.tab.cc"
    break;

  case 113: /* IterStmt: WHILE '(' Expr ')' Stmt  */
#line 570 "src/parser.y"
        { (yyval.node) = mk2(N_WHILE, (yylsp[-4]).first_line, (yylsp[-4]).first_column, (yyvsp[-2].node), (yyvsp[0].node)); }
#line 2812 "build/parser.tab.cc"
    break;

  case 114: /* IterStmt: DO Stmt WHILE '(' Expr ')' ';'  */
#line 572 "src/parser.y"
        { (yyval.node) = mk2(N_DO, (yylsp[-6]).first_line, (yylsp[-6]).first_column, (yyvsp[-5].node), (yyvsp[-2].node)); }
#line 2818 "build/parser.tab.cc"
    break;

  case 115: /* IterStmt: UNTIL '(' Expr ')' Stmt  */
#line 574 "src/parser.y"
        { (yyval.node) = mk2(N_UNTIL, (yylsp[-4]).first_line, (yylsp[-4]).first_column, (yyvsp[-2].node), (yyvsp[0].node)); }
#line 2824 "build/parser.tab.cc"
    break;

  case 116: /* IterStmt: FOR '(' ForInit ExprStmt ')' Stmt  */
#line 576 "src/parser.y"
        { (yyval.node) = mk(N_FOR, (yylsp[-5]).first_line, (yylsp[-5]).first_column);
          (yyval.node)->kids.push_back((yyvsp[-3].node)); (yyval.node)->kids.push_back((yyvsp[-2].node) ? (yyvsp[-2].node)->kid(0) : 0);
          (yyval.node)->kids.push_back(0);  (yyval.node)->kids.push_back((yyvsp[0].node)); }
#line 2832 "build/parser.tab.cc"
    break;

  case 117: /* IterStmt: FOR '(' ForInit ExprStmt Expr ')' Stmt  */
#line 580 "src/parser.y"
        { (yyval.node) = mk(N_FOR, (yylsp[-6]).first_line, (yylsp[-6]).first_column);
          (yyval.node)->kids.push_back((yyvsp[-4].node)); (yyval.node)->kids.push_back((yyvsp[-3].node) ? (yyvsp[-3].node)->kid(0) : 0);
          (yyval.node)->kids.push_back((yyvsp[-2].node)); (yyval.node)->kids.push_back((yyvsp[0].node)); }
#line 2840 "build/parser.tab.cc"
    break;

  case 118: /* IterStmt: WHILE '(' error ')' Stmt  */
#line 583 "src/parser.y"
                                    { yyerrok; (yyval.node) = 0; }
#line 2846 "build/parser.tab.cc"
    break;

  case 119: /* IterStmt: UNTIL '(' error ')' Stmt  */
#line 584 "src/parser.y"
                                    { yyerrok; (yyval.node) = 0; }
#line 2852 "build/parser.tab.cc"
    break;

  case 120: /* IterStmt: FOR '(' error ')' Stmt  */
#line 585 "src/parser.y"
                                    { yyerrok; (yyval.node) = 0; }
#line 2858 "build/parser.tab.cc"
    break;

  case 121: /* IterStmt: WHILE '(' error ';'  */
#line 586 "src/parser.y"
                                    { yyerrok; (yyval.node) = 0; }
#line 2864 "build/parser.tab.cc"
    break;

  case 122: /* IterStmt: UNTIL '(' error ';'  */
#line 587 "src/parser.y"
                                    { yyerrok; (yyval.node) = 0; }
#line 2870 "build/parser.tab.cc"
    break;

  case 123: /* IterStmt: WHILE '(' error CompoundStmt  */
#line 588 "src/parser.y"
                                    { yyerrok; (yyval.node) = 0; }
#line 2876 "build/parser.tab.cc"
    break;

  case 124: /* IterStmt: UNTIL '(' error CompoundStmt  */
#line 589 "src/parser.y"
                                    { yyerrok; (yyval.node) = 0; }
#line 2882 "build/parser.tab.cc"
    break;

  case 125: /* IterStmt: FOR '(' error CompoundStmt  */
#line 590 "src/parser.y"
                                    { yyerrok; (yyval.node) = 0; }
#line 2888 "build/parser.tab.cc"
    break;

  case 126: /* ForInit: ExprStmt  */
#line 594 "src/parser.y"
                 { (yyval.node) = (yyvsp[0].node); }
#line 2894 "build/parser.tab.cc"
    break;

  case 127: /* ForInit: Decl  */
#line 595 "src/parser.y"
                 { (yyval.node) = (yyvsp[0].node); }
#line 2900 "build/parser.tab.cc"
    break;

  case 128: /* LabeledStmt: IDENTIFIER ':' Stmt  */
#line 599 "src/parser.y"
                               { (yyval.node) = mk1(N_LABEL, (yylsp[-2]).first_line, (yylsp[-2]).first_column, (yyvsp[0].node));
                                 (yyval.node)->sval = (yyvsp[-2].str); }
#line 2907 "build/parser.tab.cc"
    break;

  case 129: /* LabeledStmt: TYPE_NAME ':' Stmt  */
#line 604 "src/parser.y"
                               { (yyval.node) = mk1(N_LABEL, (yylsp[-2]).first_line, (yylsp[-2]).first_column, (yyvsp[0].node));
                                 (yyval.node)->sval = (yyvsp[-2].str); }
#line 2914 "build/parser.tab.cc"
    break;

  case 130: /* LabeledStmt: CASE CondExpr ':' Stmt  */
#line 606 "src/parser.y"
                               { (yyval.node) = mk2(N_CASE, (yylsp[-3]).first_line, (yylsp[-3]).first_column, (yyvsp[-2].node), (yyvsp[0].node)); }
#line 2920 "build/parser.tab.cc"
    break;

  case 131: /* LabeledStmt: DEFAULT ':' Stmt  */
#line 607 "src/parser.y"
                               { (yyval.node) = mk1(N_DEFAULT, (yylsp[-2]).first_line, (yylsp[-2]).first_column, (yyvsp[0].node)); }
#line 2926 "build/parser.tab.cc"
    break;

  case 132: /* LabeledStmt: CASE error ':' Stmt  */
#line 608 "src/parser.y"
                               { yyerrok; (yyval.node) = 0; }
#line 2932 "build/parser.tab.cc"
    break;

  case 133: /* JumpStmt: GOTO IDENTIFIER ';'  */
#line 612 "src/parser.y"
                            { (yyval.node) = mk(N_GOTO, (yylsp[-2]).first_line, (yylsp[-2]).first_column); (yyval.node)->sval = (yyvsp[-1].str); }
#line 2938 "build/parser.tab.cc"
    break;

  case 134: /* JumpStmt: GOTO TYPE_NAME ';'  */
#line 613 "src/parser.y"
                            { (yyval.node) = mk(N_GOTO, (yylsp[-2]).first_line, (yylsp[-2]).first_column); (yyval.node)->sval = (yyvsp[-1].str); }
#line 2944 "build/parser.tab.cc"
    break;

  case 135: /* JumpStmt: CONTINUE ';'  */
#line 614 "src/parser.y"
                            { (yyval.node) = mk(N_CONTINUE, (yylsp[-1]).first_line, (yylsp[-1]).first_column); }
#line 2950 "build/parser.tab.cc"
    break;

  case 136: /* JumpStmt: BREAK ';'  */
#line 615 "src/parser.y"
                            { (yyval.node) = mk(N_BREAK, (yylsp[-1]).first_line, (yylsp[-1]).first_column); }
#line 2956 "build/parser.tab.cc"
    break;

  case 137: /* JumpStmt: RETURN ';'  */
#line 616 "src/parser.y"
                            { (yyval.node) = mk(N_RETURN, (yylsp[-1]).first_line, (yylsp[-1]).first_column);
                              (yyval.node)->kids.push_back(0); }
#line 2963 "build/parser.tab.cc"
    break;

  case 138: /* JumpStmt: RETURN Expr ';'  */
#line 618 "src/parser.y"
                            { (yyval.node) = mk1(N_RETURN, (yylsp[-2]).first_line, (yylsp[-2]).first_column, (yyvsp[-1].node)); }
#line 2969 "build/parser.tab.cc"
    break;

  case 139: /* Expr: AssignExpr  */
#line 624 "src/parser.y"
                             { (yyval.node) = (yyvsp[0].node); }
#line 2975 "build/parser.tab.cc"
    break;

  case 140: /* Expr: Expr ',' AssignExpr  */
#line 625 "src/parser.y"
                             { (yyval.node) = mk2(N_COMMA, (yylsp[-1]).first_line, (yylsp[-1]).first_column, (yyvsp[-2].node), (yyvsp[0].node)); }
#line 2981 "build/parser.tab.cc"
    break;

  case 141: /* AssignExpr: CondExpr  */
#line 629 "src/parser.y"
                                         { (yyval.node) = (yyvsp[0].node); }
#line 2987 "build/parser.tab.cc"
    break;

  case 142: /* AssignExpr: CondExpr AssignOp AssignExpr  */
#line 633 "src/parser.y"
                                         { (yyval.node) = mk2(N_ASSIGN, (yylsp[-1]).first_line, (yylsp[-1]).first_column, (yyvsp[-2].node), (yyvsp[0].node));
                                           (yyval.node)->sval = (yyvsp[-1].str); }
#line 2994 "build/parser.tab.cc"
    break;

  case 143: /* AssignOp: ASSIGN  */
#line 638 "src/parser.y"
                    { (yyval.str) = "=";   }
#line 3000 "build/parser.tab.cc"
    break;

  case 144: /* AssignOp: ADD_ASSIGN  */
#line 639 "src/parser.y"
                    { (yyval.str) = "+=";  }
#line 3006 "build/parser.tab.cc"
    break;

  case 145: /* AssignOp: SUB_ASSIGN  */
#line 640 "src/parser.y"
                    { (yyval.str) = "-=";  }
#line 3012 "build/parser.tab.cc"
    break;

  case 146: /* AssignOp: MUL_ASSIGN  */
#line 641 "src/parser.y"
                    { (yyval.str) = "*=";  }
#line 3018 "build/parser.tab.cc"
    break;

  case 147: /* AssignOp: DIV_ASSIGN  */
#line 642 "src/parser.y"
                    { (yyval.str) = "/=";  }
#line 3024 "build/parser.tab.cc"
    break;

  case 148: /* AssignOp: MOD_ASSIGN  */
#line 643 "src/parser.y"
                    { (yyval.str) = "%=";  }
#line 3030 "build/parser.tab.cc"
    break;

  case 149: /* AssignOp: AND_ASSIGN  */
#line 644 "src/parser.y"
                    { (yyval.str) = "&=";  }
#line 3036 "build/parser.tab.cc"
    break;

  case 150: /* AssignOp: OR_ASSIGN  */
#line 645 "src/parser.y"
                    { (yyval.str) = "|=";  }
#line 3042 "build/parser.tab.cc"
    break;

  case 151: /* AssignOp: XOR_ASSIGN  */
#line 646 "src/parser.y"
                    { (yyval.str) = "^=";  }
#line 3048 "build/parser.tab.cc"
    break;

  case 152: /* AssignOp: LEFT_ASSIGN  */
#line 647 "src/parser.y"
                    { (yyval.str) = "<<="; }
#line 3054 "build/parser.tab.cc"
    break;

  case 153: /* AssignOp: RIGHT_ASSIGN  */
#line 648 "src/parser.y"
                    { (yyval.str) = ">>="; }
#line 3060 "build/parser.tab.cc"
    break;

  case 154: /* CondExpr: LogOrExpr  */
#line 652 "src/parser.y"
                                            { (yyval.node) = (yyvsp[0].node); }
#line 3066 "build/parser.tab.cc"
    break;

  case 155: /* CondExpr: LogOrExpr '?' Expr ':' CondExpr  */
#line 653 "src/parser.y"
                                            { (yyval.node) = mk3(N_COND, (yylsp[-3]).first_line, (yylsp[-3]).first_column,
                                                       (yyvsp[-4].node), (yyvsp[-2].node), (yyvsp[0].node)); }
#line 3073 "build/parser.tab.cc"
    break;

  case 156: /* LogOrExpr: LogAndExpr  */
#line 658 "src/parser.y"
                                     { (yyval.node) = (yyvsp[0].node); }
#line 3079 "build/parser.tab.cc"
    break;

  case 157: /* LogOrExpr: LogOrExpr LOG_OR LogAndExpr  */
#line 659 "src/parser.y"
                                     { (yyval.node) = mk2(N_BINOP, (yylsp[-1]).first_line, (yylsp[-1]).first_column, (yyvsp[-2].node), (yyvsp[0].node));
                                       (yyval.node)->sval = "||"; }
#line 3086 "build/parser.tab.cc"
    break;

  case 158: /* LogAndExpr: BitOrExpr  */
#line 664 "src/parser.y"
                                     { (yyval.node) = (yyvsp[0].node); }
#line 3092 "build/parser.tab.cc"
    break;

  case 159: /* LogAndExpr: LogAndExpr LOG_AND BitOrExpr  */
#line 665 "src/parser.y"
                                     { (yyval.node) = mk2(N_BINOP, (yylsp[-1]).first_line, (yylsp[-1]).first_column, (yyvsp[-2].node), (yyvsp[0].node));
                                       (yyval.node)->sval = "&&"; }
#line 3099 "build/parser.tab.cc"
    break;

  case 160: /* BitOrExpr: BitXorExpr  */
#line 670 "src/parser.y"
                                     { (yyval.node) = (yyvsp[0].node); }
#line 3105 "build/parser.tab.cc"
    break;

  case 161: /* BitOrExpr: BitOrExpr BIT_OR BitXorExpr  */
#line 671 "src/parser.y"
                                     { (yyval.node) = mk2(N_BINOP, (yylsp[-1]).first_line, (yylsp[-1]).first_column, (yyvsp[-2].node), (yyvsp[0].node));
                                       (yyval.node)->sval = "|"; }
#line 3112 "build/parser.tab.cc"
    break;

  case 162: /* BitXorExpr: BitAndExpr  */
#line 676 "src/parser.y"
                                     { (yyval.node) = (yyvsp[0].node); }
#line 3118 "build/parser.tab.cc"
    break;

  case 163: /* BitXorExpr: BitXorExpr BIT_XOR BitAndExpr  */
#line 677 "src/parser.y"
                                     { (yyval.node) = mk2(N_BINOP, (yylsp[-1]).first_line, (yylsp[-1]).first_column, (yyvsp[-2].node), (yyvsp[0].node));
                                       (yyval.node)->sval = "^"; }
#line 3125 "build/parser.tab.cc"
    break;

  case 164: /* BitAndExpr: EqExpr  */
#line 682 "src/parser.y"
                                     { (yyval.node) = (yyvsp[0].node); }
#line 3131 "build/parser.tab.cc"
    break;

  case 165: /* BitAndExpr: BitAndExpr BIT_AND EqExpr  */
#line 683 "src/parser.y"
                                     { (yyval.node) = mk2(N_BINOP, (yylsp[-1]).first_line, (yylsp[-1]).first_column, (yyvsp[-2].node), (yyvsp[0].node));
                                       (yyval.node)->sval = "&"; }
#line 3138 "build/parser.tab.cc"
    break;

  case 166: /* EqExpr: RelExpr  */
#line 688 "src/parser.y"
                                     { (yyval.node) = (yyvsp[0].node); }
#line 3144 "build/parser.tab.cc"
    break;

  case 167: /* EqExpr: EqExpr EQ_OP RelExpr  */
#line 689 "src/parser.y"
                                     { (yyval.node) = mk2(N_BINOP, (yylsp[-1]).first_line, (yylsp[-1]).first_column, (yyvsp[-2].node), (yyvsp[0].node));
                                       (yyval.node)->sval = "=="; }
#line 3151 "build/parser.tab.cc"
    break;

  case 168: /* EqExpr: EqExpr NE_OP RelExpr  */
#line 691 "src/parser.y"
                                     { (yyval.node) = mk2(N_BINOP, (yylsp[-1]).first_line, (yylsp[-1]).first_column, (yyvsp[-2].node), (yyvsp[0].node));
                                       (yyval.node)->sval = "!="; }
#line 3158 "build/parser.tab.cc"
    break;

  case 169: /* RelExpr: ShiftExpr  */
#line 696 "src/parser.y"
                                     { (yyval.node) = (yyvsp[0].node); }
#line 3164 "build/parser.tab.cc"
    break;

  case 170: /* RelExpr: RelExpr LT_OP ShiftExpr  */
#line 697 "src/parser.y"
                                     { (yyval.node) = mk2(N_BINOP, (yylsp[-1]).first_line, (yylsp[-1]).first_column, (yyvsp[-2].node), (yyvsp[0].node));
                                       (yyval.node)->sval = "<"; }
#line 3171 "build/parser.tab.cc"
    break;

  case 171: /* RelExpr: RelExpr GT_OP ShiftExpr  */
#line 699 "src/parser.y"
                                     { (yyval.node) = mk2(N_BINOP, (yylsp[-1]).first_line, (yylsp[-1]).first_column, (yyvsp[-2].node), (yyvsp[0].node));
                                       (yyval.node)->sval = ">"; }
#line 3178 "build/parser.tab.cc"
    break;

  case 172: /* RelExpr: RelExpr LE_OP ShiftExpr  */
#line 701 "src/parser.y"
                                     { (yyval.node) = mk2(N_BINOP, (yylsp[-1]).first_line, (yylsp[-1]).first_column, (yyvsp[-2].node), (yyvsp[0].node));
                                       (yyval.node)->sval = "<="; }
#line 3185 "build/parser.tab.cc"
    break;

  case 173: /* RelExpr: RelExpr GE_OP ShiftExpr  */
#line 703 "src/parser.y"
                                     { (yyval.node) = mk2(N_BINOP, (yylsp[-1]).first_line, (yylsp[-1]).first_column, (yyvsp[-2].node), (yyvsp[0].node));
                                       (yyval.node)->sval = ">="; }
#line 3192 "build/parser.tab.cc"
    break;

  case 174: /* ShiftExpr: AddExpr  */
#line 708 "src/parser.y"
                                     { (yyval.node) = (yyvsp[0].node); }
#line 3198 "build/parser.tab.cc"
    break;

  case 175: /* ShiftExpr: ShiftExpr LEFT_OP AddExpr  */
#line 709 "src/parser.y"
                                     { (yyval.node) = mk2(N_BINOP, (yylsp[-1]).first_line, (yylsp[-1]).first_column, (yyvsp[-2].node), (yyvsp[0].node));
                                       (yyval.node)->sval = "<<"; }
#line 3205 "build/parser.tab.cc"
    break;

  case 176: /* ShiftExpr: ShiftExpr RIGHT_OP AddExpr  */
#line 711 "src/parser.y"
                                     { (yyval.node) = mk2(N_BINOP, (yylsp[-1]).first_line, (yylsp[-1]).first_column, (yyvsp[-2].node), (yyvsp[0].node));
                                       (yyval.node)->sval = ">>"; }
#line 3212 "build/parser.tab.cc"
    break;

  case 177: /* AddExpr: MulExpr  */
#line 716 "src/parser.y"
                                     { (yyval.node) = (yyvsp[0].node); }
#line 3218 "build/parser.tab.cc"
    break;

  case 178: /* AddExpr: AddExpr ADD_OP MulExpr  */
#line 717 "src/parser.y"
                                     { (yyval.node) = mk2(N_BINOP, (yylsp[-1]).first_line, (yylsp[-1]).first_column, (yyvsp[-2].node), (yyvsp[0].node));
                                       (yyval.node)->sval = "+"; }
#line 3225 "build/parser.tab.cc"
    break;

  case 179: /* AddExpr: AddExpr SUB_OP MulExpr  */
#line 719 "src/parser.y"
                                     { (yyval.node) = mk2(N_BINOP, (yylsp[-1]).first_line, (yylsp[-1]).first_column, (yyvsp[-2].node), (yyvsp[0].node));
                                       (yyval.node)->sval = "-"; }
#line 3232 "build/parser.tab.cc"
    break;

  case 180: /* MulExpr: CastExpr  */
#line 724 "src/parser.y"
                                     { (yyval.node) = (yyvsp[0].node); }
#line 3238 "build/parser.tab.cc"
    break;

  case 181: /* MulExpr: MulExpr MUL_OP CastExpr  */
#line 725 "src/parser.y"
                                     { (yyval.node) = mk2(N_BINOP, (yylsp[-1]).first_line, (yylsp[-1]).first_column, (yyvsp[-2].node), (yyvsp[0].node));
                                       (yyval.node)->sval = "*"; }
#line 3245 "build/parser.tab.cc"
    break;

  case 182: /* MulExpr: MulExpr DIV_OP CastExpr  */
#line 727 "src/parser.y"
                                     { (yyval.node) = mk2(N_BINOP, (yylsp[-1]).first_line, (yylsp[-1]).first_column, (yyvsp[-2].node), (yyvsp[0].node));
                                       (yyval.node)->sval = "/"; }
#line 3252 "build/parser.tab.cc"
    break;

  case 183: /* MulExpr: MulExpr MOD_OP CastExpr  */
#line 729 "src/parser.y"
                                     { (yyval.node) = mk2(N_BINOP, (yylsp[-1]).first_line, (yylsp[-1]).first_column, (yyvsp[-2].node), (yyvsp[0].node));
                                       (yyval.node)->sval = "%"; }
#line 3259 "build/parser.tab.cc"
    break;

  case 184: /* CastExpr: UnaryExpr  */
#line 734 "src/parser.y"
                                     { (yyval.node) = (yyvsp[0].node); }
#line 3265 "build/parser.tab.cc"
    break;

  case 185: /* CastExpr: '(' TypeName ')' CastExpr  */
#line 735 "src/parser.y"
                                     { (yyval.node) = mk2(N_CAST, (yylsp[-3]).first_line, (yylsp[-3]).first_column, (yyvsp[-2].node), (yyvsp[0].node)); }
#line 3271 "build/parser.tab.cc"
    break;

  case 186: /* UnaryExpr: PostfixExpr  */
#line 739 "src/parser.y"
                             { (yyval.node) = (yyvsp[0].node); }
#line 3277 "build/parser.tab.cc"
    break;

  case 187: /* UnaryExpr: INC_OP UnaryExpr  */
#line 740 "src/parser.y"
                             { (yyval.node) = mk1(N_PREINC, (yylsp[-1]).first_line, (yylsp[-1]).first_column, (yyvsp[0].node)); }
#line 3283 "build/parser.tab.cc"
    break;

  case 188: /* UnaryExpr: DEC_OP UnaryExpr  */
#line 741 "src/parser.y"
                             { (yyval.node) = mk1(N_PREDEC, (yylsp[-1]).first_line, (yylsp[-1]).first_column, (yyvsp[0].node)); }
#line 3289 "build/parser.tab.cc"
    break;

  case 189: /* UnaryExpr: ADD_OP CastExpr  */
#line 742 "src/parser.y"
                             { (yyval.node) = mk1(N_UNOP, (yylsp[-1]).first_line, (yylsp[-1]).first_column, (yyvsp[0].node)); (yyval.node)->sval = "+"; }
#line 3295 "build/parser.tab.cc"
    break;

  case 190: /* UnaryExpr: SUB_OP CastExpr  */
#line 743 "src/parser.y"
                             { (yyval.node) = mk1(N_UNOP, (yylsp[-1]).first_line, (yylsp[-1]).first_column, (yyvsp[0].node)); (yyval.node)->sval = "-"; }
#line 3301 "build/parser.tab.cc"
    break;

  case 191: /* UnaryExpr: LOG_NOT CastExpr  */
#line 744 "src/parser.y"
                             { (yyval.node) = mk1(N_UNOP, (yylsp[-1]).first_line, (yylsp[-1]).first_column, (yyvsp[0].node)); (yyval.node)->sval = "!"; }
#line 3307 "build/parser.tab.cc"
    break;

  case 192: /* UnaryExpr: BIT_NOT CastExpr  */
#line 745 "src/parser.y"
                             { (yyval.node) = mk1(N_UNOP, (yylsp[-1]).first_line, (yylsp[-1]).first_column, (yyvsp[0].node)); (yyval.node)->sval = "~"; }
#line 3313 "build/parser.tab.cc"
    break;

  case 193: /* UnaryExpr: BIT_AND CastExpr  */
#line 746 "src/parser.y"
                             { (yyval.node) = mk1(N_ADDR,  (yylsp[-1]).first_line, (yylsp[-1]).first_column, (yyvsp[0].node)); }
#line 3319 "build/parser.tab.cc"
    break;

  case 194: /* UnaryExpr: MUL_OP CastExpr  */
#line 747 "src/parser.y"
                             { (yyval.node) = mk1(N_DEREF, (yylsp[-1]).first_line, (yylsp[-1]).first_column, (yyvsp[0].node)); }
#line 3325 "build/parser.tab.cc"
    break;

  case 195: /* UnaryExpr: SIZEOF UnaryExpr  */
#line 748 "src/parser.y"
                             { (yyval.node) = mk1(N_SIZEOF_EXPR, (yylsp[-1]).first_line, (yylsp[-1]).first_column, (yyvsp[0].node)); }
#line 3331 "build/parser.tab.cc"
    break;

  case 196: /* UnaryExpr: SIZEOF '(' TypeName ')'  */
#line 749 "src/parser.y"
                             { (yyval.node) = mk1(N_SIZEOF_TYPE, (yylsp[-3]).first_line, (yylsp[-3]).first_column, (yyvsp[-1].node)); }
#line 3337 "build/parser.tab.cc"
    break;

  case 197: /* PostfixExpr: PrimaryExpr  */
#line 753 "src/parser.y"
                                        { (yyval.node) = (yyvsp[0].node); }
#line 3343 "build/parser.tab.cc"
    break;

  case 198: /* PostfixExpr: PostfixExpr '[' Expr ']'  */
#line 754 "src/parser.y"
                                        { (yyval.node) = mk2(N_INDEX, (yylsp[-2]).first_line, (yylsp[-2]).first_column, (yyvsp[-3].node), (yyvsp[-1].node)); }
#line 3349 "build/parser.tab.cc"
    break;

  case 199: /* PostfixExpr: PostfixExpr '(' ')'  */
#line 755 "src/parser.y"
                                        { (yyval.node) = mk2(N_CALL, (yylsp[-2]).first_line, (yylsp[-2]).first_column, (yyvsp[-2].node), 0); }
#line 3355 "build/parser.tab.cc"
    break;

  case 200: /* PostfixExpr: PostfixExpr '(' ArgList ')'  */
#line 756 "src/parser.y"
                                        { (yyval.node) = mk2(N_CALL, (yylsp[-3]).first_line, (yylsp[-3]).first_column, (yyvsp[-3].node), (yyvsp[-1].node)); }
#line 3361 "build/parser.tab.cc"
    break;

  case 201: /* PostfixExpr: PostfixExpr '(' error ')'  */
#line 757 "src/parser.y"
                                        { yyerrok; (yyval.node) = mk2(N_CALL, (yylsp[-3]).first_line, (yylsp[-3]).first_column, (yyvsp[-3].node), 0); }
#line 3367 "build/parser.tab.cc"
    break;

  case 202: /* PostfixExpr: PostfixExpr DOT IDENTIFIER  */
#line 758 "src/parser.y"
                                        { (yyval.node) = mk1(N_MEMBER, (yylsp[-1]).first_line, (yylsp[-1]).first_column, (yyvsp[-2].node));
                                          (yyval.node)->sval = (yyvsp[0].str); }
#line 3374 "build/parser.tab.cc"
    break;

  case 203: /* PostfixExpr: PostfixExpr ARROW IDENTIFIER  */
#line 760 "src/parser.y"
                                        { (yyval.node) = mk1(N_ARROW, (yylsp[-1]).first_line, (yylsp[-1]).first_column, (yyvsp[-2].node));
                                          (yyval.node)->sval = (yyvsp[0].str); }
#line 3381 "build/parser.tab.cc"
    break;

  case 204: /* PostfixExpr: PostfixExpr DOT TYPE_NAME  */
#line 766 "src/parser.y"
                                        { (yyval.node) = mk1(N_MEMBER, (yylsp[-1]).first_line, (yylsp[-1]).first_column, (yyvsp[-2].node));
                                          (yyval.node)->sval = (yyvsp[0].str); }
#line 3388 "build/parser.tab.cc"
    break;

  case 205: /* PostfixExpr: PostfixExpr ARROW TYPE_NAME  */
#line 768 "src/parser.y"
                                        { (yyval.node) = mk1(N_ARROW, (yylsp[-1]).first_line, (yylsp[-1]).first_column, (yyvsp[-2].node));
                                          (yyval.node)->sval = (yyvsp[0].str); }
#line 3395 "build/parser.tab.cc"
    break;

  case 206: /* PostfixExpr: PostfixExpr INC_OP  */
#line 770 "src/parser.y"
                                        { (yyval.node) = mk1(N_POSTINC, (yylsp[0]).first_line, (yylsp[0]).first_column, (yyvsp[-1].node)); }
#line 3401 "build/parser.tab.cc"
    break;

  case 207: /* PostfixExpr: PostfixExpr DEC_OP  */
#line 771 "src/parser.y"
                                        { (yyval.node) = mk1(N_POSTDEC, (yylsp[0]).first_line, (yylsp[0]).first_column, (yyvsp[-1].node)); }
#line 3407 "build/parser.tab.cc"
    break;

  case 208: /* PrimaryExpr: IDENTIFIER  */
#line 775 "src/parser.y"
                   { (yyval.node) = mk(N_ID, (yylsp[0]).first_line, (yylsp[0]).first_column); (yyval.node)->sval = (yyvsp[0].str); }
#line 3413 "build/parser.tab.cc"
    break;

  case 209: /* PrimaryExpr: ICONST  */
#line 776 "src/parser.y"
                   { (yyval.node) = mk(N_ICONST, (yylsp[0]).first_line, (yylsp[0]).first_column);
                     (yyval.node)->ival = parseIntLiteral((yyvsp[0].str)); }
#line 3420 "build/parser.tab.cc"
    break;

  case 210: /* PrimaryExpr: FCONST  */
#line 778 "src/parser.y"
                   { (yyval.node) = mk(N_FCONST, (yylsp[0]).first_line, (yylsp[0]).first_column); (yyval.node)->sval = (yyvsp[0].str); }
#line 3426 "build/parser.tab.cc"
    break;

  case 211: /* PrimaryExpr: CCONST  */
#line 779 "src/parser.y"
                   { (yyval.node) = mk(N_CCONST, (yylsp[0]).first_line, (yylsp[0]).first_column);
                     long long v = 0;
                     if (!decodeCharLiteral((yyvsp[0].str), &v))
                         parseDiag((yylsp[0]).first_line, (yylsp[0]).first_column,
                                   std::string("invalid character constant ") + (yyvsp[0].str));
                     (yyval.node)->ival = v; }
#line 3437 "build/parser.tab.cc"
    break;

  case 212: /* PrimaryExpr: SCONST  */
#line 785 "src/parser.y"
                   { (yyval.node) = mk(N_SCONST, (yylsp[0]).first_line, (yylsp[0]).first_column);
                     std::string bytes;
                     if (!decodeStringLiteral((yyvsp[0].str), &bytes))
                         parseDiag((yylsp[0]).first_line, (yylsp[0]).first_column,
                                   std::string("invalid string literal ") + (yyvsp[0].str));
                     (yyval.node)->sval = bytes; }
#line 3448 "build/parser.tab.cc"
    break;

  case 213: /* PrimaryExpr: '(' Expr ')'  */
#line 791 "src/parser.y"
                   { (yyval.node) = (yyvsp[-1].node); }
#line 3454 "build/parser.tab.cc"
    break;

  case 214: /* ArgList: AssignExpr  */
#line 795 "src/parser.y"
                                { (yyval.node) = listNode((yylsp[0]).first_line, (yylsp[0]).first_column);
                                  appendTo((yyval.node), (yyvsp[0].node)); }
#line 3461 "build/parser.tab.cc"
    break;

  case 215: /* ArgList: ArgList ',' AssignExpr  */
#line 797 "src/parser.y"
                                { (yyval.node) = appendTo((yyvsp[-2].node), (yyvsp[0].node)); }
#line 3467 "build/parser.tab.cc"
    break;

  case 216: /* TypeName: TypeSpec AbstractDeclarator  */
#line 809 "src/parser.y"
        { Node* d = declNameNode((yyvsp[0].node));
          if (d && !d->sval.empty()) {
              std::string m = "a type name cannot declare the identifier '";
              m += d->sval; m += "'";
              parseDiag(d->line, d->col, m.c_str());
          }
          (yyval.node) = mk2(N_TYPENAME, (yylsp[-1]).first_line, (yylsp[-1]).first_column, (yyvsp[-1].node), (yyvsp[0].node)); }
#line 3479 "build/parser.tab.cc"
    break;


#line 3483 "build/parser.tab.cc"

      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", YY_CAST (yysymbol_kind_t, yyr1[yyn]), &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;

  *++yyvsp = yyval;
  *++yylsp = yyloc;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */
  {
    const int yylhs = yyr1[yyn] - YYNTOKENS;
    const int yyi = yypgoto[yylhs] + *yyssp;
    yystate = (0 <= yyi && yyi <= YYLAST && yycheck[yyi] == *yyssp
               ? yytable[yyi]
               : yydefgoto[yylhs]);
  }

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYSYMBOL_YYEMPTY : YYTRANSLATE (yychar);
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
      {
        yypcontext_t yyctx
          = {yyssp, yytoken, &yylloc};
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = yysyntax_error (&yymsg_alloc, &yymsg, &yyctx);
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == -1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = YY_CAST (char *,
                             YYSTACK_ALLOC (YY_CAST (YYSIZE_T, yymsg_alloc)));
            if (yymsg)
              {
                yysyntax_error_status
                  = yysyntax_error (&yymsg_alloc, &yymsg, &yyctx);
                yymsgp = yymsg;
              }
            else
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = YYENOMEM;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == YYENOMEM)
          YYNOMEM;
      }
    }

  yyerror_range[1] = yylloc;
  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval, &yylloc);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:
  /* Pacify compilers when the user code never invokes YYERROR and the
     label yyerrorlab therefore never appears in user code.  */
  if (0)
    YYERROR;
  ++yynerrs;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  /* Pop stack until we find a state that shifts the error token.  */
  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYSYMBOL_YYerror;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYSYMBOL_YYerror)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;

      yyerror_range[1] = *yylsp;
      yydestruct ("Error: popping",
                  YY_ACCESSING_SYMBOL (yystate), yyvsp, yylsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  yyerror_range[2] = yylloc;
  ++yylsp;
  YYLLOC_DEFAULT (*yylsp, yyerror_range, 2);

  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", YY_ACCESSING_SYMBOL (yyn), yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturnlab;


/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturnlab;


/*-----------------------------------------------------------.
| yyexhaustedlab -- YYNOMEM (memory exhaustion) comes here.  |
`-----------------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  goto yyreturnlab;


/*----------------------------------------------------------.
| yyreturnlab -- parsing is finished, clean up and return.  |
`----------------------------------------------------------*/
yyreturnlab:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval, &yylloc);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  YY_ACCESSING_SYMBOL (+*yyssp), yyvsp, yylsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
  return yyresult;
}

#line 818 "src/parser.y"


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
