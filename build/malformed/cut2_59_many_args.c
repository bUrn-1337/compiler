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

double dd(double a, double b, double c, double d, double e, double f) {
    return a - b + c - d + e - f;
}

char cc(char a, char b, char c, char d, char e, char f, char g) {
    return a + b + c + d + e + f + g;
}

int count(int n, int a0, int a1, int a2, int a3, int a4, int a5, int a6, int a7,
          int a8, int a9, int a10, int a11, int a12, int a13) {
    int t;
    t = a0 ^ a1 ^ a2 ^ a3 ^ a4 ^ a5 ^ a6 ^ a7 ^ a8 ^ a9 ^ a10 ^ a11 