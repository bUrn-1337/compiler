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
struct Cpx cpow(