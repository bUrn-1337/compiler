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
/* 16 -- goto and labels: backward jumps, forward jumps to a label defined
   later in the function, breaking out of nested loops, and a label on the
   statement that follows a loop. */
int main(void) {
    int i;
    int j;
    int n;
    int found;

    /* a backward goto makes a loop */
    i = 0;
again:
    i = i + 1;
    if (i < 5) goto again;
    printf("backward i=%d\n", i);

    /* a forward goto skips code */
    n = 0;
    goto skip;
    n = 999;                 /* never executed */
skip:
    printf("forward n=%d\n", n);

    /* goto escaping two nested loops at once */
    found = 0;
    for (i = 0; i < 5; i = i + 1)
        for (j = 0; j < 5; j = j + 1)
            if (i * j == 6) { found = i * 10 + j; goto out; }
out:
    printf("found=%d\n", found);

    /* a label immediately before the end of the function body */
    i = 0;
loop:
    if (i < 3) { printf("i%d ", i); i = i + 1; goto loop; }
    printf("\n");

    /* two labels in a row, and a goto into the middle of an if's else */
    n = 1;
    if (n) goto there;
    printf("not reached\n");
there:
here:
    printf("done\n");
    if (0) goto here;        /* a label that is targeted but never taken */
    return 0;
}
