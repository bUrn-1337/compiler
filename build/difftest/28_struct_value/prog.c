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
/* 28 -- structs and unions passed and returned by value: the callee writes to
   its own copy, a struct is assigned through a pointer and from one, a struct
   assigned to itself must survive, and a member is read straight out of a
   returned value. */
struct Point { int x; int y; };
struct Inner { int a[3]; char c; };
struct Outer { struct Point p; struct Inner in; int tail; };
union U { int i; char b[4]; };

struct Point mk(int x, int y) { struct Point p; p.x = x; p.y = y; return p; }
struct Point addp(struct Point a, struct Point b) {
    a.x = a.x + b.x;          /* writes to the callee's own copy */
    a.y = a.y + b.y;
    return a;
}
int sumInner(struct Inner q) {
    int i, s = 0;
    for (i = 0; i < 3; i++) s = s + q.a[i];
    q.a[0] = 999;             /* must not be visible to the caller */
    return s + q.c;
}
struct Outer bump(struct Outer o) { o.tail = o.tail + 1; o.p.x = o.p.x + 10; return o; }

int main(void) {
    struct Point a, b, c;
    struct Outer o, o2;
    struct Inner in;
    union U u, v;
    struct Point arr[3];
    struct Point *pp;
    int i;

    a = mk(1, 2);
    b = mk(30, 40);
    c = addp(a, b);
    printf("a=%d,%d b=%d,%d c=%d,%d\n", a.x, a.y, b.x, b.y, c.x, c.y);

    a = a;                                  /* self-assignment must be safe */
    printf("self a=%d,%d\n", a.x, a.y);

    pp = &b;
    *pp = a;                                /* *p = s */
    printf("b=%d,%d\n", b.x, b.y);
    c = *pp;                                /* s = *p */
    printf("c=%d,%d\n", c.x, c.y);

    in.a[0] = 5; in.a[1] = 6; in.a[2] = 7; in.c = 'A';
    printf("sumInner=%d in.a[0]=%d\n", sumInner(in), in.a[0]);

    o.p = mk(3, 4);
    o.in = in;
    o.tail = 100;
    o2 = bump(o);
    printf("o.tail=%d o2.tail=%d o.p.x=%d o2.p.x=%d o2.in.a[1]=%d\n",
           o.tail, o2.tail, o.p.x, o2.p.x, o2.in.a[1]);

    printf("direct=%d,%d\n", mk(7, 8).x, addp(mk(1,1), mk(2,2)).y);

    u.i = 0;
    u.b[0] = 1; u.b[1] = 2;
    v = u;
    printf("v.b=%d,%d v.i=%d\n", v.b[0], v.b[1], v.i == u.i);

    for (i = 0; i < 3; i++) arr[i] = mk(i, i * i);
    for (i = 0; i < 3; i++) printf("arr[%d]=%d,%d\n", i, arr[i].x, arr[i].y);

    { struct Point d = c;                   /* initialization from a struct */
      struct Point e = mk(9, 9);
      printf("d=%d,%d e=%d,%d\n", d.x, d.y, e.x, e.y); }
    return 0;
}
