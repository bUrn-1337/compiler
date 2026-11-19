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
        v[j + 1] = t;
    }
}

void rsort(struct Rec *v, int n, RCmp cmp) {
    int i, j;
    for (i = 1; i < n; i++) {
        struct Rec t = v[i];               /* a struct copy per step */
        j = i - 1;
        while (j >= 0 && cmp(v[j], t) > 0) { v[j + 1] = v[j]; j--; }
        v[j + 1] = t;
    }
}

/* a binary search driven by the same comparator */
int dfind(double *v, int n, double key, DCmp cmp) {
    int lo = 0, hi = n - 1;
    while (lo <= hi) {
        int mid = (lo + hi) / 2;
        int c = cmp(v[mid], key);
        if (c == 0) return mid;
        if (c < 0) lo = mid + 1; else hi = mid - 1;
    }
    return -1;
}

void dshow(char *tag, double *v, int n) {
    int i;
    printf("%s:", tag);
    for (i = 0; i < n; i++) printf(" %.2f", v[i]);
    printf("\n");
}
void rshow(char *tag, struct Rec *v, int n) {
    int i;
    printf("%s:", tag);
    for (i = 0; i < n; i++) printf(" (%d,%c,%.1f)", v[i].id, v[i].grade, v[i].score);
    printf("\n");
}

int main(void) {
    double d[8];
    struct Rec r[5];
    DCmp cmps[3];
    char *names[3];
    int i;

    d[0] = 3.5; d[1] = -7.25; d[2] = 0.0; d[3] = 12.5;
    d[4] = -0.5; d[5] = 9.75; d[6] = 2.0; d[7] = -11.0;

    cmps[0] = dAsc;  names[0] = "asc";
    cmps[1] = dDesc; names[1] = "desc";
    cmps[2] = dAbs;  names[2] = "byabs";

    for (i = 0; i < 3; i++) {
        double work[8];
        int k;
        for (k = 0; k < 8; k++) work[k] = d[k];
        dsort(work, 8, cmps[i]);
        dshow(names[i], work, 8);
    }

    dsort(d, 8, dAsc);
    dshow("sorted", d, 8);
    printf("find 2.00 -> %d, find 9.75 -> %d, find 4.00 -> %d\n",
           dfind(d, 8, 2.0, dAsc), dfind(d, 8, 9.75, dAsc), dfind(d, 8, 4.0, dAsc));

    r[0].id = 4; r[0].score = 71.5; r[0].grade = 'B';
    r[1].id = 1; r[1].score = 92.0; r[1].grade = 'A';
    r[2].id = 7; r[2].score = 55.5; r[2].grade = 'C';
    r[3].id = 2; r[3].score = 92.0; r[3].grade = 'A';
    r[4].id = 9; r[4].score = 64.0; r[4].grade = 'B';
    rshow("records", r, 5);
    rsort(r, 5, byScore);
    rshow("by score", r, 5);
    rsort(r, 5, byGradeThenId);
    rshow("by grade", r, 5);

    /* the comparator chosen at run time, and called directly for one pair */
    {
        RCmp rc = byScore;
        printf("byScore(r0,r1) = %d, byGrade(r0,r1) = %d\n",
               rc(r[0], r[1]), byGradeThenId(r[0], r[1]));
        printf("same pointer: %d, not null: %d\n", rc == byScore, rc != 0);
    }
    return 0;
}
