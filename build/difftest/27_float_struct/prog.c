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
/* 27 -- float and double members, parameters and return values: structs
   holding floating members, functions taking and returning them, and
   conversions at the argument and return boundary.
   The sizes and offsets of a struct holding a double are deliberately not
   printed: our target aligns double to 8, 32-bit x86 to 4 (docs/REPORT.md). */
struct P { double x; double y; float w; int n; };
struct Stat { int count; double total; };

struct P gp = { 1.5, 2.5, 0.5f, 3 };

double scale(double v, float k) { return v * k; }
float  half(float v)            { return v / 2.0f; }
double dot(struct P *p, struct P *q) { return p->x * q->x + p->y * q->y; }
double avg(struct Stat *s)      { return s->count ? s->total / s->count : 0.0; }

/* a double parameter receiving an int, and an int return from a double */
double thirds(int n) { return n / 3.0; }
int    rounded(double v) { return (int)(v + 0.5); }

void add(struct Stat *s, double v) { s->count++; s->total += v; }

int main(void) {
    struct P a;
    struct P b;
    struct Stat st;
    struct P *pp;
    int i;

    a.x = 1.5; a.y = 2.5; a.w = 0.5f; a.n = 3;
    b.x = 2.0; b.y = 4.0; b.w = 1.5f; b.n = 4;
    printf("%.3f\n", dot(&a, &b));
    printf("%.3f %d\n", (double)a.w + (double)b.w, a.n + b.n);

    pp = &a;
    pp->x += 0.5;
    pp->w *= 2.0f;
    printf("%.3f %.3f\n", a.x, (double)a.w);

    printf("%.4f %.4f\n", scale(2.5, 1.5f), (double)half(3.5f));
    printf("%.4f %.4f\n", scale(2, 2), thirds(7));   /* int arguments convert */
    printf("%d %d\n", rounded(2.4), rounded(2.6));

    st.count = 0; st.total = 0.0;
    for (i = 1; i <= 4; i++) add(&st, (double)i * 1.5);
    printf("%d %.3f %.3f\n", st.count, st.total, avg(&st));

    printf("%.3f %.3f %.3f %d\n", gp.x, gp.y, (double)gp.w, gp.n);
    printf("%d %d\n", (int)sizeof(double), (int)sizeof(gp.w));
    return 0;
}
