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
/* 01 -- every arithmetic, bitwise and shift operator, compound assignment,
   and pre/post increment and decrement. */
int main(void) {
    int a;
    int b;
    int c;
    int i;
    int arr[4];

    a = 17; b = 5;
    printf("%d %d %d %d %d\n", a + b, a - b, a * b, a / b, a % b);
    printf("%d %d %d %d %d\n", -a, +b, ~a, !a, !0);
    printf("%d %d %d %d %d\n", a & b, a | b, a ^ b, a << 2, a >> 2);
    printf("%d %d %d %d %d %d\n", a < b, a <= b, a > b, a >= b, a == b, a != b);

    c = 10;
    c += 5;  printf("%d ", c);
    c -= 3;  printf("%d ", c);
    c *= 2;  printf("%d ", c);
    c /= 4;  printf("%d ", c);
    c %= 4;  printf("%d ", c);
    c <<= 3; printf("%d ", c);
    c >>= 1; printf("%d ", c);
    c &= 6;  printf("%d ", c);
    c |= 9;  printf("%d ", c);
    c ^= 5;  printf("%d\n", c);

    /* Each of these is printed on its own, because the order in which printf's
       arguments are evaluated is unspecified in C and a test must not depend
       on it. */
    i = 5;
    printf("%d ", i++); printf("%d\n", i);
    printf("%d ", ++i); printf("%d\n", i);
    printf("%d ", i--); printf("%d\n", i);
    printf("%d ", --i); printf("%d\n", i);

    /* a compound assignment must evaluate its target address exactly once:
       i is incremented once here, not twice */
    arr[0] = 0; arr[1] = 10; arr[2] = 20; arr[3] = 30;
    i = 1;
    arr[i++] += 2;
    printf("%d %d %d %d i=%d\n", arr[0], arr[1], arr[2], arr[3], i);

    /* negative division and remainder truncate toward zero */
    printf("%d %d %d %d\n", -7 / 2, -7 % 2, 7 / -2, 7 % -2);

    /* right shift of a negative value is arithmetic on the target */
    printf("%d\n", -16 >> 2);
    return 0;
}
