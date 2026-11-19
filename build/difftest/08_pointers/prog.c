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
/* 08 -- pointers: address-of, dereference, pointer arithmetic (scaled by the
   element size), pointer difference, multi-level pointers, and *p++. */
int g = 100;
int *gp = &g;

void setTo(int *p, int v) { *p = v; }
void swap(int *a, int *b) { int t; t = *a; *a = *b; *b = t; }

int main(void) {
    int x;
    int y;
    int *p;
    int *q;
    int **pp;
    int ***ppp;
    int a[6] = {0, 10, 20, 30, 40, 50};
    char s[6] = "abcde";
    char *cp;
    int i;

    x = 1; y = 2;
    p = &x;
    printf("%d %d\n", *p, x);
    *p = 7;
    printf("%d\n", x);

    pp = &p;
    printf("%d\n", **pp);
    **pp = 9;                       /* one load, then a store */
    printf("%d\n", x);

    ppp = &pp;
    printf("%d\n", ***ppp);
    ***ppp = 11;
    printf("%d\n", x);

    /* a pointer can be repointed */
    p = &y;
    printf("%d %d\n", *p, **pp);

    /* pointer arithmetic scales by the element size */
    p = a;
    printf("%d %d %d\n", *p, *(p + 3), p[5]);
    q = a + 4;
    printf("%d %d\n", *q, (int)(q - p));
    printf("%d\n", (int)(&a[5] - &a[2]));

    /* &arr[2] is the same as arr + 2 */
    q = &a[2];
    printf("%d %d\n", *q, (int)(q - a));

    /* *p++ reads through p and then advances p */
    p = a;
    printf("%d ", *p++);
    printf("%d ", *p++);
    printf("%d\n", *p);

    /* ++*p increments the pointed-to object */
    p = a;
    ++*p;
    printf("%d\n", a[0]);

    /* (*p)++ likewise, and *p += n */
    (*p)++;
    *p += 5;
    printf("%d\n", a[0]);

    /* char pointers walk one byte at a time */
    cp = s;
    for (i = 0; i < 5; i = i + 1) printf("%c", *cp++);
    printf("\n");
    cp = s;
    printf("%d %d\n", *cp, cp[4]);

    /* pointer comparison and null */
    p = 0;
    printf("%d %d\n", p == 0, a != 0);
    p = a;
    q = a + 2;
    printf("%d %d %d\n", p < q, p == a, q > p);

    /* pointers as arguments */
    setTo(&x, 42);
    printf("%d\n", x);
    swap(&x, &y);
    printf("%d %d\n", x, y);

    /* a global pointer initialised with an address */
    printf("%d\n", *gp);
    *gp = 101;
    printf("%d\n", g);

    /* a pointer to a pointer as a function argument */
    p = &x;
    pp = &p;
    setTo(*pp, 55);
    printf("%d\n", x);
    return 0;
}
