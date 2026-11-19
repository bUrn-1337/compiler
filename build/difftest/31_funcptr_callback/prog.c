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
/* 31 -- function pointers at work: a function whose return type is a function
   pointer written out longhand, callbacks, a qsort-like routine driven by a
   comparator, and a cast between function-pointer types. */
int  add(int a, int b) { return a + b; }
int  sub(int a, int b) { return a - b; }
int  ascending(int a, int b)  { return a - b; }
int  descending(int a, int b) { return b - a; }

/* a function returning a function pointer, written out longhand */
int (*choose(int which))(int, int) { return which ? sub : add; }

/* a qsort-like routine driven by a comparator the caller supplies */
void mysort(int *v, int n, int (*cmp)(int, int)) {
    int i, j, t;
    for (i = 1; i < n; i++) {
        t = v[i];
        j = i - 1;
        while (j >= 0 && cmp(v[j], t) > 0) { v[j + 1] = v[j]; j = j - 1; }
        v[j + 1] = t;
    }
}

int twice(int (*f)(int, int), int x) { return (*f)(x, x); }

int main(void) {
    int v[7];
    int i;
    int (*c)(int, int);

    printf("choose: %d %d\n", choose(0)(10, 3), choose(1)(10, 3));
    printf("twice: %d %d\n", twice(add, 6), twice(sub, 6));

    v[0] = 5; v[1] = 3; v[2] = 9; v[3] = 1; v[4] = 7; v[5] = 2; v[6] = 8;
    mysort(v, 7, ascending);
    for (i = 0; i < 7; i++) printf("%d%c", v[i], i == 6 ? '\n' : ' ');
    mysort(v, 7, descending);
    for (i = 0; i < 7; i++) printf("%d%c", v[i], i == 6 ? '\n' : ' ');

    /* size of a function pointer, and a cast through one */
    /* sizeof a function pointer is 4 on this target and 8 on a 64-bit host, so
       only its relation to sizeof(char *) is printed (see docs/REPORT.md). */
    printf("sizeof fp == sizeof(char *) = %d, equal = %d\n",
           (int)sizeof(int (*)(int, int)) == (int)sizeof(char *), add == add);

    c = (int (*)(int, int))sub;
    printf("cast call = %d\n", c(9, 4));
    return 0;
}
