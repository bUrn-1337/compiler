/* 71 -- floating point: int <-> float <-> double conversions (truncation
   toward zero, negatives, the int limits, char 200 = -56), single
   precision rounding kept separate from double, float/double parameters
   and returns, NaN and -0.0 in comparisons and conditions, ++/--/op= on
   doubles and floats, mixed ternaries, and an accumulation loop whose
   result depends on every rounding step. */
union bits { double d; int w[2]; };

float fhalf(float x) { return x / 2; }
double dmix(int i, float f, double d, char c) { return i + f + d + c; }
float fsum(float *a, int n) {
    float s;
    int i;
    s = 0;
    for (i = 0; i < n; i++) s += a[i];
    return s;
}
int trunc_i(double d) { return (int)d; }

int main(void) {
    double d, zero, nz, nan, big;
    float f, g;
    int i, k;
    char c;
    float fa[10];
    union bits u;
    zero = 0.0;
    nz = -zero;
    u.w[0] = 0; u.w[1] = 0x7ff80000; nan = u.d;
    printf("trunc: %d %d %d %d %d %d\n", trunc_i(2.9), trunc_i(-2.9), trunc_i(0.999999),
           trunc_i(-0.5), trunc_i(2147483647.0), trunc_i(-2147483648.0));
    printf("to double: %.1f %.1f %.1f %.1f\n", (double)2147483647, (double)(-2147483647 - 1),
           (double)-7, (double)(char)200);
    c = 200;
    d = c;
    i = c;
    printf("char 200: %d %.1f %d\n", c, d, i);
    c = 65.7;
    printf("double->char: %d %c\n", c, c);
    c = -1.5;
    printf("double->char neg: %d\n", c);
    f = 0.1;
    d = 0.1;
 