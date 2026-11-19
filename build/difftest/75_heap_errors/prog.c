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
/* 75 -- @no-gcc: the heap checks of the runtime (the same as irsim's):
   blocks are reused first-fit after free, realloc keeps the contents,
   free(NULL) is a no-op, and a double free stops the program with a
   message on stderr and exit status 70. */
int main(void) {
    char *a;
    char *b;
    char *c;
    int *v;
    int i;
    a = malloc(16);
    b = malloc(16);
    strcpy(a, "first");
    free(a);
    c = malloc(8);
    printf("reused: %d\n", c == a);
    v = malloc(4 * sizeof(int));
    for (i = 0; i < 4; i++) v[i] = i * 11;
    v = realloc(v, 100 * sizeof(int));
    printf("realloc kept: %d %d %d %d\n", v[0], v[1], v[2], v[3]);
    free(0);
    free(b);
    printf("about to free twice\n");
    free(b);
    printf("not reached\n");
    return 0;
}
