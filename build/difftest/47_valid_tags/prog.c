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
/* 47 -- struct, union and enum tags: a tag redefined in an inner scope, tags
   declared inside a function, a forward declaration completed later, a tag
   that shares its spelling with a typedef name and with a variable, and
   enumerators with and without explicit values. */
struct S { int a; int b; };
struct Fwd;                        /* completed below */
struct List { int v; struct List *next; };
union  U { int i; char c; };
enum   Color { RED, GREEN = 5, BLUE, LAST = 100 };
enum   Flag { OFF, ON };

struct Fwd { double d; int n; };

typedef struct S S;                /* the typedef and the tag share a name */
int S_count = 0;                   /* and so does an ordinary variable */

struct Both { enum Color c; union U u; struct S s; };

int useFwd(struct Fwd *f) { return f->n + (int)f->d; }

int shadowTag(void) {
    struct S { double x; double y; };   /* a different struct S, here only */
    struct S inner;
    inner.x = 1.5; inner.y = 2.5;
    return (int)(inner.x + inner.y);
}

int localTag(void) {
    struct Local { int p; int q; } L;
    union  Pick { int i; char b[4]; } pick;
    enum   Side { LEFT = 2, RIGHT } side;
    L.p = 3; L.q = 4;
    pick.i = 0; pick.b[0] = 1;
    side = RIGHT;
    return L.p * L.q + pick.b[0] + (int)side;
}

int main(void) {
    struct S outer;
    S        alias;                /* through the typedef */
    struct Fwd f;
    struct List n1;
    struct List n2;
    union  U u;
    enum   Color c;
    enum   Flag fl;
    struct Both both;
    int i;

    outer.a = 1; outer.b = 2;
    alias.a = 10; alias.b = 20;
    S_count = outer.a + alias.a;
    printf("%d %d %d\n", outer.a + outer.b, alias.a + alias.b, S_count);

    f.d = 2.75; f.n = 4;
    printf("%d\n", useFwd(&f));

    n2.v = 2; n2.next = 0;
    n1.v = 1; n1.next = &n2;
    printf("%d %d %d\n", n1.v, n1.next->v, n1.next->next == 0);

    u.i = 0; u.c = 'z';
    printf("%c %d\n", u.c, u.i != 0);

    printf("%d %d %d %d\n", RED, GREEN, BLUE, LAST);
    for (c = RED, i = 0; i < 2; i++, c = GREEN) printf("c=%d ", (int)c);
    printf("\n");
    fl = ON;
    printf("%d %d %d\n", (int)fl, OFF, fl == ON);

    both.c = BLUE; both.u.i = 7; both.s.a = 8; both.s.b = 9;
    printf("%d %d %d\n", (int)both.c, both.u.i, both.s.a + both.s.b);

    printf("%d %d\n", shadowTag(), localTag());
    printf("%d %d %d\n", (int)sizeof(struct S), (int)sizeof(union U),
           (int)sizeof(enum Color));

    /* the inner scope sees its own tag; the outer one is untouched */
    {
        struct S { char tiny; };
        struct S t;
        t.tiny = 'q';
        printf("%c %d\n", t.tiny, (int)sizeof(struct S));
    }
    printf("%d %d\n", (int)sizeof(struct S), outer.b);
    return 0;
}
