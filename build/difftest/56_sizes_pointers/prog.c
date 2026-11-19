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
/* 56 -- the sizes, offsets and pointer differences that only became checkable
   once the reference build became 32-bit (gcc -m32 -msse2 -mfpmath=sse).  The
   target model is char=1, int=4, enum=4, float=4, pointer=4, double=8, and
   -m32 agrees with every one of those, so pointer sizes and pointer arithmetic
   can now be printed and compared against gcc byte for byte.

   @requires-m32 -- the numbers this test prints ARE the target's pointer size,
   so only the 32-bit reference can agree with them; ./verify.sh skips the test
   under REF=native rather than reporting a difference between two ABIs.

   What is deliberately NOT printed here: the size of, or the offset of a
   member of, any struct or union containing a `double'.  The i386 ABI aligns a
   double to 4 bytes inside a struct, while this compiler's MIPS model aligns
   it to 8, so those two layouts legitimately differ; comparing them would be
   comparing two ABIs rather than testing anything.  Tests 27 and 36 exercise
   double members by computing with them instead. */

struct Pt   { int x; int y; };                   /* 8 */
struct Pack { char a; int b; char c; };          /* 12, b at 4 */
struct Nest { struct Pt p; char tag; };          /* 12 */
struct Ptrs { int *p; char **q; struct Pt *r; }; /* 12, three 4-byte pointers */
struct Flt  { float a; float b; int n; };        /* 12; float is 4-aligned */
union  Mix  { int i; char b[7]; int *p; };       /* 8 */

typedef int   Row[4];
typedef int   (*Cmp)(int, int);
typedef char *Str;
typedef int   (*PA6)[6];

int gi;
int *gip = &gi;

int cmpAsc(int a, int b) { return a - b; }

