/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

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

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_BUILD_PARSER_TAB_HH_INCLUDED
# define YY_YY_BUILD_PARSER_TAB_HH_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    IDENTIFIER = 258,              /* IDENTIFIER  */
    TYPE_NAME = 259,               /* TYPE_NAME  */
    ICONST = 260,                  /* ICONST  */
    FCONST = 261,                  /* FCONST  */
    CCONST = 262,                  /* CCONST  */
    SCONST = 263,                  /* SCONST  */
    FLOAT = 264,                   /* FLOAT  */
    DOUBLE = 265,                  /* DOUBLE  */
    INT = 266,                     /* INT  */
    CHAR = 267,                    /* CHAR  */
    VOID = 268,                    /* VOID  */
    STRUCT = 269,                  /* STRUCT  */
    UNION = 270,                   /* UNION  */
    ENUM = 271,                    /* ENUM  */
    TYPEDEF = 272,                 /* TYPEDEF  */
    IF = 273,                      /* IF  */
    ELSE = 274,                    /* ELSE  */
    FOR = 275,                     /* FOR  */
    WHILE = 276,                   /* WHILE  */
    DO = 277,                      /* DO  */
    UNTIL = 278,                   /* UNTIL  */
    SWITCH = 279,                  /* SWITCH  */
    CASE = 280,                    /* CASE  */
    DEFAULT = 281,                 /* DEFAULT  */
    BREAK = 282,                   /* BREAK  */
    CONTINUE = 283,                /* CONTINUE  */
    GOTO = 284,                    /* GOTO  */
    RETURN = 285,                  /* RETURN  */
    SIZEOF = 286,                  /* SIZEOF  */
    ADD_OP = 287,                  /* ADD_OP  */
    SUB_OP = 288,                  /* SUB_OP  */
    MUL_OP = 289,                  /* MUL_OP  */
    DIV_OP = 290,                  /* DIV_OP  */
    MOD_OP = 291,                  /* MOD_OP  */
    EQ_OP = 292,                   /* EQ_OP  */
    NE_OP = 293,                   /* NE_OP  */
    LT_OP = 294,                   /* LT_OP  */
    GT_OP = 295,                   /* GT_OP  */
    LE_OP = 296,                   /* LE_OP  */
    GE_OP = 297,                   /* GE_OP  */
    LOG_AND = 298,                 /* LOG_AND  */
    LOG_OR = 299,                  /* LOG_OR  */
    LOG_NOT = 300,                 /* LOG_NOT  */
    BIT_AND = 301,                 /* BIT_AND  */
    BIT_OR = 302,                  /* BIT_OR  */
    BIT_XOR = 303,                 /* BIT_XOR  */
    BIT_NOT = 304,                 /* BIT_NOT  */
    LEFT_OP = 305,                 /* LEFT_OP  */
    RIGHT_OP = 306,                /* RIGHT_OP  */
    INC_OP = 307,                  /* INC_OP  */
    DEC_OP = 308,                  /* DEC_OP  */
    ARROW = 309,                   /* ARROW  */
    DOT = 310,                     /* DOT  */
    ASSIGN = 311,                  /* ASSIGN  */
    ADD_ASSIGN = 312,              /* ADD_ASSIGN  */
    SUB_ASSIGN = 313,              /* SUB_ASSIGN  */
    MUL_ASSIGN = 314,              /* MUL_ASSIGN  */
    DIV_ASSIGN = 315,              /* DIV_ASSIGN  */
    MOD_ASSIGN = 316,              /* MOD_ASSIGN  */
    AND_ASSIGN = 317,              /* AND_ASSIGN  */
    OR_ASSIGN = 318,               /* OR_ASSIGN  */
    XOR_ASSIGN = 319,              /* XOR_ASSIGN  */
    LEFT_ASSIGN = 320,             /* LEFT_ASSIGN  */
    RIGHT_ASSIGN = 321,            /* RIGHT_ASSIGN  */
    LOWER_THAN_ELSE = 322          /* LOWER_THAN_ELSE  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 129 "src/parser.y"

    const char* str;
    Node*       node;
    int         ival;

#line 137 "build/parser.tab.hh"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif

/* Location type.  */
#if ! defined YYLTYPE && ! defined YYLTYPE_IS_DECLARED
typedef struct YYLTYPE YYLTYPE;
struct YYLTYPE
{
  int first_line;
  int first_column;
  int last_line;
  int last_column;
};
# define YYLTYPE_IS_DECLARED 1
# define YYLTYPE_IS_TRIVIAL 1
#endif


extern YYSTYPE yylval;
extern YYLTYPE yylloc;

int yyparse (void);


#endif /* !YY_YY_BUILD_PARSER_TAB_HH_INCLUDED  */
