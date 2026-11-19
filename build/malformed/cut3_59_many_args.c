/* 59 -- calls with more than ten arguments, and with int, char, float and
   double arguments mixed in every order (alignment of the doubles in the
   argument area), plus float/double results and the same calls through a
   function pointer. */
int sum12(int a, int b, int c, int d, int e, int f, int g, int h,
          int i, int j, int k, int l) {
    return a + 2*b + 3*c + 4*d + 5*e + 6*f + 7*g + 8*h + 9*i + 10*j + 11*k + 12*l;
}

double mix(int a, double b, char c, float d, int e, double f, float g, char h,
           double i, int j, float k) {
    printf("  a=%d b=%g c=%c d=%g e=%d f=%g g=%g h=%c i=%g j=%d k=%g\n",
           a, b, c, d, e, f, g, h, i, j, k);
    return a + b + c + d + e + f + g + h + i + j + k;
}

float fmix(float a, int b, float c, double d, float e) {
    return a * b + c - (float)d * e;
}

double dd(double 