int main(void) {
    int    i;
    int    a[10];
    char   c;
    char   s[14];
    int   *ip;
    char **cpp;
    int  ***ippp;
    void  *vp;
    Cmp    fp;
    Row    r;
    struct Pt   pts[5];
    struct Ptrs pr;
    int    d;

    /* ---- the size of a pointer, in every spelling ---- */
    printf("%d %d %d %d\n", (int)sizeof(int *), (int)sizeof(char **),
                            (int)sizeof(int ***), (int)sizeof(void *));
    printf("%d %d %d %d\n", (int)sizeof(struct Pt *), (int)sizeof(Str),
                            (int)sizeof(Cmp), (int)sizeof(PA6));
    printf("%d %d %d\n", (int)sizeof ip, (int)sizeof cpp, (int)sizeof ippp);
    printf("%d %d %d\n", (int)sizeof vp, (int)sizeof fp, (int)sizeof gip);
    /* a pointer to a pointer is the same size as a pointer to anything */
    printf("%d %d\n", sizeof(char *) == sizeof(char **),
                      sizeof(int *) == sizeof(struct Ptrs *));

    /* ---- nameless pointer declarators: to a function, and to an array ---- */
    printf("%d %d %d\n", (int)sizeof(int (*)(int, int)),
                         (int)sizeof(int (*)[6]), (int)sizeof(int (*)[2][3]));
    printf("%d %d\n", (int)sizeof(int (**)[6]), (int)sizeof(int (*[3])(int)));

    /* ---- arrays of pointers, and the arrays a pointer points at ---- */
    printf("%d %d\n", (int)sizeof(int *[6]), (int)sizeof(char *[2][5]));
    printf("%d %d\n", (int)sizeof(Cmp[3]), (int)sizeof(int (*[4])[6]));

    /* ---- structs and unions WITHOUT a double ---- */
    printf("%d %d %d\n", (int)sizeof(struct Pt), (int)sizeof(struct Pack),
                         (int)sizeof(struct Nest));
    printf("%d %d %d\n", (int)sizeof(struct Ptrs), (int)sizeof(struct Flt),
                         (int)sizeof(union Mix));
    printf("%d %d %d\n", (int)sizeof pts, (int)sizeof r, (int)sizeof pr);
    printf("%d\n", (int)sizeof(struct Pt[5]) / (int)sizeof(struct Pt));

    /* ---- member offsets, computed without offsetof ---- */
    {
        struct Pack pk;
        struct Nest nk;
        char *base;

        base = (char *)&pk;
        printf("%d %d %d\n", (int)((char *)&pk.a - base),
                             (int)((char *)&pk.b - base),
                             (int)((char *)&pk.c - base));
        base = (char *)&nk;
        printf("%d %d %d\n", (int)((char *)&nk.p - base),
                             (int)((char *)&nk.p.y - base),
                             (int)((char *)&nk.tag - base));
        base = (char *)&pr;
        printf("%d %d %d\n", (int)((char *)&pr.p - base),
                             (int)((char *)&pr.q - base),
                             (int)((char *)&pr.r - base));
    }

    /* ---- pointer difference: the result is an element count ---- */
    for (i = 0; i < 10; i = i + 1) a[i] = i * i;
    ip = &a[0];
    printf("%d %d %d\n", (int)(&a[7] - &a[2]), (int)(&a[0] - &a[0]),
                         (int)(&a[2] - &a[7]));
    printf("%d %d\n", (int)(&a[10] - a), (int)((ip + 6) - ip));
    /* the same difference seen as bytes, and divided back down */
    printf("%d %d\n", (int)((char *)&a[7] - (char *)&a[2]),
                      (int)(((char *)&a[7] - (char *)&a[2])
                            / (int)sizeof(int)));

    /* differences over wider and narrower element types */
    {
        struct Pt *pp;
        char      *cp;
        char   ***qq;

        pp = &pts[0];
        cp = &s[0];
        qq = &cpp;
        printf("%d %d\n", (int)(&pts[4] - &pts[1]),
                          (int)((char *)&pts[4] - (char *)&pts[1]));
        printf("%d %d\n", (int)(&s[13] - &s[3]), (int)((pp + 3) - pp));
        printf("%d %d\n", (int)((cp + 9) - cp),
                          (int)((char *)(qq + 2) - (char *)qq));
    }

    /* ---- pointer arithmetic strides, printed as byte distances ---- */
    printf("%d %d %d\n", (int)((char *)(ip + 1) - (char *)ip),
                         (int)((char *)&pts[1] - (char *)&pts[0]),
                         (int)((char *)&s[1] - (char *)&s[0]));
    printf("%d %d\n", (int)((char *)&r[1] - (char *)&r[0]),
                      (int)((char *)(gip + 1) - (char *)gip));

    /* ---- sizeof is a compile-time constant, so it can size an array ---- */
    {
        char blob[sizeof(int *) * 3];
        int  tab[sizeof(struct Pt) / sizeof(int)];

        printf("%d %d\n", (int)sizeof blob, (int)sizeof tab);
    }

    /* ---- a pointer to an array, used and not merely measured ---- */
    {
        int   m[2][3];
        PA6   p6;
        int (*p3)[3];
        int   j;

        for (i = 0; i < 2; i = i + 1)
            for (j = 0; j < 3; j = j + 1) m[i][j] = i * 10 + j;
        p3 = &m[1];
        printf("%d %d %d\n", (*p3)[0], (*p3)[2], (int)sizeof(*p3));
        printf("%d %d\n", (int)(p3 - &m[0]),
                          (int)((char *)p3 - (char *)&m[0]));
        p6 = (PA6)&a[0];
        printf("%d %d %d\n", (*p6)[3], (int)sizeof(*p6), (int)sizeof p6);
    }

    /* ---- a round trip through void * and back ---- */
    vp = &a[4];
    ip = (int *)vp;
    printf("%d %d\n", *ip, (int)(ip - a));

    /* ---- and one computation, so the test is not purely about layout ---- */
    d = 0;
    cpp = 0;
    fp = cmpAsc;
    c = 'k';
    for (i = 0; i < 10; i = i + 1) d = d + a[i];
    printf("%d %d %c %d\n", d, fp(9, 4), c, cpp == 0);
    return 0;
}
