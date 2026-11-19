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
/* 05 -- switch: fall-through, `default` in the middle, break inside a loop
   inside a switch, and a switch whose controlling expression has a side effect
   (which must be evaluated exactly once). */
int probes;

int probe(int v) { probes = probes + 1; return v; }

void describe(int n) {
    switch (n) {
        case 1:
            printf("one ");
            /* falls through */
        case 2:
            printf("two ");
            break;
        case 3:
            printf("three ");
        default:
            printf("other ");
            break;
        case 4:
        case 5:
            printf("four-or-five ");
            break;
    }
    printf("\n");
}

int main(void) {
    int i;
    int sum;
    char c;

    for (i = 0; i < 7; i = i + 1) { printf("%d: ", i); describe(i); }

    /* the controlling expression is evaluated exactly once */
    probes = 0;
    switch (probe(3)) {
        case 3: printf("hit\n"); break;
        default: printf("miss\n"); break;
    }
    printf("probes=%d\n", probes);

    /* a switch with no matching case and no default does nothing */
    switch (99) { case 1: printf("bad\n"); break; }

    /* break inside a switch inside a loop breaks the switch only;
       continue inside a switch targets the enclosing loop */
    sum = 0;
    for (i = 0; i < 6; i = i + 1) {
        switch (i % 3) {
            case 0: continue;          /* next loop iteration */
            case 1: sum = sum + i; break;
            default: sum = sum + 100; break;
        }
        sum = sum + 1000;
    }
    printf("sum=%d\n", sum);

    /* switch on a char, and on an expression */
    c = 'b';
    switch (c) {
        case 'a': printf("A\n"); break;
        case 'b': printf("B\n"); break;
        default:  printf("?\n"); break;
    }
    switch (2 * 3 - 1) { case 5: printf("five\n"); break; default: printf("no\n"); }

    /* a loop inside a switch: break belongs to the loop */
    switch (1) {
        case 1:
            for (i = 0; i < 3; i = i + 1) { if (i == 2) break; printf("i%d ", i); }
            printf("\n");
            break;
    }
    return 0;
}
