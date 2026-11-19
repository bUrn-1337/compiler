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
/* 06 -- int and char arrays, array initializers (complete, partial and from a
   string literal), and arrays decaying to pointers when passed to a function. */
int gi[5] = {1, 2, 3, 4, 5};
int gpartial[6] = {7, 8};
int gzero[4];
char gmsg[8] = "glob";
char gstr[] = "auto";

int total(int *v, int n) {
    int i;
    int s;
    s = 0;
    for (i = 0; i < n; i = i + 1) s = s + v[i];
    return s;
}

void bump(int v[], int n) {           /* an array parameter IS a pointer */
    int i;
    for (i = 0; i < n; i = i + 1) v[i] = v[i] + 1;
}

int main(void) {
    int a[5] = {10, 20, 30, 40, 50};
    int part[5] = {1, 2};             /* the rest is zero-filled */
    char buf[8] = "hi";
    char letters[4];
    int i;

    for (i = 0; i < 5; i = i + 1) printf("%d ", a[i]);
    printf("\n");
    for (i = 0; i < 5; i = i + 1) printf("%d ", part[i]);
    printf("\n");
    for (i = 0; i < 6; i = i + 1) printf("%d ", gpartial[i]);
    printf("\n");
    for (i = 0; i < 4; i = i + 1) printf("%d ", gzero[i]);
    printf("\n");

    printf("%s %s %s %s\n", buf, gmsg, gstr, "literal");
    printf("%d %d %d\n", (int)sizeof a, (int)sizeof buf, (int)sizeof gstr);

    letters[0] = 'o'; letters[1] = 'k'; letters[2] = '!'; letters[3] = 0;
    printf("%s\n", letters);

    printf("%d %d\n", total(a, 5), total(gi, 5));
    bump(a, 5);
    printf("%d %d\n", a[0], a[4]);

    /* writing through a subscript on the left, reading on the right */
    a[2] = a[0] + a[4];
    printf("%d\n", a[2]);

    /* An array name decays to a pointer when passed, so inside total() sizeof
       would give the pointer size.  The exact pointer size is 4 in this
       compiler's target model but 8 on a 64-bit host, so this test compares
       only host-independent sizes; see docs/IR-DESIGN.md for the type sizes. */
    return 0;
}
