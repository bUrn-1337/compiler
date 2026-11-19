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
/* 46 -- initializers: a braced list around a scalar, partial lists that leave
   the rest zero, nested braces, a string for a char array, arrays of structs,
   a union initialized through its first member, trailing commas, and the same
   forms at file scope and inside a block. */
int    gscalar = {5};                     /* braces around a scalar */
int    gpart[5] = {1, 2};                 /* the tail is zero */
int    gmat[2][3] = { {1, 2, 3}, {4, 5} };
char   gtext[8] = "hi";
char   gexact[3] = "ab";
double gd[3] = {1, 2.5};                  /* 1 converts to 1.0 */
struct Pair { int a; int b; };
struct Pair gpair = {7, 8};
struct Pair gpairs[3] = { {1, 2}, {3, 4} };
struct Nest { struct Pair p; int t[2]; char c; };
struct Nest gnest = { {9, 10}, {11, 12}, 'N' };
union  Mix { int i; char b[4]; };
union  Mix gmix = {258};
int    gtrail[3] = {1, 2, 3,};
char  *gwords[3] = { "alpha", "beta" };
int   *gptr = &gscalar;

int main(void) {
    int    scalar = {42};
    int    part[5] = {9, 8};
    int    mat[2][3] = { {1, 2, 3}, {4} };
    char   text[8] = "local";
    double dd[4] = {0.5, 1, 1.5,};
    struct Pair pair = {3, 4};
    struct Pair pairs[2] = { {5, 6}, {7, 8} };
    struct Nest nest = { {1, 2}, {3, 4}, 'L' };
    union  Mix  mix = {513};
    char  *words[2] = { "one", "two" };
    struct Pair copy = pair;                  /* from another struct */
    int    i, j;

    printf("%d %d %d\n", gscalar, scalar, *gptr);
    for (i = 0; i < 5; i++) printf("%d%c", gpart[i], i == 4 ? '\n' : ' ');
    for (i = 0; i < 5; i++) printf("%d%c", part[i], i == 4 ? '\n' : ' ');
    for (i = 0; i < 2; i++) {
        for (j = 0; j < 3; j++) printf("%d ", gmat[i][j]);
        printf("| ");
        for (j = 0; j < 3; j++) printf("%d ", mat[i][j]);
        printf("\n");
    }
    printf("[%s] %d [%s] %d\n", gtext, (int)strlen(gtext), text, (int)strlen(text));
    printf("%c%c %d\n", gexact[0], gexact[1], gexact[2] == 0);
    printf("%.2f %.2f %.2f\n", gd[0], gd[1], gd[2]);
    printf("%.2f %.2f %.2f %.2f\n", dd[0], dd[1], dd[2], dd[3]);
    printf("%d,%d %d,%d %d,%d\n", gpair.a, gpair.b, pair.a, pair.b, copy.a, copy.b);
    for (i = 0; i < 3; i++) printf("(%d,%d)", gpairs[i].a, gpairs[i].b);
    printf("\n");
    for (i = 0; i < 2; i++) printf("(%d,%d)", pairs[i].a, pairs[i].b);
    printf("\n");
    printf("%d,%d %d,%d %c | %d,%d %d,%d %c\n",
           gnest.p.a, gnest.p.b, gnest.t[0], gnest.t[1], gnest.c,
           nest.p.a, nest.p.b, nest.t[0], nest.t[1], nest.c);
    /* the sum of all four bytes does not depend on byte order */
    printf("%d %d %d %d\n", gmix.i,
           gmix.b[0] + gmix.b[1] + gmix.b[2] + gmix.b[3], mix.i,
           mix.b[0] + mix.b[1] + mix.b[2] + mix.b[3]);
    printf("%d %d %d\n", gtrail[0], gtrail[1], gtrail[2]);
    printf("%s %s %d %s %s\n", gwords[0], gwords[1], gwords[2] == 0,
           words[0], words[1]);

    /* a block of its own, with its own initializers */
    {
        int    inner[3] = {1};
        struct Nest n2 = gnest;
        double one = {1.25};
        printf("%d %d %d %d %c %.2f\n", inner[0], inner[1], inner[2],
               n2.t[1], n2.c, one);
    }
    return 0;
}
