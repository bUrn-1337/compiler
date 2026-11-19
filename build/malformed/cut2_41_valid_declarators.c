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
void novoid();                        /*