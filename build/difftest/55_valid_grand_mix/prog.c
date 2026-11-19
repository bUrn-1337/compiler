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
/* 55 -- everything the three new features add, in one program: a typedef'd
   function-pointer type used in a dispatch table, structs of doubles passed
   and returned by value, a comparator passed to a sorting routine, typedef
   names reused as ordinary identifiers in inner scopes, nested casts and
   chains of conditional expressions. */
typedef double Real;
typedef struct Vec3 { Real x, y, z; } Vec3;
typedef Real (*Reduce)(Vec3);          /* a function pointer over the struct */
typedef int  (*Cmp)(Real, Real);
typedef Vec3 (*Combine)(Vec3, Vec3);

struct Op {
    char   tag;
    Reduce fn;                          /* a function pointer as a member */
};

Real sumOf(Vec3 v)  { return v.x + v.y + v.z; }
Real maxOf(Vec3 v)  {
    /* a chain of conditional expressions */
    return v.x > v.y ? (v.x > v.z ? v.x : v.z) : (v.y > v.z ? v.y : v.z);
}
Real minOf(Vec3 v)  {
    return v.x < v.y ? (v.x < v.z ? v.x : v.z) : (v.y < v.z ? v.y : v.z);
}
Real normSq(Vec3 v) { return v.x * v.x + v.y * v.y + v.z * v.z; }

Vec3 add(Vec3 a, Vec3 b) {
    Vec3 r;
    r.x = a.x + b.x; r.y = a.y + b.y; r.z = a.z + b.z;
    return r;
}
Vec3 scale(Vec3 a, Vec3 b) {            /* component-wise product */
    Vec3 r;
    r.x = a.x * b.x; r.y = a.y * b.y; r.z = a.z * b.z;
    return r;
}

int ascending(Real a, Real b)  { return a < b ? -1 : (a > b ? 1 : 0); }
int descending(Real a, Real b) { return ascending(b, a); }

/* a selection sort driven by a comparator the caller supplies */
void sortBy(Real *v, int n, Cmp cmp) {
    int i, j, best;
    Real t;
    for (i = 0; i < n - 1; i++) {
        best = i;
        for (j = i + 1; j < n; j++)
            if (cmp(v[j], v[best]) < 0) best = j;
        if (best != i) { t = v[i]; v[i] = v[best]; v[best] = t; }
    }
}

/* the typedef name Real used as an ordinary identifier in an inner scope */
int shadowProbe(int Real) {
    int Vec3 = Real * 2;                /* and Vec3 too */
    {
        double Reduce = Vec3 + 0.5;     /* and the function-pointer typedef */
        return (int)(Reduce * 2);
    }
}

int main(void) {
    Vec3 a, b, c;
    struct Op ops[4];
    Combine comb[2];
    Reduce  r;
    Real v[6];
    int i;

    a.x = 1.5; a.y = -2.5; a.z = 4.0;
    b.x = 0.5; b.y =  3.0; b.z = 2.0;

    /* a dispatch table of function pointers inside structs */
    ops[0].tag = 's'; ops[0].fn = sumOf;
    ops[1].tag = 'M'; ops[1].fn = maxOf;
    ops[2].tag = 'm'; ops[2].fn = minOf;
    ops[3].tag = 'n'; ops[3].fn = &normSq;      /* &f and f are the same */
    for (i = 0; i < 4; i++)
        printf("%c %.4f %.4f\n", ops[i].tag, ops[i].fn(a), (*ops[i].fn)(b));

    /* a struct built by a function reached through an array of pointers */
    comb[0] = add;
    comb[1] = scale;
    for (i = 0; i < 2; i++) {
        c = comb[i](a, b);
        printf("%.4f %.4f %.4f\n", c.x, c.y, c.z);
    }
    /* a returned struct used directly as an argument, and a member of one */
    printf("%.4f %.4f\n", sumOf(add(a, b)), add(a, b).z);
    printf("%.4f\n", sumOf(scale(add(a, b), a)));

    /* a function pointer chosen by a condition, compared, and called */
    r = normSq(a) > 10.0 ? maxOf : minOf;
    printf("%d %d %.4f\n", r == maxOf, r != sumOf, r(a));
    r = 0;
    printf("%d %d\n", r == 0, ops[0].fn != 0);

    /* a comparator passed by name and through a variable */
    v[0] = 2.5; v[1] = -1.0; v[2] = 9.25; v[3] = 0.0; v[4] = 4.5; v[5] = -7.5;
    sortBy(v, 6, ascending);
    for (i = 0; i < 6; i++) printf("%.3f%c", v[i], i == 5 ? '\n' : ' ');
    {
        Cmp how = descending;
        sortBy(v, 6, how);
    }
    for (i = 0; i < 6; i++) printf("%.3f%c", v[i], i == 5 ? '\n' : ' ');

    /* nested casts, and the typedef names used as identifiers */
    printf("%d %d\n", (int)(Real)(int)(Real)7.9, (int)(char)(int)(Real)66.3);
    printf("%d %d\n", shadowProbe(3), shadowProbe(10));
    printf("%d\n", (int)sizeof(Reduce) == (int)sizeof(Cmp));
    return 0;
}
