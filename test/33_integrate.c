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
    cases[0].exact = 9.0;  cases[0].tag = 'q';
    cases[1].f = fcube;    cases[1].a = 0.0; cases[1].b = 2.0;
    cases[1].exact = 4.0;  cases[1].tag = 'c';
    cases[2].f = flinear;  cases[2].a = 1.0; cases[2].b = 4.0;
    cases[2].exact = 18.0; cases[2].tag = 'l';
    cases[3].f = finverse; cases[3].a = 1.0; cases[3].b = 2.0;
    cases[3].exact = 0.6931471805599453; cases[3].tag = 'i';

    for (i = 0; i < 4; i++) {
        double t = trapezoid(cases[i].f, cases[i].a, cases[i].b, 2000);
        double s = simpson(cases[i].f, cases[i].a, cases[i].b, 2000);
        printf("%c trap=%.6f simp=%.6f exact=%.6f ok=%d %d\n",
               cases[i].tag, t, s, cases[i].exact,
               dabs(t - cases[i].exact) < 1e-3,
               dabs(s - cases[i].exact) < 1e-9);
    }

    /* the trapezoid rule refines as n grows */
    for (i = 1; i <= 4; i++)
        printf("n=%d -> %.8f\n", 10 * i, trapezoid(fsquare, 0.0, 1.0, 10 * i));

    /* the integrand picked out of an array of pointers */
    table[0] = fsquare; table[1] = fcube; table[2] = flinear;
    for (i = 0; i < 3; i++)
        printf("table[%d] f(2)=%.3f integral=%.6f\n", i, table[i](2.0),
               trapezoid(table[i], 0.0, 1.0, 1000));
    return 0;
}
