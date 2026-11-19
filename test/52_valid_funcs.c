/* 52 -- functions: forward declarations, a declaration inside a block, mutual
   recursion, deep recursion, a function used before its definition, functions
   returning pointers and structs, many parameters, unused parameters, and a
   call written through extra parentheses. */
int  isEven(int n);                  /* declared here, defined at the bottom */
int  isOdd(int n);
struct Rec { int n; double d; };
struct Rec makeRec(int n);
char *pickWord(int i);
int  *biggest(int *a, int n);

int fact(int n) { return n <= 1 ? 1 : n * fact(n - 1); }

int fib(int n) { return n < 2 ? n : fib(n - 1) + fib(n - 2); }

int ackermannish(int m, int n) {     /* bounded recursion on two arguments */
    if (m == 0) return n + 1;
    if (n == 0) return ackermannish(m - 1, 1);
    return ackermannish(m - 1, ackermannish(m, n - 1));
}

int many(int a, int b, int c, int d, int e, int f, int g, int h) {
    return a + b * 2 + c * 3 + d * 4 + e * 5 + f * 6 + g * 7 + h * 8;
}

int ignores(int used, int unused1, char unused2) {
    (void)unused1;                   /* the value is deliberately discarded */
    (void)unused2;
    return used * 2;
}

void nothing(void) { }

int depth(int n) { return n == 0 ? 0 : 1 + depth(n - 1); }

int main(void) {
    int helperInBlock(int v);        /* a declaration with block scope */
    int arr[6];
    int *big;
    struct Rec r;
    int i;

    arr[0] = 3; arr[1] = 19; arr[2] = 7; arr[3] = 42; arr[4] = 11; arr[5] = 8;

    printf("%d %d %d %d\n", fact(1), fact(5), fact(7), fib(10));
    printf("%d %d %d\n", ackermannish(1, 3), ackermannish(2, 2), depth(50));
    for (i = 0; i < 4; i++) printf("%d%c", isEven(i), i == 3 ? '\n' : ' ');
    for (i = 0; i < 4; i++) printf("%d%c", isOdd(i), i == 3 ? '\n' : ' ');
    printf("%d %d\n", many(1, 1, 1, 1, 1, 1, 1, 1), ignores(21, 999, 'z'));
    printf("%d\n", helperInBlock(5));

    big = biggest(arr, 6);
    printf("%d %d\n", *big, (int)(big - arr));
    *big = -1;
    printf("%d\n", arr[3]);

    r = makeRec(4);
    printf("%d %.3f\n", r.n, r.d);
    printf("%s %s %s\n", pickWord(0), pickWord(1), pickWord(9));

    /* a call through extra parentheses, and a call as an argument */
    printf("%d %d\n", (fact)(4), fact(fib(5)));
    printf("%d\n", ((((fact))))(3));
    nothing();
    (void)ignores(1, 2, 'c');

    /* a function pointer taken from a function declared but defined later */
    {
        int (*fp)(int) = isEven;
        printf("%d %d\n", fp(8), fp(9));
    }
    return 0;
}

int isEven(int n) { return n == 0 ? 1 : isOdd(n - 1); }
int isOdd(int n)  { return n == 0 ? 0 : isEven(n - 1); }

int helperInBlock(int v) { return v * 100; }

struct Rec makeRec(int n) {
    struct Rec r;
    r.n = n;
    r.d = n / 8.0;
    return r;
}

char *pickWord(int i) {
    switch (i) {
        case 0: return "zero";
        case 1: return "one";
        default: return "other";
    }
}

int *biggest(int *a, int n) {
    int *best = a;
    int i;
    for (i = 1; i < n; i++) if (a[i] > *best) best = a + i;
    return best;
}
