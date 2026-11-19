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
/* 71 -- floating point: int <-> float <-> double conversions (truncation
   toward zero, negatives, the int limits, char 200 = -56), single
   precision rounding kept separate from double, float/double parameters
   and returns, NaN and -0.0 in comparisons and conditions, ++/--/op= on
   doubles and floats, mixed ternaries, and an accumulation loop whose
   result depends on every rounding step. */
union bits { double d; int w[2]; };

float fhalf(float x) { return x / 2; }
double dmix(int i, float f, double d, char c) { return i + f + d + c; }
float fsum(float *a, int n) {
    float s;
    int i;
    s = 0;
    for (i = 0; i < n; i++) s += a[i];
    return s;
}
int trunc_i(double d) { return (int)d; }

int main(void) {
    double d, zero, nz, nan, big;
    float f, g;
    int i, k;
    char c;
    float fa[10];
    union bits u;
    zero = 0.0;
    nz = -zero;
    u.w[0] = 0; u.w[1] = 0x7ff80000; nan = u.d;
    printf("trunc: %d %d %d %d %d %d\n", trunc_i(2.9), trunc_i(-2.9), trunc_i(0.999999),
           trunc_i(-0.5), trunc_i(2147483647.0), trunc_i(-2147483648.0));
    printf("to double: %.1f %.1f %.1f %.1f\n", (double)2147483647, (double)(-2147483647 - 1),
           (double)-7, (double)(char)200);
    c = 200;
    d = c;
    i = c;
    printf("char 200: %d %.1f %d\n", c, d, i);
    c = 65.7;
    printf("double->char: %d %c\n", c, c);
    c = -1.5;
    printf("double->char neg: %d\n", c);
    f = 0.1;
    d = 0.1;
    printf("0.1 float %.17g double %.17g equal %d\n", f, d, f == d);
    f = 16777216.0;
    g = f + 1;
    printf("float 2^24+1 = %.1f, double %.1f\n", g, (double)f + 1);
    f = 1.0 / 3.0;
    printf("float 1/3 %.10f, x3 %.10f, half %.10f\n", f, f * 3, fhalf(f));
    printf("dmix %.6f\n", dmix(1, 2.5, 3.25, 'A'));
    for (k = 0; k < 10; k++) fa[k] = k * 0.1;
    printf("fsum %.9g\n", fsum(fa, 10));
    d = 0;
    for (k = 0; k < 1000; k++) d += 0.001;
    printf("acc %.17g\n", d);
    d = 1;
    for (k = 0; k < 60; k++) d = d * 1.5 - 0.25;
    printf("grow %.17g\n", d);
    d = 5.5;
    d++; d++; d--;
    d *= 2; d -= 0.5; d /= 4;
    f = 1.5; f++; f *= 3;
    printf("ops %.4f %.4f %.4f\n", d, f, -d);
    printf("nan: %d %d %d %d %d %d\n", nan == nan, nan != nan, nan < 1, nan > 1, nan <= nan, !nan);
    if (nan) printf("nan is true\n");
    printf("-0: %d %d %d %.1f\n", nz == zero, nz < zero, !nz, 1 / nz);
    if (nz) printf("wrong\n"); else printf("-0 is false\n");
    big = 1e308;
    printf("overflow %g %g\n", big * 10, -big * 10);
    printf("underflow %g\n", 1e-308 / 1e10);
    i = 7;
    printf("ternary %.2f %.2f\n", i > 5 ? i : 0.5, i < 5 ? i : 0.5);
    printf("int div vs fp: %d %.4f %.4f\n", 7 / 2, 7 / 2.0, (double)7 / 2);
    printf("cmp: %d %d %d\n", 0.1 + 0.2 == 0.3, 0.5 + 0.25 == 0.75, (float)0.1 == (float)(0.05 * 2));
    printf("sizes %d %d\n", sizeof(float), sizeof(double));
    return (int)(d * 10);
}
