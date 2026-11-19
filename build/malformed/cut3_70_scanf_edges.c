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
    n = sscanf(