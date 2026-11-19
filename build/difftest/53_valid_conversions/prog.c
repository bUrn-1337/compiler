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
/* 53 -- the conversions a program performs without a cast: char and enum to
   int, int to double at assignment, argument, return and comparison, the
   usual arithmetic conversions in mixed expressions, and the truncation that
   an assignment to a narrower type performs.  Every value stays inside the
   range of its type, so nothing here overflows. */
enum Size { SMALL = 1, MEDIUM = 10, LARGE = 100 };

double asDouble(double v) { return v; }
int    asInt(int v)       { return v; }
char   asChar(char v)     { return v; }
double ratio(int a, int b) { return (double)a / b; }
int    truncate(double v) { return v; }      /* the return converts */

struct Mixed { char c; int i; double d; float f; };

int main(void) {
    char   c = 'A';
    char   small = 100;
    int    i = 1000;
    double d = 2.5;
    float  f = 1.5f;
    enum Size s = MEDIUM;
    struct Mixed m;
    double acc;
    int    k;

    /* char and enum behave as int in an expression */
    printf("%d %d %d\n", c + 1, c * 2, s + 1);
    printf("%d %d %d\n", small + small, (int)s * 3, SMALL + MEDIUM + LARGE);
    printf("%c %c\n", c + 2, 'a' - 32);

    /* int to double at an assignment, an argument and a return */
    d = i;
    printf("%.3f %.3f %.3f\n", d, asDouble(i), ratio(7, 2));
    d = 2.5;
    printf("%.3f %.3f\n", asDouble(c), asDouble(s));

    /* double to int: the fractional part is dropped, toward zero */
    k = d;
    printf("%d %d %d\n", k, truncate(9.99), truncate(-9.99));
    printf("%d %d\n", asInt(2.75), asInt(-2.75));

    /* float to int likewise, without widening to double on the way */
    k = f;
    printf("%d %d %d\n", k, (int)f, (int)(f * 3));
    printf("%d %d\n", (int)(f + 0.75f), (int)(-f));

    /* float and double in the same expression: float widens */
    printf("%.4f %.4f %.4f\n", f + d, f * 2, d / f);
    printf("%d %d\n", f < d, f + f == 3.0);

    /* char assigned from an int expression keeps the low byte, in range */
    c = i % 100 + 'a';
    printf("%c %d\n", c, (int)c);
    small = asChar(120);
    printf("%d %d\n", small, small + 7);

    /* the members of a struct convert on assignment, each to its own type */
    m.c = 65; m.i = 2.9; m.d = 3; m.f = 1;
    printf("%c %d %.3f %.3f\n", m.c, m.i, m.d, (double)m.f);
    m.i = m.d * 2;
    m.d = m.i;
    m.f = m.d / 4;
    printf("%d %.3f %.3f\n", m.i, m.d, (double)m.f);

    /* a mixed accumulation: int, char, enum and double together */
    acc = 0.0;
    for (k = 1; k <= 4; k++) acc += k * 0.5 + c / 100.0 + s;
    printf("%.4f\n", acc);

    /* comparisons across types */
    printf("%d %d %d %d\n", i > d, c == 'i', s != LARGE, f <= 1.5);
    printf("%d %d\n", 'a' < 'b', (int)(d > f) + (int)(i > (int)s));

    /* division: integer and floating, with a negative operand */
    printf("%d %d %d\n", 7 / 2, -7 / 2, -7 % 2);
    printf("%.4f %.4f\n", 7 / 2.0, -7 / 2.0);
    printf("%.4f %d\n", (double)(7 / 2), (int)(7 / 2.0));
    return 0;
}
