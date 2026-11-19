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
/* 44 -- casts: nested and repeated casts, casts between pointer types, a cast
   between function-pointer types, casts in conditions and arguments, and the
   narrowing that a cast makes explicit. */
int add(int a, int b) { return a + b; }
typedef int (*Fn)(int, int);
typedef double (*DFn)(double, double);

double dadd(double a, double b) { return a + b; }

struct Bytes { char b[4]; };

int main(void) {
    int    i = 300;
    char   c;
    double d = -2.75;
    float  f;
    int   *p;
    char  *cp;
    void  *vp;
    int    arr[4];
    Fn     fn;
    struct Bytes bs;
    int    k;

    arr[0] = 0x01020304; arr[1] = 2; arr[2] = 3; arr[3] = 4;

    /* nested and repeated casts collapse to the innermost conversion */
    c = (char)(int)(char)i;
    printf("%d %d %d\n", c, (int)(char)65, (int)(int)(int)i);
    printf("%d %d\n", (int)(double)(int)d, (int)(float)(double)1.5);
    printf("%.4f %.4f\n", (double)(float)0.1, (double)(int)2.9);

    f = (float)d;
    printf("%.4f %d %d\n", (double)f, (int)d, (int)-d);

    /* pointer casts, there and back */
    p = arr;
    cp = (char *)p;
    vp = (void *)cp;
    printf("%d %d %d\n", *(int *)vp, *(int *)(void *)(char *)p, cp == (char *)arr);
    printf("%d %d\n", ((int *)vp)[1], *((int *)((char *)p + (int)sizeof(int))));

    /* a cast between function-pointer types, called through the result */
    fn = (Fn)add;
    printf("%d %d\n", fn(2, 3), ((Fn)add)(4, 5));
    printf("%d\n", ((DFn)dadd)(1.5, 2.5) > 3.9);

    /* a cast in a condition and in an argument */
    if ((int)0.5 == 0) printf("truncated to zero\n");
    printf("%d %.3f\n", (int)(d < 0.0 ? -d : d), (double)(char)200);
    printf("%d\n", (int)sizeof(char) + (int)sizeof(double));

    /* (void) discards a value explicitly */
    (void)add(1, 2);
    (void)0;

    /* a struct read through a char pointer: byte order is the host's, so only
       the sum of the bytes is printed */
    bs.b[0] = 1; bs.b[1] = 2; bs.b[2] = 3; bs.b[3] = 4;
    cp = (char *)&bs;
    k = 0;
    for (i = 0; i < 4; i++) k += cp[i];
    printf("bytes sum %d\n", k);
    return 0;
}
