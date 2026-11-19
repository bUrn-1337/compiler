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

    printf("%d %d %d %d\n", fact(1), fact(5), fact(7),