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
/* 24 -- float and double: literal forms, the usual arithmetic conversions,
   conversions to and from the integer types, compound assignment, ++/--,
   comparisons, floats in conditions, and the conditional operator. */
double gd = 2.5;
float  gf = 1.5f;
double gsum = 1.5 + 2.0;          /* a constant expression in an initializer */

int main(void) {
    double lits[6];
    double x = 3.0;
    float  f = 1.5f;
    int    i = 7;
    char   c = 100;
    double y;
    int    k;

    /* every floating form the lexer must accept */
    lits[0] = 1.5;
    lits[1] = .5;
    lits[2] = 5.;
    lits[3] = 1e3;
    lits[4] = 1.5e-3;
    lits[5] = 0.125e+2;
    for (k = 0; k < 6; k++) printf("%.6f\n", lits[k]);

    /* usual arithmetic conversions: int -> double, float -> double */
    y = x + f;
    printf("%.3f %.3f %.3f\n", y, x + i, f * 2);
    printf("%.6f %.6f\n", x / 2.0, 1.0 / 3.0);
    printf("%.6f\n", (double)i / 2);          /* 3.5, not 3 */
    printf("%d\n", i / 2);                    /* still integer division */

    /* conversions: float -> int truncates toward zero */
    printf("%d %d %d %d\n", (int)2.9, (int)-2.9, (int)0.5, (int)-0.5);
    printf("%d %d\n", (int)(x * 2.5), (int)1e9);
    printf("%.6f %.6f\n", (double)c, (double)(float)1.0e10);
    printf("%d\n", (int)(char)100.9);   /* in range: 300.0 would be undefined */

    /* unary minus, ++/--, compound assignment */
    x++;  --f;
    printf("%.3f %.3f\n", x, (double)f);
    x += 0.25;  x -= 0.05;  x *= 2.0;  x /= 4.0;
    printf("%.6f %.6f\n", x, -x);

    /* comparisons yield an int; floats are legal conditions */
    printf("%d %d %d %d\n", x > 2.0, x < 2.0, x >= x, 1.5 != 1.5);
    if (f) printf("f nonzero\n");
    if (!0.0) printf("zero is false\n");
    if (gd && gf) printf("both nonzero\n");
    if (0.0 || 0.5) printf("second nonzero\n");
    printf("%.3f %.3f\n", x > 0 ? x : -x, 0.0 ? 1.5 : 2.5);

    /* globals, sizeof (never of a struct holding a double: see docs/REPORT.md) */
    printf("%.3f %.3f %.3f\n", gd, (double)gf, gsum);
    printf("%d %d %d\n", (int)sizeof(float), (int)sizeof(double),
           (int)sizeof(lits));
    printf("%d %d\n", (int)sizeof 1.5, (int)sizeof 1.5f);
    return 0;
}
