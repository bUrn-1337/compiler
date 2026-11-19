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
    printf("[%e] [%.3E] [%.0e] [%#.0e] [%e] [%e]\n", 1234.5678, 0.000123456, 5e10, 5e10, 0.0, -1e-300);
    printf("[%g] [%g] [%g] [%g] [%g] [%#g] [%.3g] [%.10g] [%G]\n",
           100000.0, 1000000.0, 0.0001, 0.00001, 123.456, 1.0, 3.14159, 1.0 / 3.0, 1e-20);
    printf("[%a] [%A] [%.2a] [%a] [%a] [%.0a]\n", 1.0, 255.5, 3.14159, 0.1, sub, 1.5);
    printf("[%f] [%e] [%g] [%5.1f] [%-+8.2f|] [%+e] [% g]\n", -zero, -zero, -zero, -zero, 2.5, 1.0, 7.0);
    printf("[%f] [%F] [%e] [%G] [%5f] [%-6f|] [%+f] [%010f]\n", inf, inf, -inf, -inf, inf, inf, inf, -inf);
    printf("[%f] [%F] [%e] [%g] [%+f] [%f] [%8.3f]\n", nan, nan, nan, nnan, nan, nnan, nan);
    printf("[%.3e] [%g] [%.17g]\n", 1e300, 1e300, 1e300);
    printf("[%g] [%e] [%.20e]\n", sub, sub, sub);
    printf("[%.30f]\n", 0.1);
    printf("[%.0f]\n", 1e22);
    printf("[%f]\n", 123456789012345678.0);
    printf("[%.17g] [%.17g] [%.15g]\n", 0.1, 2.0 / 3.0, 0.3);
    printf("[%*.*f] [%-*.*e|] [%.*g]\n", 10, 2, 3.14159, 12, 1, 31415.9, -1, 0.5);
    vals[0] = 0.5; vals[1] = 0.125; vals[2] = 2.675; vals[3] = 1e-5; vals[4] = 9.9999;
    vals[5] = 99999.5; vals[6] = 0.000099995; vals[7] = 1e15; vals[8] = 1e16; vals[9] = 1e17;
    vals[10] = 4.35; vals[11] = 1.0 / 7.0;
    fmts[0] = "%.0f"; fmts[1] = "%.2f"; fmts[2] = "%.3e"; fmts[3] = "%g";
    fmts[4] = "%.2g"; fmts[5] = "%#.3g"; fmts[6] = "%12.4e"; fmts[7] = "%a";
    for (i = 0; i < 12; i++) {
        v = vals[i];
        printf("%d:", i);
        for (n = 0; n < 8; n++) {
            printf(" ");
            printf(fmts[n], v);
        }
        printf("\n");
    }
    n = sprintf(buf, "%s-%d-%.2f-%c", "abc", -12, 2.5, 'z');
    printf("sprintf -> \"%s\" returned %d, strlen %d\n", buf, n, strlen(buf));
    n = printf("%10s|%-10d|\n", "right", 77);
    printf("printf returned %d\n", n);
    n = printf("");
    printf("empty printf returned %d\n", n);
    return 0;
}
