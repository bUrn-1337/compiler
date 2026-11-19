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
/* 62 -- integer corner cases: division and remainder truncate toward zero
   for every sign combination, arithmetic right shift of negatives, shifts
   by 0 and 31, 32-bit wraparound, char is signed (char c = 200 is -56),
   char arithmetic promotes to int, and conversions to char truncate. */
int main(void) {
    int a[4];
    int b[3];
    int i, j, x, big;
    char c, d;
    a[0] = 7; a[1] = -7; a[2] = 100; a[3] = -100;
    b[0] = 2; b[1] = -2; b[2] = 3;
    for (i = 0; i < 4; i++)
        for (j = 0; j < 3; j++)
            printf("%4d / %2d = %3d   %4d %% %2d = %3d\n", a[i], b[j], a[i] / b[j], a[i], b[j], a[i] % b[j]);
    x = -17;
    printf("shifts %d %d %d %d %d\n", x >> 1, x >> 4, x >> 31, x << 3, x >> 0);
    printf("shifts %d %d %d\n", 1 << 31, (1 << 31) >> 31, 0x40000000 << 1);
    x = 1;
    for (i = 0; i < 32; i++) x = x * 3;
    printf("3^32 wrapped = %d\n", x);
    big = 2147483647;
    printf("max+1 = %d, min-1 = %d, -min = %d\n", big + 1, (-big - 1) - 1, -(-big - 1));
    printf("mul wrap = %d\n", 65537 * 65537);
    c = 200;
    d = c;
    printf("char c = 200 -> %d; c + 1 = %d; c/2 = %d; c>>1 = %d\n", c, c + 1, c / 2, c >> 1);
    c = 127;
    c = c + 1;
    printf("127 + 1 as char = %d\n", c);
    c = 'A' + 300;
    printf("'A'+300 as char = %d\n", c);
    i = 0x12345678;
    c = i;
    printf("int -> char %d, low half %d\n", c, i & 0xffff);
    c = -1;
    printf("char -1 = %d, & 0xff = %d\n", c, c & 0xff);
    printf("hex %x %X %o, neg as %%u %u\n", 255, 0xabcdef, 8, -1);
    printf("compare %d %d %d %d\n", -1 < 1, d < 0, (char)200 == -56, (1 << 31) < 0);
    printf("logic %d %d %d %d\n", !5, !0, ~0, ~-1);
    printf("bitops %d %d %d\n", 0x0f0f & 0x00ff, 0x0f0f | 0xf000, 0x0f0f ^ 0xffff);
    x = 10;
    x += 5; x -= 3; x *= 4; x /= 5; x %= 7; x <<= 3; x >>= 1; x &= 0x1c; x |= 1; x ^= 3;
    printf("compound = %d\n", x);
    x = 5;
    i = x++;
    j = ++x;
    printf("pre/post %d %d %d\n", i, j, x);
    i = x--;
    j = --x;
    printf("pre/post %d %d %d\n", i, j, x);
    return 255 & -3;
}
