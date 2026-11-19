/* 12 -- functions: parameters, return values, void functions, forward
   declarations, mutual recursion, and the classic recursive examples. */
int  fib(int n);                 /* forward declaration, defined below */
void banner(void);

int factorial(int n) {
    if (n <= 1) return 1;
    return n * factorial(n - 1);
}

int gcd(int a, int b) {
    if (b == 0) return a;
    return gcd(b, a % b);
}

int ackermann(int m, int n) {    /* doubly recursive */
    if (m == 0) return n + 1;
    if (n == 0) return ackermann(m - 1, 1);
    return ackermann(m - 1, ackermann(m, n - 1));
}

int isEven(int n);
int isOdd(int n) { if (n == 0) return 0; return isEven(n - 1); }
int isEven(int n) { if (n == 0) return 1; return isOdd(n - 1); }

int many(int a, int b, int c, int d, int e, int f) {
    return a + b * 2 + c * 3 + d * 4 + e * 5 + f * 6;
}

void noReturnValue(int n) {
    if (n < 0) return;           /* an early bare return */
    printf("got %d\n", n);
}

int sideEffect(int *counter, int add) { *counter = *counter + add; return *counter; }

/* falls off the end without a return: the generator still emits one */
int fallsOff(int n) { if (n > 0) return 1; }

int main(void) {
    int i;
    int c;

    banner();

    for (i = 0; i <= 8; i = i + 1) printf("%d ", factorial(i));
    printf("\n");
    for (i = 0; i <= 10; i = i + 1) printf("%d ", fib(i));
    printf("\n");
    printf("%d %d %d\n", gcd(48, 18), gcd(17, 5), gcd(270, 192));
    printf("%d %d\n", ackermann(2, 3), ackermann(1, 4));
    printf("%d %d %d %d\n", isOdd(7), isEven(7), isOdd(10), isEven(10));
    printf("%d\n", many(1, 1, 1, 1, 1, 1));
    printf("%d\n", many(6, 5, 4, 3, 2, 1));

    noReturnValue(5);
    noReturnValue(-5);

    /* Each call is printed on its own, because the order in which a printf's
       arguments are evaluated is unspecified in C and two calls that both
       modify `c` would make the expected output ambiguous. */
    c = 0;
    printf("%d ", sideEffect(&c, 1));
    printf("%d ", sideEffect(&c, 2));
    printf("%d\n", c);

    printf("%d\n", fallsOff(1));

    /* nested calls, and a call used as an argument */
    printf("%d\n", factorial(gcd(12, 8)));
    printf("%d\n", many(factorial(3), fib(5), gcd(9, 6), 1, 2, 3));
    return 0;
}

int fib(int n) {
    if (n < 2) return n;
    return fib(n - 1) + fib(n - 2);
}

void banner(void) { printf("-- functions --\n"); }
