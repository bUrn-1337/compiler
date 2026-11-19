/* 67 -- printf edge cases, compared byte for byte with glibc: every flag,
   width and precision (literal and '*', negative '*'), %e/%f/%g/%a on
   tricky values (rounding ties, 1e300, subnormals, -0.0, inf, nan),
   %c of 0, %s with a precision and of NULL, %%, an unknown conversion,
   the h and hh length modifiers, and the counts sprintf returns. */
union bits { double d; int w[2]; };

double make(int hi, int lo) {
    union bits u;
    u.w[0] = lo;
    u.w[1] = hi;
    return u.d;
}

int main(void) {
    char buf[200];
    int n, i;
    double zero, inf, nan, nnan, sub, v;
    double vals[12];
    char *fmts[8];
    zero = 0.0;
    inf = 1.0 / zero;
    nan = make(0x7ff80000, 0);
    nnan = make(-524288, 0);              /* 0xfff80000: a negative nan */
    sub = make(0, 1);                     /* the smallest subnormal */
    printf("[%d] [%5d] [%-5d|] [%05d] [%+d] [% d] [%+05d] [%-+6d|] [%.3d] [%8.3d] [%-08d|]\n",
           42, 42, 42, 42, 42, 42, 42, 42, 7, -7, 3);
    printf("[%x] [%X] [%#x] [%#X] [%#o] [%o] [%#.0o] [%.0d] [%.0x|] [%#5x] [%#08x] [%u]\n",
           255, 255, 255, 0, 8, 8, 0, 0, 0, 10, 10, -1);
    printf("[%d] [%i] [%x] [%u] [%+.2i]\n", -2147483647 - 1, -1, -1, -2147483647 - 1, 5);
    printf("[%*d] [%-*d] [%*d|] [%.*d] [%.*d] [%*.*d]\n", 6, 1, 6, 2, -6, 3, 4, 5, -1, 6, 7, 3, 8);
    printf("[%hd] [%hd] [%hhd] [%hhu] [%hx] [%hhx] [%hu] [%ld] [%lx]\n",
           70000, -32769, 300, 511, -1, -1, -1, -5, -1);
    printf("[%c] [%3c] [%-3c|] [%s] [%.2s] [%8.3s] [%-8s|] [%s]\n",
           'A', 'b', 'c', "hello", "hello", "hello", "hi", "");
    n = sprintf(buf, "a%cb", 0);
    printf("NUL: n=%d bytes %d %d %d\n", n, buf[0], buf[1], buf[2]);
    printf("[%5%] [%-5%] [%y] [%k%d]\n", 9);
    printf("[%f] [%.0f] [%.0f] [%.0f] [%.0f] [%.1f] [%.2f] [%#.0f]\n",
           3.14159, 0.5, 1.5, 2.5, -0.5, 0.25, 1.005, 3.0);
    printf("[%e]