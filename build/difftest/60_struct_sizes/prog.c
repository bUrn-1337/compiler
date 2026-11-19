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
/* 60 -- structs passed and returned by value at sizes 1, 4, 8, 12 and 20
   bytes, and one with a double member (size 16, alignment 8): the callee
   gets a copy, a returned struct can be used directly, and arrays of them
   are copied element by element. */
struct S1  { char c; };
struct S4  { char a; char b; char c; char d; };
struct S8  { int a; int b; };
struct S12 { int a; char b; int c; };
struct S20 { int v[5]; };
struct SD  { char tag; double d; };
struct Big { struct S12 x; struct SD y; struct S1 z; };

struct S1 mk1(char c) { struct S1 s; s.c = c; return s; }
struct S4 mk4(int a, int b, int c) { struct S4 s; s.a = a; s.b = b; s.c = c; s.d = a + c; return s; }
struct S8 swap8(struct S8 s) { int t; t = s.a; s.a = s.b; s.b = t; return s; }
struct S12 add12(struct S12 p, struct S12 q) {
    struct S12 r;
    r.a = p.a + q.a; r.b = p.b + q.b; r.c = p.c + q.c;
    p.a = 999;                       /* the caller's copy must not change */
    return r;
}
struct S20 rev20(struct S20 s) {
    struct S20 r;
    int i;
    for (i = 0; i < 5; i++) r.v[i] = s.v[4 - i];
    return r;
}
struct SD halve(struct SD s) { s.d = s.d / 2; s.tag = s.tag + 1; return s; }
int sum20(struct S20 s) { int i, t; t = 0; for (i = 0; i < 5; i++) t = t + s.v[i]; return t; }

/* a struct argument after a char and before a double (argument alignment) */
double after(char c, struct SD s, double d, struct S1 one) {
    return c + s.tag + s.d + d + one.c;
}

struct Big mkbig(int k) {
    struct Big b;
    b.x.a = k; b.x.b = k + 1; b.x.c = k + 2;
    b.y.tag = 'a' + k; b.y.d = k * 1.5;
    b.z = mk1('A' + k);
    return b;
}

int main(void) {
    struct S1 a1;
    struct S4 a4;
    struct S8 a8;
    struct S12 p, q, r;
    struct S20 v, w;
    struct SD d, e;
    struct Big arr[3];
    struct Big b;
    int i;

    printf("sizes %d %d %d %d %d %d %d\n", sizeof(struct S1), sizeof(struct S4), sizeof(struct S8),
           sizeof(struct S12), sizeof(struct S20), sizeof(struct SD), sizeof(struct Big));
    a1 = mk1('x');
    printf("S1 %c %c\n", a1.c, mk1('y').c);
    a4 = mk4(-300, 7, -8);
    printf("S4 %d %d %d %d\n", a4.a, a4.b, a4.c, a4.d);
    a8.a = 1; a8.b = 2;
    a8 = swap8(a8);
    printf("S8 %d %d\n", a8.a, a8.b);
    p.a = 1; p.b = 2; p.c = 3;
    q.a = 10; q.b = 20; q.c = 30;
    r = add12(p, q);
    printf("S12 %d %d %d (p.a still %d)\n", r.a, r.b, r.c, p.a);
    r = add12(add12(p, q), add12(q, q));
    printf("S12 nested %d %d %d\n", r.a, r.b, r.c);
    for (i = 0; i < 5; i++) v.v[i] = i * i;
    w = rev20(v);
    printf("S20 %d %d %d %d %d sum %d %d\n", w.v[0], w.v[1], w.v[2], w.v[3], w.v[4],
           sum20(w), sum20(rev20(rev20(v))));
    d.tag = 'k'; d.d = 3.0;
    e = halve(halve(d));
    printf("SD %c %.4f -> %c %.4f\n", d.tag, d.d, e.tag, e.d);
    printf("after %.3f\n", after(1, d, 0.5, a1));
    for (i = 0; i < 3; i++) arr[i] = mkbig(i);
    b = arr[2];
    arr[2] = arr[0];
    arr[0] = b;
    for (i = 0; i < 3; i++)
        printf("Big[%d] %d %d %d %c %.2f %c\n", i, arr[i].x.a, arr[i].x.b, arr[i].x.c,
               arr[i].y.tag, arr[i].y.d, arr[i].z.c);
    printf("field of call %d %.1f\n", mkbig(7).x.c, mkbig(4).y.d);
    return 0;
}
