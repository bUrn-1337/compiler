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
/* 32 -- Newton's method for the square root, in double precision: a loop over
   floating values with a convergence test, and a few helpers written by hand
   because the language has no math library. */
double dabs(double v) { return v < 0.0 ? -v : v; }

/* sqrt(a) by Newton iteration: x <- (x + a/x) / 2 */
double mysqrt(double a, int *iters) {
    double x;
    int n = 0;
    if (a < 0.0) { *iters = 0; return -1.0; }
    if (a == 0.0) { *iters = 0; return 0.0; }
    x = a > 1.0 ? a : 1.0;
    while (n < 60) {
        double next = (x + a / x) / 2.0;
        n++;
        if (dabs(next - x) <= 1e-15 * dabs(next)) { x = next; break; }
        x = next;
    }
    *iters = n;
    return x;
}

/* the inverse, to show the error is tiny without printing raw bits */
double sq(double v) { return v * v; }

int main(void) {
    double vals[6];
    int    i;

    vals[0] = 2.0;
    vals[1] = 9.0;
    vals[2] = 0.25;
    vals[3] = 1e6;
    vals[4] = 1e-6;
    vals[5] = 0.0;

    for (i = 0; i < 6; i++) {
        int    it;
        double r = mysqrt(vals[i], &it);
        printf("sqrt(%.6f) = %.10f  err<1e-9: %d  iters<=%d: %d\n",
               vals[i], r, dabs(sq(r) - vals[i]) < 1e-9 * (vals[i] + 1.0),
               60, it <= 60);
    }
    printf("negative: %.1f\n", mysqrt(-4.0, &i));

    /* a running sum of square roots, to exercise accumulation */
    {
        double total = 0.0;
        int it;
        for (i = 1; i <= 10; i++) total += mysqrt((double)i, &it);
        printf("sum sqrt(1..10) = %.8f\n", total);
    }
    return 0;
}
