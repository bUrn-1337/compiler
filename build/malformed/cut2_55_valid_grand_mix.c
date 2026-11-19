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
        double Reduce = Vec3 