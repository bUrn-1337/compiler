/* 51 -- pointers: arrays decaying to pointers, pointers to pointers, pointer
   arithmetic and differences, pointers into structs and arrays of structs,
   void * round trips, and null pointers.  No pointer VALUE is printed, since
   the size of a pointer differs between the target and the reference host. */
struct P { int x; int y; };

int sum(int *a, int n) { int s = 0, i; for (i = 0; i < n; i++) s += a[i]; return s; }
int sum2(int a[], int n)  { return sum(a, n); }
int sum3(int a[10], int n) { return sum(a, n); }

/* a pointer to a two-dimensional array's row */
int rowSum(int (*row)[4], int rows) {
    int s = 0, i, j;
    for (i = 0; i < rows; i++)
        for (j = 0; j < 4; j++) s += row[i][j];
    return s;
}

void swap(int *a, int *b) { int t = *a; *a = *b; *b = t; }
void setThrough(int **pp, int v) { **pp = v; }
char *findChar(char *s, char c) {
    while (*s) { if (*s == c) return s; s++; }
    return 0;
}

int main(void) {
    int  a[6];
    int  m[3][4];
    int *p;
    int *q;
    int **pp;
    void *vp;
    char  text[16];
    char *cp;
    struct P pts[3];
    struct P *sp;
    int i, j;

    for (i = 0; i < 6; i++) a[i] = (i + 1) * 3;
    for (i = 0; i < 3; i++) for (j = 0; j < 4; j++) m[i][j] = i * 4 + j;
    strcpy(text, "pointers here");

    /* an array decays to a pointer to its first element */
    p = a;
    printf("%d %d %d %d\n", *p, p[5], *(a + 2), sum(a, 6));
    printf("%d %d\n", sum2(a, 6), sum3(a, 6));
    printf("%d %d %d\n", *(p + 1) == a[1], p == &a[0], &a[3] - &a[1]);

    /* walking with a pointer, and the difference of two pointers */
    q = a + 5;
    i = 0;
    while (p <= q) { i += *p; p++; }
    printf("%d %d\n", i, (int)(q - a));
    p = a;
    printf("%d %d %d\n", (int)(q - p), p < q, q > p);

    /* a pointer to a pointer */
    p = a + 1;
    pp = &p;
    printf("%d %d\n", **pp, (*pp)[1]);
    setThrough(pp, 777);
    printf("%d %d\n", a[1], *p);

    /* swapping through pointers */
    swap(&a[0], &a[5]);
    printf("%d %d\n", a[0], a[5]);

    /* void * both ways */
    vp = a;
    printf("%d %d\n", *(int *)vp, ((int *)vp)[2]);
    vp = text;
    printf("%s\n", (char *)vp);
    vp = 0;
    printf("%d\n", vp == 0);

    /* a pointer to a row of a two-dimensional array */
    printf("%d %d %d\n", rowSum(m, 3), m[1][2], *(*(m + 2) + 3));
    {
        int (*row)[4] = m + 1;
        printf("%d %d\n", (*row)[0], row[1][3]);
    }

    /* pointers into an array of structs */
    for (i = 0; i < 3; i++) { pts[i].x = i; pts[i].y = i * i; }
    sp = pts;
    printf("%d,%d %d,%d\n", sp->x, sp->y, (sp + 2)->x, (sp + 2)->y);
    sp++;
    printf("%d %d %d\n", sp->x, sp[1].y, (int)(sp - pts));
    sp->x = 50;
    printf("%d\n", pts[1].x);

    /* a pointer to a member of a struct */
    {
        int *mx = &pts[2].x;
        *mx = 99;
        printf("%d %d\n", pts[2].x, *mx);
    }

    /* char pointers and a search that may fail */
    cp = findChar(text, 'h');
    printf("%s %d\n", cp ? cp : "(none)", cp != 0);
    cp = findChar(text, 'Z');
    printf("%s %d\n", cp ? cp : "(none)", cp == 0);
    printf("%d %d\n", (int)strlen(text), (int)(findChar(text, 's') - text));
    return 0;
}
