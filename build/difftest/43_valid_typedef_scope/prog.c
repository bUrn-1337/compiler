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
/* 43 -- typedef names and scope: a typedef name reused as an ordinary
   identifier in an inner scope, a typedef of a typedef, a typedef name
   redefined to a different type inside a block, and a struct tag that shares
   its spelling with a typedef name. */
typedef int Count;
typedef Count Tally;              /* a typedef of a typedef */
typedef double Real;
typedef char *Text;
typedef struct Pair Pair;         /* the tag and the typedef share a spelling */
struct Pair { Count a; Count b; };
typedef Pair PairAlias;
typedef int (*Op)(Count, Count);

Count gcount = 5;
Real  gratio = 1.25;

Count addc(Count a, Count b) { return a + b; }

int useInner(void) {
    int Count = 11;               /* an ordinary variable named like the typedef */
    int Real;
    Real = Count * 2;
    return Count + Real;          /* 33 */
}

/* a parameter named like a typedef hides it inside the body */
int param(int Count, Real Text) {
    Count = Count + 1;
    Text = Text * 2.0;
    return Count + (int)Text;
}

/* members and labels have namespaces of their own, so they may be spelled
   like a typedef name */
struct Holder { int Count; Real Real; };

int labelled(int n) {
    struct Holder h;
    struct Holder *ph = &h;
    h.Count = n;
    ph->Real = 0.5;
    if (n > 0) goto Count;
    return -1;
Count:
    return h.Count + (int)(ph->Real * 4.0) + (int)h.Real;
}

int redefine(void) {
    typedef double Count;         /* a different type with the same name here */
    Count x = 2.5;                /* so this is a double */
    typedef Count Same;
    Same y = x * 2.0;
    return (int)(x + y);          /* 7 */
}

int main(void) {
    Count c = 3;
    Tally t = 4;
    Real  r = 0.5;
    Text  s = "typedefs";
    Pair  p;
    PairAlias q;
    struct Pair sp;
    Op    op = addc;
    Real  table[3];
    int   i;

    p.a = c; p.b = t;
    q = p;                        /* the alias names the same type */
    sp.a = 9; sp.b = 1;
    printf("%d %d %d %.3f %s\n", c + t, p.a + p.b, q.b, r, s);
    printf("%d %d\n", sp.a + sp.b, op(c, t));
    printf("%d %d\n", useInner(), redefine());
    printf("%d %d\n", param(4, 2.5), labelled(6));

    for (i = 0; i < 3; i++) table[i] = i * gratio;
    printf("%.3f %.3f %.3f %d\n", table[0], table[1], table[2], gcount);

    /* the typedef name is still a type out here */
    {
        Count deeper = 100;
        Tally deeper2 = deeper + 1;
        printf("%d %d\n", deeper, deeper2);
    }
    {
        Pair *pq = &p;
        Text *ps = &s;
        printf("%d %s\n", pq->a, *ps);
    }
    printf("%d %d %d\n", (int)sizeof(Count), (int)sizeof(Real),
           (int)sizeof(struct Pair));
    return 0;
}
