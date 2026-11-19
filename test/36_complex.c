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
           z.im < 0.0 ? -z.im : z.im);
}

/* how many iterations of z <- z*z + c stay bounded, up to a limit */
int mandel(struct Cpx c, int limit) {
    struct Cpx z = cmk(0.0, 0.0);
    int i;
    for (i = 0; i < limit; i++) {
        z = cadd(cmul(z, z), c);
        if (cnorm(z) > 4.0) return i;
    }
    return limit;
}

int main(void) {
    struct Cpx a = cmk(3.0, 4.0);
    struct Cpx b = cmk(1.0, -2.0);
    struct Cpx tab[3];
    int i, j;

    cprint("a", a);
    cprint("b", b);
    cprint("a+b", cadd(a, b));
    cprint("a-b", csub(a, b));
    cprint("a*b", cmul(a, b));
    cprint("a/b", cdiv(a, b));
    cprint("conj a", cconj(a));
    cprint("a^3", cpow(a, 3));
    printf("|a| = %.8f  |b| = %.8f  norm a = %.1f\n", cabsv(a), cabsv(b), cnorm(a));
    cprint("a (unchanged)", a);

    /* (a/b)*b == a, to within rounding */
    {
        struct Cpx back = cmul(cdiv(a, b), b);
        printf("roundtrip ok = %d\n", cnorm(csub(back, a)) < 1e-20);
    }

    tab[0] = cmk(0.0, 0.0);
    tab[1] = cmk(-1.0, 0.0);
    tab[2] = cmk(1.0, 1.0);
    for (i = 0; i < 3; i++) printf("mandel %d = %d\n", i, mandel(tab[i], 50));

    /* a 5x3 escape-time picture, printed as characters */
    for (i = -2; i <= 2; i++) {
        for (j = -2; j <= 1; j++) {
            int n = mandel(cmk(j * 0.5, i * 0.5), 30);
            printf("%c", n >= 30 ? '#' : (n > 3 ? '+' : '.'));
        }
        printf("\n");
    }
    return 0;
}
