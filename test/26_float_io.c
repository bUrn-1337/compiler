/* 26 -- floating point through the variadic library: a float argument is
   promoted to double by printf, and scanf takes %f for float and %lf for
   double.  Reads two numbers from standard input (test/input/26_float_io.in). */
int main(void) {
    float  f;
    double d;
    float  g = 2.5f;
    int    n;

    n = scanf("%f %lf", &f, &d);
    printf("n=%d\n", n);
    printf("%.4f %.4f\n", (double)f, d);

    /* a float passed to printf is promoted to double: no cast needed */
    printf("%f %.2f\n", g, g);
    printf("%e %E\n", d, d);
    printf("%g %g %g\n", d, 1234567.0, 0.0001);
    printf("%10.3f|%-10.3f|%+.3f\n", d, d, -d);
    printf("%.0f %.1f %.7f\n", 2.5, 0.05, 1.0 / 3.0);

    /* an integer and a double in the same call, in both orders */
    printf("%d %.2f %d %.2f\n", 1, d, 2, (double)f);
    printf("%.2f %d%%\n", d * 2.0, (int)d);

    n = scanf("%d %lf", &n, &d);
    printf("%d %.3f\n", n, d);
    n = scanf("%lf", &d);                  /* nothing left: end of file */
    printf("eof n=%d\n", n);
    return 0;
}
