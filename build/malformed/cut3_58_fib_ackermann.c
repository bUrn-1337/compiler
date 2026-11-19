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
    return ack(m - 1, ack(m, n - 1