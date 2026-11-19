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
    printf("[%*d] [%-*d] [%*