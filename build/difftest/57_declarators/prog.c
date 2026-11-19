/* test/prelude.h -- prepended to each test program ONLY when it is compiled by
 * gcc as the reference implementation (see verify.sh).  The generator itself
 * never sees this file: the source language has no preprocessor, so printf,
 * malloc, fopen and friends are built into the compiler, and `until` is a
 * language extension rather than a macro.
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define until(c) while (!(c))
/* 57 -- declarator forms, named and nameless.  Every form in this file was a
   SYNTAX ERROR until the declarator grammar was unified; each one is valid C99
   that gcc -m32 accepts, so each one was a program this compiler wrongly
   rejected.  tools/declfuzz.py found them by enumerating declarator shapes and
   asking gcc which are legal; this test is the permanent record of the ones
   that failed.

   The three causes, all of them one defect -- a hand-written abstract
   declarator sub-grammar that had drifted away from the concrete one:

     1. a parameter list accepted no abstract declarator beyond bare stars, so
        an unnamed parameter could only be `T', `T *' or `T **';
     2. a parenthesized abstract group had to be followed by '(' or '[', so a
        group that ENDED the declarator, `int *(*)', failed;
     3. that group had to start with a '*', so `int ([3])' failed.

   Nothing here is only parsed: every declared thing is called, indexed or
   measured, so the IR is exercised and the printed numbers are compared
   against gcc.  @requires-m32 -- the sizes of the pointer types are the
   target's pointer size.

   @requires-m32 */

struct S { int a; char b; };
union  U { int i; char c[4]; };
enum   E { E0, E1 };
typedef char Byte;
typedef int  Row[3];
typedef int  (*Cmp)(int, int);

/* ---- 1. prototypes whose parameters have no names, in every shape ---- */
int p_plain(int);                  /* the one shape that always worked */
int p_ptr(int *);
int p_ptr2(char **);
int p_array(int [3]);              /* adjusted to int *            */
int p_unsized(int []);             /* adjusted to int *            */
int p_ptrarray(int (*)[3]);        /* pointer to array: not int ** */
int p_arrayptr(int *[2]);          /* array of pointers            */
int p_fnptr(int (*)(int, int));
int p_fnptrarr(int (*[2])(int));   /* array of pointers to function */
int p_fntype(int (int));           /* nameless FUNCTION type: adjusted to a
                                      pointer to function, exactly as the
                                      array above is adjusted to a pointer */
int p_fnempty(int (void));
int p_two(char *, int);
int p_tag(struct S, union U, enum E);
int p_typedefs(Byte, Row, Cmp);    /* Row and Cmp are adjusted too */
int p_none(void);

/* ---- 2. the same forms as definitions, now with names ---- */
int p_plain(int a)                 { return a + 1; }
int p_ptr(int *q)                  { return *q + 2; }
int p_ptr2(char **q)               { return **q; }
int p_array(int v[3])              { return v[0] + v[2]; }
int p_unsized(int v[])             { return v[1]; }
int p_ptrarray(int (*v)[3])        { return v[1][2]; }
int p_arrayptr(int *v[2])          { return *v[0] + *v[1]; }
int p_fnptr(int (*f)(int, int))    { return f(3, 4); }
int p_fnptrarr(int (*f[2])(int))   { return f[0](5) + f[1](6); }
int p_fntype(int (*g)(int))        { return g(7); }
int p_fnempty(int (*g)(void))      { return g(); }
int p_two(char *s, int n)          { return s[n]; }
int p_tag(struct S s, union U u, enum E e) { return s.a + u.i + (int)e; }
int p_typedefs(Byte b, Row r, Cmp c)       { return b + r[1] + c(1, 2); }
int p_none(void)                   { return 100; }

int addi(int x, int y) { return x + y; }
int inc(int x)         { return x + 1; }
int dbl(int x)         { return x * 2; }
int zero(void)         { return 50; }

/* ---- 3. a function whose RETURN type needs the tricky declarators ---- */
int  (*pick(int which))(int, int) { return which ? addi : addi; }
int  (*rowof(int m[2][3]))[3]     { return m; }       /* returns int (*)[3] */

int main(void) {
    int  one[3];
    int  two[2][3];
    int  x;
    int  y;
    int *pa[2];
    int  (*fa[2])(int);
    char  c;
    char *cp;
    char **cpp;
    struct S s;
    union  U u;
    Row    r;
    int  (*pm)[3];
    int  (*(*ppick)(int))(int, int);

    one[0] = 1; one[1] = 2; one[2] = 3;
    two[0][0] = 10; two[0][1] = 11; two[0][2] = 12;
    two[1][0] = 13; two[1][1] = 14; two[1][2] = 15;
    x = 7; y = 8;
    pa[0] = &x; pa[1] = &y;
    fa[0] = inc; fa[1] = dbl;
    c = 'k'; cp = &c; cpp = &cp;
    s.a = 20; s.b = 'z';
    u.i = 30;
    r[0] = 40; r[1] = 41; r[2] = 42;

    /* ---- the nameless parameter shapes, called ---- */
    printf("%d %d %d %d\n", p_plain(5), p_ptr(&x), p_ptr2(cpp), p_none());
    printf("%d %d %d %d\n", p_array(one), p_unsized(one), p_ptrarray(two),
                            p_arrayptr(pa));
    printf("%d %d %d %d\n", p_fnptr(addi), p_fnptrarr(fa), p_fntype(inc),
                            p_fnempty(zero));
    printf("%d %d %d\n", p_two("abcd", 2), p_tag(s, u, E1), p_typedefs(3, r, addi));

    /* ---- pointer to array: indexed, not just declared ---- */
    pm = two;
    printf("%d %d %d\n", pm[0][1], pm[1][2], rowof(two)[1][0]);

    /* ---- pointer to function returning a pointer to function ---- */
    ppick = pick;
    printf("%d %d\n", pick(1)(6, 7), ppick(0)(8, 9));

    /* ---- type names: sizeof, including the three failing shapes ---- */
    printf("%d %d %d %d\n", (int)sizeof(int), (int)sizeof(int *),
                            (int)sizeof(int [3]), (int)sizeof(int *[3]));
    printf("%d %d %d %d\n", (int)sizeof(int (*)[6]),    /* pointer: 4  */
                            (int)sizeof(int (*)(int)),  /* pointer: 4  */
                            (int)sizeof(int (*[2])(int)),
                            (int)sizeof(int **));
    /* cause 3: a parenthesized group with no star.  int ([3]) IS int [3]. */
    printf("%d %d %d\n", (int)sizeof(int ([3])), (int)sizeof(int ([2])[3]),
                         (int)sizeof(int *([3])));
    /* cause 2: a group that ends the declarator.  int *(*) IS int **. */
    printf("%d %d\n", (int)sizeof(int *(*)), (int)sizeof(int (*)));
    printf("%d %d %d\n", (int)sizeof(struct S), (int)sizeof(union U),
                         (int)sizeof(Row));

    /* ---- casts using the same type names ---- */
    pm = (int (*)[3])two;
    printf("%d %d\n", pm[1][1], (int)(*(int (*)[3])two)[2]);
    printf("%d\n", ((int (*)(int, int))addi)(11, 12));

    return 0;
}
