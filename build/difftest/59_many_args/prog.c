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
/* 59 -- calls with more than ten arguments, and with int, char, float and
   double arguments mixed in every order (alignment of the doubles in the
   argument area), plus float/double results and the same calls through a
   function pointer. */
int sum12(int a, int b, int c, int d, int e, int f, int g, int h,
          int i, int j, int k, int l) {
    return a + 2*b + 3*c + 4*d + 5*e + 6*f + 7*g + 8*h + 9*i + 10*j + 11*k + 12*l;
}

double mix(int a, double b, char c, float d, int e, double f, float g, char h,
           double i, int j, float k) {
    printf("  a=%d b=%g c=%c d=%g e=%d f=%g g=%g h=%c i=%g j=%d k=%g\n",
           a, b, c, d, e, f, g, h, i, j, k);
    return a + b + c + d + e + f + g + h + i + j + k;
}

float fmix(float a, int b, float c, double d, float e) {
    return a * b + c - (float)d * e;
}

double dd(double a, double b, double c, double d, double e, double f) {
    return a - b + c - d + e - f;
}

char cc(char a, char b, char c, char d, char e, char f, char g) {
    return a + b + c + d + e + f + g;
}

int count(int n, int a0, int a1, int a2, int a3, int a4, int a5, int a6, int a7,
          int a8, int a9, int a10, int a11, int a12, int a13) {
    int t;
    t = a0 ^ a1 ^ a2 ^ a3 ^ a4 ^ a5 ^ a6 ^ a7 ^ a8 ^ a9 ^ a10 ^ a11 ^ a12 ^ a13;
    if (n == 0) return t;
    /* recursive call with the arguments rotated */
    return t + count(n - 1, a13, a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12);
}

int main(void) {
    double (*pm)(int, double, char, float, int, double, float, char, double, int, float);
    int (*ps)(int, int, int, int, int, int, int, int, int, int, int, int);
    double r;
    printf("sum12 = %d\n", sum12(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12));
    r = mix(1, 2.5, 'A', 3.25f, -4, 1e10, 0.125f, 'z', -7.75, 100, 1.5f);
    printf("mix = %.4f\n", r);
    pm = mix;
    ps = sum12;
    r = pm(-1, -2.5, '0', -3.25f, 4, -1e10, -0.125f, '9', 7.75, -100, -1.5f);
    printf("mix via pointer = %.4f\n", r);
    printf("sum12 via pointer = %d\n", ps(12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1));
    printf("fmix = %.6f\n", fmix(1.5f, 3, 0.25f, 2.0, 0.5f));
    printf("dd = %.3f\n", dd(1.5, 2.25, 3.125, 4.0625, 5.03125, 6.015625));
    printf("cc = %d\n", cc(10, 20, 30, 40, 50, 60, 70));
    printf("count = %d\n", count(20, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192));
    printf("nested = %d\n", sum12(sum12(1,1,1,1,1,1,1,1,1,1,1,1), 2, 3, 4, 5, 6, 7, 8, 9, 10, 11,
                                 sum12(0,0,0,0,0,0,0,0,0,0,0,1)));
    return 0;
}
