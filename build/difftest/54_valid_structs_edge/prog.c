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
/* 54 -- the corners of struct and union declarations: a tag declared before it
   is completed, two structs that point at each other, a struct that points at
   itself, tags declared inside a block, a tag spelled like a variable, nested
   struct and array members, and a union whose members are read through the one
   that was last written. */
struct Node;                     /* completed further down */

struct Edge {
    struct Node *to;             /* a pointer to an incomplete type is fine */
    int weight;
};

struct Node {
    int id;
    struct Node *next;           /* at itself */
    struct Edge out[3];          /* at the other, which points back */
    int nout;
};

/* A tag and an ordinary identifier may share a spelling: they live in
   different name spaces. */
struct Point { int x, y; };
int Point = 7;

struct Outer {
    struct Point corners[2];
    struct Inner { int a, b; } in;   /* a tag declared inside another struct */
    int grid[2][3];
};

union Number {
    int i;
    float f;
    struct Point p;
    char bytes[4];
};

int sumEdges(struct Node *n) {
    int i, s = 0;
    for (i = 0; i < n->nout; i++) s += n->out[i].weight;
    return s;
}

int chainLength(struct Node *n) {
    int k = 0;
    while (n) { k++; n = n->next; }
    return k;
}

struct Point addPoints(struct Point a, struct Point b) {
    struct Point r;
    r.x = a.x + b.x;
    r.y = a.y + b.y;
    return r;
}

int main(void) {
    struct Node a, b, c;
    struct Outer o;
    union Number u;
    struct Point p, q, r;
    int i, j;

    /* build a chain a -> b -> c and give a two out-edges */
    c.id = 3; c.next = 0;  c.nout = 0;
    b.id = 2; b.next = &c; b.nout = 0;
    a.id = 1; a.next = &b; a.nout = 2;
    a.out[0].to = &b; a.out[0].weight = 10;
    a.out[1].to = &c; a.out[1].weight = 32;

    printf("%d %d %d\n", chainLength(&a), sumEdges(&a), a.out[1].to->id);
    printf("%d %d\n", a.next->next->id, a.out[0].to->next->id);

    /* the tag and the variable called Point do not collide */
    printf("%d %d\n", Point, (int)sizeof(struct Point));

    /* nested members, and an array member of an array member */
    o.corners[0].x = 1; o.corners[0].y = 2;
    o.corners[1].x = 3; o.corners[1].y = 4;
    o.in.a = 5; o.in.b = 6;
    for (i = 0; i < 2; i++)
        for (j = 0; j < 3; j++) o.grid[i][j] = i * 10 + j;
    printf("%d %d %d %d\n", o.corners[0].x, o.corners[1].y, o.in.a + o.in.b,
           o.grid[1][2]);

    /* a struct member copied whole out of a nested position */
    p = o.corners[0];
    q = o.corners[1];
    r = addPoints(p, q);
    printf("%d %d\n", r.x, r.y);

    /* a struct inside a union, read back through the member just written */
    u.p.x = 11; u.p.y = 22;
    printf("%d %d\n", u.p.x, u.p.y);
    u.i = 1234;
    printf("%d\n", u.i);
    u.f = 2.5f;
    printf("%.3f\n", (double)u.f);
    /* the sum of the bytes does not depend on which end they are stored from */
    u.i = 0;
    for (i = 0; i < 4; i++) u.bytes[i] = i + 1;
    j = 0;
    for (i = 0; i < 4; i++) j += u.bytes[i];
    printf("%d\n", j);

    /* a tag declared inside a block hides the file-scope one of that name */
    {
        struct Point { double x, y, z; };     /* a different type, same tag */
        struct Point local;
        local.x = 1.5; local.y = 2.5; local.z = 3.5;
        printf("%.2f\n", local.x + local.y + local.z);
    }
    /* outside the block the file-scope struct Point is visible again */
    p.x = 100; p.y = 200;
    printf("%d\n", p.x + p.y);

    /* a self-assignment and a copy through a pointer */
    q = q;
    {
        struct Point *pp = &p;
        q = *pp;
        *pp = r;
    }
    printf("%d %d %d %d\n", q.x, q.y, p.x, p.y);
    return 0;
}
