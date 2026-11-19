/* 33 -- numerical integration: the trapezoid rule applied through a function
   pointer, so the integrand is chosen at run time, and compared with the exact
   value of each integral. */
typedef double (*Fn)(double);

double fsquare(double x)  { return x * x; }
double fcube(double x)    { return x * x * x; }
double flinear(double x)  { return 2.0 * x + 1.0; }
double finverse(double x) { return 1.0 / x; }

double dabs(double v) { return v < 0.0 ? -v : v; }

double trapezoid(Fn f, double a, double b, int n) {
    double h = (b - a) / n;
    double s = (f(a) + f(b)) / 2.0;
    int i;
    for (i = 1; i < n; i++) s += f(a + i * h);
    return s * h;
}

/* Simpson's rule, for comparison: exact on a cubic */
double simpson(double (*f)(double), double a, double b, int n) {
    double h = (b - a) / n;
    double s = f(a) + f(b);
    int i;
    for (i = 1; i < n; i++) s += (i % 2 ? 4.0 : 2.0) * f(a + i * h);
    return s * h / 3.0;
}

struct Case { Fn f; double a; double b; double exact; char tag; };

int main(void) {
    struct Case cases[4];
    Fn table[3];
    int i;

    cases[0].f = fsquare;  cases[0].a = 0.0; cases[0].b = 3.0;
    cases[0].exact = 9.0;  cases[0].tag = '