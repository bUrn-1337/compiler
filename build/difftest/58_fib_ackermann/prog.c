/* test/prelude.h -- prepended to each test program ONLY when it is compiled by
 * gcc as the reference implementation (see verify.sh).  The generator itself
 * never sees this file: the source language has no preprocessor, so printf,
 * malloc, fopen and friends are built into the compiler, and `until` is a
 * language extension rather than a macro.
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define until(c) while (!(c))
/* 58 -- deep recursion: fib(25) (242785 calls) and Ackermann's function,
   whose recursion depth reaches several hundred frames. */
int calls;

int fib(int n) {
    calls++;
    if (n < 2) return n;
    return fib(n - 1) + fib(n - 2);
}

int ack(int m, int n) {
    if (m == 0) return n + 1;
    if (n == 0) return ack(m - 1, 1);
    return ack(m - 1, ack(m, n - 1));
}

/* mutual recursion through a forward declaration */
int is_odd(int n);
int is_even(int n) { if (n == 0) return 1; return is_odd(n - 1); }
int is_odd(int n)  { if (n == 0) return 0; return is_even(n - 1); }

double dfib(int n) {
    if (n < 2) return (double)n;
    return dfib(n - 1) + dfib(n - 2);
}

int main(void) {
    int m, n, f;
    calls = 0;
    f = fib(25);
    printf("fib(25) = %d in %d calls\n", f, calls);
    for (m = 0; m <= 3; m++) {
        for (n = 0; n <= 4; n++) printf("%6d", ack(m, n));
        printf("\n");
    }
    printf("ack(3,5) = %d\n", ack(3, 5));
    printf("is_even(501)=%d is_odd(501)=%d\n", is_even(501), is_odd(501));
    printf("dfib(20) = %.1f\n", dfib(20));
    return fib(10) % 256;
}
