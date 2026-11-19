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
/* 02 -- short-circuit evaluation.  The right operand of && and || must not be
   evaluated when the left one already decides the result, and ?: must evaluate
   only the branch it selects. */
int calls;

int tick(int v) {
    calls = calls + 1;
    return v;
}

int main(void) {
    int r;

    calls = 0;
    r = tick(0) && tick(1);
    printf("%d calls=%d\n", r, calls);

    calls = 0;
    r = tick(1) && tick(0);
    printf("%d calls=%d\n", r, calls);

    calls = 0;
    r = tick(1) || tick(1);
    printf("%d calls=%d\n", r, calls);

    calls = 0;
    r = tick(0) || tick(7);
    printf("%d calls=%d\n", r, calls);

    calls = 0;
    r = tick(1) ? tick(10) : tick(20);
    printf("%d calls=%d\n", r, calls);

    calls = 0;
    r = tick(0) ? tick(10) : tick(20);
    printf("%d calls=%d\n", r, calls);

    /* in a condition, too */
    calls = 0;
    if (tick(0) && tick(1)) printf("yes\n"); else printf("no\n");
    printf("calls=%d\n", calls);

    /* && and || yield exactly 0 or 1 */
    printf("%d %d %d\n", 3 && 4, 3 || 4, !5);
    printf("%d\n", 1 && 0 || 1);

    /* nested, mixed */
    calls = 0;
    r = (tick(1) && tick(0)) || (tick(1) && tick(2));
    printf("%d calls=%d\n", r, calls);
    return 0;
}
