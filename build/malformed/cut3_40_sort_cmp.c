/* 40 -- a qsort-like interface: one sorting routine, several comparators
   supplied through function pointers, over doubles and over structs.  One
   comparator takes its two structs by value, so Parts B and C meet here. */
struct Rec { int id; double score; char grade; };

typedef int (*DCmp)(double, double);
typedef int (*RCmp)(struct Rec, struct Rec);

int dAsc(double a, double b)  { return a < b ? -1 : (a > b ? 1 : 0); }
int dDesc(double a, double b) { return a < b ? 1 : (a > b ? -1 : 0); }
int dAbs(double a, double b) {
    double x = a < 0.0 ? -a : a;
    double y = b < 0.0 ? -b : b;
    return x < y ? -1 : (x > y ? 1 : 0);
}

/* comparators over whole structs, passed by value */
int byScore(struct Rec a, struct Rec b) {
    return a.score < b.score ? -1 : (a.score > b.score ? 1 : 0);
}
int byGradeThenId(struct Rec a, struct Rec b) {
    if (a.grade != b.grade) return a.grade < b.grade ? -1 : 1;
    return a.id - b.id;
}

/* insertion sort: stable, and it only ever asks the comparator */
void dsort(double *v, int n, DCmp cmp) {
    int i, j;
    for (i = 1; i < n; i++) {
        double t = v[i];
        j = i - 1;
        while (j >= 0 && cmp(v[j], t) > 0) { v[j + 1] = v[j]; j--; }
        v[j