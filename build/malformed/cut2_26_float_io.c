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
    pri