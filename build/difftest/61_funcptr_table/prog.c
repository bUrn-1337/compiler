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
/* 61 -- tables of function pointers: dispatch by index, a table in a
   struct, functions returning function pointers, pointers compared and
   passed as callbacks, and a tiny stack machine driven by a table. */
typedef int (*binop)(int, int);

int add(int a, int b) { return a + b; }
int sub(int a, int b) { return a - b; }
int mul(int a, int b) { return a * b; }
int quo(int a, int b) { if (b == 0) return 0; return a / b; }
int maxi(int a, int b) { return a > b ? a : b; }

binop table[5];
char *names[5];

struct op { char sym; binop fn; };

binop pick(char c) {
    if (c == '+') return add;
    if (c == '-') return sub;
    if (c == '*') return mul;
    return quo;
}

int fold(int *v, int n, binop f, int init) {
    int i;
    for (i = 0; i < n; i++) init = f(init, v[i]);
    return init;
}

double apply_d(double (*f)(double), double x, int times) {
    while (times-- > 0) x = f(x);
    return x;
}
double half(double x) { return x / 2; }
double sq(double x) { return x * x; }

/* runs a postfix program: digits push, operators pop two and push one */
int machine(char *prog) {
    int stack[32];
    int sp, i;
    struct op ops[4];
    sp = 0;
    ops[0].sym = '+'; ops[0].fn = add;
    ops[1].sym = '-'; ops[1].fn = sub;
    ops[2].sym = '*'; ops[2].fn = mul;
    ops[3].sym = '/'; ops[3].fn = quo;
    for (; *prog; prog++) {
        if (*prog >= '0' && *prog <= '9') stack[sp++] = *prog - '0';
        else
            for (i = 0; i < 4; i++)
                if (ops[i].sym == *prog) {
                    sp--;
                    stack[sp - 1] = ops[i].fn(stack[sp - 1], stack[sp]);
                }
    }
    return stack[0];
}

int main(void) {
    int v[6];
    int i, j;
    double (*fs[2])(double);
    table[0] = add; table[1] = sub; table[2] = mul; table[3] = quo; table[4] = maxi;
    names[0] = "add"; names[1] = "sub"; names[2] = "mul"; names[3] = "quo"; names[4] = "max";
    for (i = 0; i < 5; i++) printf("%s(17, 5) = %d\n", names[i], table[i](17, 5));
    for (i = 0; i < 6; i++) v[i] = i + 1;
    for (i = 0; i < 5; i++) printf("fold %s = %d\n", names[i], fold(v, 6, table[i], i == 2 ? 1 : 0));
    printf("pick: %d %d %d %d\n", pick('+')(6, 3), pick('-')(6, 3), pick('*')(6, 3), pick('/')(6, 3));
    for (i = 0; i < 5; i++)
        for (j = 0; j < 5; j++)
            if (table[i] == pick("+-*/"[j % 4]) && j < 4) printf("table[%d] is pick('%c')\n", i, "+-*/"[j]);
    printf("same: %d %d\n", table[0] == add, table[0] == table[1]);
    fs[0] = half; fs[1] = sq;
    printf("apply: %.6f %.1f\n", apply_d(fs[0], 1000.0, 5), apply_d(fs[1], 2.0, 4));
    printf("machine: %d %d %d\n", machine("34+5*"), machine("92-3*4/"), machine("12+34+*56+*"));
    return 0;
}
