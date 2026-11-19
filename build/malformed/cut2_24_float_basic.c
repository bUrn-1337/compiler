/* 24 -- float and double: literal forms, the usual arithmetic conversions,
   conversions to and from the integer types, compound assignment, ++/--,
   comparisons, floats in conditions, and the conditional operator. */
double gd = 2.5;
float  gf = 1.5f;
double gsum = 1.5 + 2.0;          /* a constant expression in an initializer */

int main(void) {
    double lits[6];
    double x = 3.0;
    float  f = 1.5f;
    int    i = 7;
    char   c = 100;
    double y;
    int    k;

    /* every floating form the lexer must accept */
    lits[0] = 1.5;
    lits[1] = .5;
    lits[2] = 5.;
    lits[3] = 1e3;
    lits[4] = 1.5e-3;
    lits[5] = 0.125e+2;
    for (k = 0; k < 6; k++) printf("%.6f\n", lits[k]);

    /* usual arithmetic conversions: int -> double, float -> double */
    y = x + f;
    printf("%.3f %.3f %.3f\n", y, x + i, f * 2);
    printf("%.6f %.6f\n", x / 2.0, 1.0 / 3.0);
    printf("%.6f\n", (double)i / 2);          /* 3.5, not 3 */
    printf("%d\n", i / 2);                    /* still integer division */

    /* conversions: float -> int truncates toward zero */
    printf("%d 