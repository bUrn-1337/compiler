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
    int i