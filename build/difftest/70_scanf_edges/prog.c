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
/* 70 -- scanf/sscanf edge cases: %d %i %u %x %o (signs, 0x and 0
   prefixes for %i), field widths on integers and strings, %*d skips,
   %c (no space skip) and %s, literal text and %%, correctly rounded %lf
   (halfway cases, many digits, exponents, subnormal, overflow to inf),
   a matching failure part way, and EOF before any conversion.  Standard
   input is test/input/70_scanf_edges.in. */
int main(void) {
    int a, b, c, d, n;
    char s[40];
    char t[40];
    char ch, ch2;
    double x, y;
    n = sscanf("  -42 +17 0x1F 017 99", "%d %d %i %i %i", &a, &b, &c, &d, &n);
    printf("1: %d %d %d %d n=%d\n", a, b, c, d, n);
    n = sscanf("ff 777 -1 12", "%x %o %u %X", &a, &b, &c, &d);
    printf("2: %d %d %u %d n=%d\n", a, b, c, d, n);
    n = sscanf("123456789", "%3d%2d%d", &a, &b, &c);
    printf("3: %d %d %d n=%d\n", a, b, c, n);
    n = sscanf("1 2 3", "%*d %d %*d", &a);
    printf("4: %d n=%d\n", a, n);
    n = sscanf("abcdefgh xyz", "%3s%s %c", s, t, &ch);
    printf("5: [%s] [%s] [%c] n=%d\n", s, t, ch, n);
    n = sscanf("x y", "%c%c", &ch, &ch2);
    printf("6: [%c] [%c] n=%d\n", ch, ch2, n);
    n = sscanf("date: 2024-03-15 50%", "date: %d-%d-%d %d%%", &a, &b, &c, &d);
    printf("7: %d %d %d %d n=%d\n", a, b, c, d, n);
    a = b = -1;
    n = sscanf("12 abc", "%d %d", &a, &b);
    printf("8: %d %d n=%d\n", a, b, n);
    n = sscanf("", "%d", &a);
    printf("9: n=%d\n", n);
    n = sscanf("   ", "%d", &a);
    printf("10: n=%d\n", n);
    n = sscanf("xyz", "%d", &a);
    printf("11: n=%d\n", n);
    n = sscanf("99999999999 -99999999999", "%d %d", &a, &b);
    printf("12: %d %d n=%d\n", a, b, n);
    n = sscanf("4294967295 99999999999 -1 -99999999999", "%u %u %x %o", &a, &b, &c, &d);
    printf("12u: %u %u %u %u n=%d\n", a, b, c, d, n);
    n = sscanf("-0x10 0xg 0x1F 0777", "%x %i%c %2i%d", &a, &b, &ch, &c, &d);
    printf("12x: %d %d %c %d %d n=%d\n", a, b, ch, c, d, n);
    printf("12a: %d %d %d %d\n", atoi("99999999999"), atoi("-99999999999"), atoi("  -0012abc"), atoi("x5"));
    n = sscanf("0.1 2.5e-3", "%lf %lf", &x, &y);
    printf("13: %.17g %.17g n=%d\n", x, y, n);
    n = sscanf("9007199254740993 1.00000000000000011102230246251565404236316680908203125", "%lf %lf", &x, &y);
    printf("14: %.17g %.17g n=%d\n", x, y, n);
    n = sscanf("4.9e-324 2.4703282292062328e-324 1e309 -1e400", "%lf %lf %lf %lf", &x, &y, &x, &y);
    printf("15: %g %g n=%d\n", x, y, n);
    n = sscanf("2.2250738585072011e-308 1.7976931348623157e308", "%lf %lf", &x, &y);
    printf("16: %.17g %.17g n=%d\n", x, y, n);
    n = sscanf("  .5 -0 +3.", "%lf %lf %lf", &x, &y, &x);
    printf("17: %g %g n=%d\n", x, y, n);
    n = sscanf("1e5x 7", "%lf%c %d", &x, &ch, &a);
    printf("18: %g %c %d n=%d\n", x, ch, a, n);
    n = scanf("%d %d", &a, &b);
    printf("in1: %d %d n=%d\n", a, b, n);
    n = scanf("%s %lf", s, &x);
    printf("in2: %s %.6f n=%d\n", s, x, n);
    n = scanf(" %c", &ch);
    printf("in3: %c n=%d\n", ch, n);
    n = scanf("%d", &a);
    printf("in4: n=%d\n", n);
    n = scanf("%s", s);
    printf("in5: %s n=%d\n", s, n);
    n = scanf("%d", &a);
    printf("in6: n=%d\n", n);
    return 0;
}
