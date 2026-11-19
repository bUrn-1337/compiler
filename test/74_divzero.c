/* 74 -- @no-gcc: the defined behaviour this compiler gives to integer
   operations C leaves undefined (README, "Integer semantics"):
   INT_MIN / -1 is INT_MIN and INT_MIN % -1 is 0 (no trap), shifts use
   the low 5 bits of the count, and a division by zero stops the program
   with "runtime error: division by zero" on stderr and exit status 70,
   after the output so far has been written. */
int quot(int a, int b) { return a / b; }
int rem(int a, int b) { return a % b; }

int main(void) {
    int m, z, i;
    m = -2147483647 - 1;
    printf("%d %d\n", quot(m, -1), rem(m, -1));
    printf("%d %d %d\n", quot(m, 1), quot(m, 2), rem(m, 7));
    i = 33;
    printf("%d %d\n", 1 << i, -256 >> i);
    z = 0;
    for (i = 3; i >= 0; i--) printf("100 / %d = %d\n", i, quot(100, i - z));
    printf("not reached\n");
    return 0;
}
