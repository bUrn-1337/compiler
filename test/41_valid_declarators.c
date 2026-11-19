/* 41 -- declarator corner cases that are all valid C: parenthesized names,
   pointers to arrays, arrays of pointers, arrays of function pointers, a
   function returning a function pointer written out longhand, and a typedef
   used as the base type of a further declarator. */
int add(int a, int b) { return a + b; }
int neg(int a, int b) { return b - a; }

int    arr[2][3];
int  (*pa)[3];            /* pointer to an array of three ints */
int   *ap[4];             /* array of four pointers to int */
int  **pp;
int  (*tab[3])(int, int); /* array of pointers to function */
int ((*pf))(int, int);    /* redundant parentheses around the name */
int  (gx);                /* a parenthesized plain name */
int   *(gy);
char *(*namer)(char *);

typedef int Arr3[3];
typedef int (*Fn2)(int, int);
Arr3 *parr;               /* pointer to a typedef'd array */
Fn2   gtab[2] = { add, neg };

/* a function whose return type is a pointer to function, spelled out */
int (*pick(int which))(int, int) { return which ? neg : add; }
Fn2  pick2(int which)            { return which ? neg : add; }

/* parameters in their many equivalent spellings */
int sum5(int (*g)(int, int), int *a, int b[], int c[3], char **d) {
    return g(a[0], b[1]) + c[2] + (d[0] ? 1 : 0);
}
char *first(char *s) { return s; }
void novoid();                        /* an unspecified parameter list */
void novoid() { }

int main(void) {
    int  (i);
    int *(p) = &i;
    int (*(q)) = &i;
    int  (a)[3];
    int  (*r)[3] = arr;
    Arr3 a3;
    Fn2  fn;
    void *vp;
    char *words[2];
    int   k;

    i = 4;
    a[0] = 1; a[1] = 2; a[2] = 3;
    a3[0] = 10; a3[1] = 20; a3[2] = 30;
    pa = &a3;
    parr = &a3;
    pp = &p;
    gx = 7; gy = &i;
    vp = p;
    namer = first;
    words[0] = "hi"; words[1] = "there";

    printf("%d %d %d %d %d\n", *p, *q, a[2], *(int *)vp, **pp);
    printf("%d %d %d\n", (*pa)[1], (*parr)[2], (*r)[0]);

    for (k = 0; k < 2; k++) arr[0][k] = k + 1;
    arr[0][2] = 9; arr[1][0] = 5; arr[1][1] = 6; arr[1][2] = 7;
    printf("%d %d\n", (*r)[2], r[1][0]);

    tab[0] = add; tab[1] = neg; tab[2] = 0;
    pf = add;
    fn = pick(1);
    printf("%d %d %d %d\n", tab[0](3, 4), tab[1](3, 4), pf(3, 4), fn(3, 4));
    printf("%d %d %d\n", pick(0)(10, 2), pick2(1)(10, 2), gtab[1](10, 2));
    printf("%d %d\n", (*pf)(1, 1), ((*(*&pf)))(2, 2));

    ap[0] = &i; ap[1] = &gx; ap[2] = 0; ap[3] = 0;
    printf("%d %d %d\n", *ap[0], *ap[1], ap[2] == 0);
    printf("%s %s\n", namer(words[0]), first(words[1]));
    printf("%d\n", sum5(add, a, a, a, words));
    printf("%d %d %d\n", (int)sizeof(Arr3), (int)sizeof a3, (int)sizeof arr);
    novoid();
    return 0;
}
