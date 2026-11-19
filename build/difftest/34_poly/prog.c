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
/* 34 -- polynomial evaluation chosen through function pointers: three
   evaluation schemes behind one pointer type, a table that names them, and a
   derivative evaluated by the same machinery. */
typedef double (*Eval)(double *, int, double);

/* straightforward: sum c[i] * x^i */
double naive(double *c, int n, double x) {
    double s = 0.0;
    double p = 1.0;
    int i;
    for (i = 0; i < n; i++) { s += c[i] * p; p *= x; }
    return s;
}

/* Horner's scheme: fewer multiplications, same value for these inputs */
double horner(double *c, int n, double x) {
    double s = 0.0;
    int i;
    for (i = n - 1; i >= 0; i--) s = s * x + c[i];
    return s;
}

/* the derivative, evaluated by Horner on the differentiated coefficients */
double deriv(double *c, int n, double x) {
    double s = 0.0;
    int i;
    for (i = n - 1; i >= 1; i--) s = s * x + c[i] * i;
    return s;
}

struct Scheme { char tag; Eval f; };

double dabs(double v) { return v < 0.0 ? -v : v; }

int main(void) {
    /* 2 - 3x + 0.5x^2 + x^3 */
    double c[4];
    struct Scheme schemes[3];
    Eval  fns[3];
    double xs[4];
    int i, j;

    c[0] = 2.0; c[1] = -3.0; c[2] = 0.5; c[3] = 1.0;
    schemes[0].tag = 'n'; schemes[0].f = naive;
    schemes[1].tag = 'h'; schemes[1].f = horner;
    schemes[2].tag = 'd'; schemes[2].f = deriv;
    fns[0] = naive; fns[1] = horner; fns[2] = deriv;
    xs[0] = 0.0; xs[1] = 1.0; xs[2] = 2.5; xs[3] = -1.5;

    for (i = 0; i < 4; i++) {
        printf("x=%6.2f", xs[i]);
        for (j = 0; j < 3; j++)
            printf("  %c=%12.6f", schemes[j].tag, schemes[j].f(c, 4, xs[i]));
        printf("\n");
    }

    /* the two value schemes agree closely; the derivative is checked against a
       finite difference */
    for (i = 0; i < 4; i++) {
        double h = 1e-6;
        double fd = (horner(c, 4, xs[i] + h) - horner(c, 4, xs[i] - h)) / (2.0 * h);
        printf("agree=%d fd_ok=%d\n",
               dabs(naive(c, 4, xs[i]) - horner(c, 4, xs[i])) < 1e-12,
               dabs(fd - deriv(c, 4, xs[i])) < 1e-5);
    }

    /* a root of x^3 + 0.5x^2 - 3x + 2 bracketed by bisection, all through a
       pointer so the polynomial could be swapped out */
    {
        Eval f = fns[1];
        double lo = -3.0, hi = -2.0, mid = 0.0;
        for (i = 0; i < 80; i++) {
            mid = (lo + hi) / 2.0;
            if (f(c, 4, lo) * f(c, 4, mid) <= 0.0) hi = mid; else lo = mid;
        }
        printf("root=%.8f value=%d\n", mid, dabs(f(c, 4, mid)) < 1e-9);
    }
    return 0;
}
