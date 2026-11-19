/* 34 -- polynomial evaluation chosen through function pointers: three
   evaluation schemes behind one pointer type, a table that names them, and a
   derivative evaluated by the same machinery. */
typedef double (*Eval)(double *, int, double);

/* straightforward: sum c[i] * x^i */
double naive(double *c, int n, double x) {
    double s = 0.0;
    double p = 1.0;
    int i;
    for (i = 0; i < n; i++) { s += c[i] * p; p *= x; }
    return s;
}

/* Horner's scheme: fewer multiplications, same value for these inputs */
double horner(double *c, int n, double x) {
    double s = 0.0;
    int i;
    for (i = n - 1; i >= 0; i--) s = s * x + c[i];
    return s;
}

/* the derivative, evaluated by Horner on the differentiated coefficients */
double deriv(double *c, int n, double x) {
    double s = 0.0;
    int i;
    for (i = n - 1; i