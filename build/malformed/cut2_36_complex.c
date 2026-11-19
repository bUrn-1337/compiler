/* 36 -- complex numbers as a struct of two doubles, returned by value from
   every operation: arithmetic, conjugate, modulus, powers, and a short
   Mandelbrot iteration that uses nothing but struct values. */
struct Cpx { double re; double im; };

struct Cpx cmk(double re, double im) { struct Cpx z; z.re = re; z.im = im; return z; }
struct Cpx cadd(struct Cpx a, struct Cpx b) { return cmk(a.re + b.re, a.im + b.im); }
struct Cpx csub(struct Cpx a, struct Cpx b) { return cmk(a.re - b.re, a.im - b.im); }
struct Cpx cmul(struct Cpx a, struct Cpx b) {
    return cmk(a.re * b.re - a.im * b.im, a.re * b.im + a.im * b.re);
}
struct Cpx cconj(struct Cpx a) { a.im = -a.im; return a; }
double     cnorm(struct Cpx a) { return a.re * a.re + a.im * a.im; }
struct Cpx cdiv(struct Cpx a, struct Cpx b) {
    double d = cnorm(b);
    struct Cpx n = cmul(a, cconj(b));
    return d == 0.0 ? cmk(0.0, 0.0) : cmk(n.re / d, n.im / d);
}
struct Cpx cpow(struct Cpx a, int n) {
    struct Cpx r = cmk(1.0, 0.0);
    int i;
    for (i = 0; i < n; i++) r = cmul(r, a);
    return r;
}
double mysqrt(double a) {
    double x = a > 1.0 ? a : 1.0;
    int i;
    if (a <= 0.0) return 0.0;
    for (i = 0; i < 60; i++) x = (x + a / x) / 2.0;
    return x;
}
double cabsv(struct Cpx a) { return mysqrt(cnorm(a)); }
void cprint(char *tag, struct Cpx z) {
    printf("%s = %.6f %c %.6fi\n", tag, z.re, z.im < 0.0 ? '-' : '+',
           z