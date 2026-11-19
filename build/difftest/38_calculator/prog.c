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
/* 38 -- a calculator driven by a dispatch table: each operator character is
   paired with a function pointer, the table is searched once per expression,
   and the operands are read as doubles from standard input
   (test/input/38_calculator.in). */
typedef double (*BinOp)(double, double);

double opAdd(double a, double b) { return a + b; }
double opSub(double a, double b) { return a - b; }
double opMul(double a, double b) { return a * b; }
double opDiv(double a, double b) { return b == 0.0 ? 0.0 : a / b; }
double opMin(double a, double b) { return a < b ? a : b; }
double opMax(double a, double b) { return a > b ? a : b; }
double opPow(double a, double b) {              /* integer exponent only */
    double r = 1.0;
    int n = (int)b;
    int i;
    if (n < 0) { for (i = 0; i < -n; i++) r *= a; return a == 0.0 ? 0.0 : 1.0 / r; }
    for (i = 0; i < n; i++) r *= a;
    return r;
}

struct Entry { char op; BinOp fn; char *name; };

struct Entry table[7] = {
    { '+', opAdd, "add" },
    { '-', opSub, "sub" },
    { '*', opMul, "mul" },
    { '/', opDiv, "div" },
    { '<', opMin, "min" },
    { '>', opMax, "max" },
    { '^', opPow, "pow" }
};

BinOp lookup(char op, char **name) {
    int i;
    for (i = 0; i < 7; i++)
        if (table[i].op == op) { *name = table[i].name; return table[i].fn; }
    *name = "?";
    return 0;
}

int main(void) {
    double a;
    double b;
    char   op;
    int    n = 0;
    int    done = 0;

    while (!done) {
        n = scanf(" %lf %c %lf", &a, &op, &b);
        if (n != 3) { done = 1; }
        else {
            char *name;
            BinOp f = lookup(op, &name);
            if (f) printf("%.4f %c %.4f = %.6f (%s)\n", a, op, b, f(a, b), name);
            else   printf("%.4f %c %.4f : no such operator\n", a, op, b);
        }
    }
    printf("stopped after n=%d\n", n);

    /* the whole table applied to one pair of operands */
    {
        int i;
        for (i = 0; i < 7; i++)
            printf("%s(6,3) = %.4f\n", table[i].name, table[i].fn(6.0, 3.0));
    }
    /* calls straight through the table and through a local copy */
    {
        BinOp f = table[2].fn;
        struct Entry e = table[3];           /* a struct holding a pointer, by value */
        printf("%.4f %.4f %.4f\n", table[0].fn(1.5, 2.5), f(2.5, 4.0), e.fn(9.0, 4.0));
        printf("divide by zero guarded: %.4f\n", e.fn(1.0, 0.0));
    }
    return 0;
}
