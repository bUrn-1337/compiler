/* 35 -- three-dimensional vectors of doubles passed and returned by value:
   addition, scaling, the dot and cross products, and a length computed with a
   hand-written square root. */
struct Vec { double x; double y; double z; };

struct Vec vmake(double x, double y, double z) {
    struct Vec v;
    v.x = x; v.y = y; v.z = z;
    return v;
}
struct Vec vadd(struct Vec a, struct Vec b) {
    return vmake(a.x + b.x, a.y + b.y, a.z + b.z);
}
struct Vec vsub(struct Vec a, struct Vec b) {
    return vmake(a.x - b.x, a.y - b.y, a.z - b.z);
}
struct Vec vscale(struct Vec a, double k) {
    a.x *= k; a.y *= k; a.z *= k;     /* the callee's own copy */
    return a;
}
double vdot(struct Vec a, struct Vec b) { return a.x * b.x + a.y * b.y + a.z * b.z; }
struct Vec vcross(struct Vec a, struct Vec b) {
    return vmake(a.y * b.z - a.z * b.y,
                 a.z * b.x - a.x * b.z,
                 a.x * b.y - a.y * b.x);
}
double mysqrt(double a) {
    double x = a > 1.0 ? a : 1.0;
    int i;
    if (a <= 0.0) return 0.0;
    for (i = 0; i < 60; i++) x = (x + a / x) / 2.0;
    return x;
}
double vlen(struct Vec a) { return mysqrt(vdot(a, a)); }
struct Vec vunit(struct Vec a) {
    double L = vlen(a);
    return L > 0.0 ? vscale(a, 1.0 / L) : a;
}
void vprint(char *tag, struct Vec v) {
    printf("%s = (%.6f, %.6f, %.6f)\n", tag, v.x, v.y, v.z);
}

int main(void) {
    struct Vec a = vmake(1.0, 2.0, 3.0);
    struct Vec b = vmake(-2.0, 0.5, 4.0);
    struct Vec pts[3];
    struct Vec acc;
    int i;

    vprint("a", a);
    vprint("b", b);
    vprint("a+b", vadd(a, b));
    vprint("a-b", vsub(a, b));
    vprint("2a", vscale(a, 2.0));
    vprint("axb", vcross(a, b));
    printf("a.b = %.6f  |a| = %.8f  |b| = %.8f\n", vdot(a, b), vlen(a), vlen(b));
    vprint("unit a", vunit(a));
    printf("|unit a| - 1 < 1e-12: %d\n", vlen(vunit(a)) - 1.0 < 1e-12);
    vprint("a (unchanged)", a);

    /* an array of vectors summed by value */
    pts[0] = a; pts[1] = b; pts[2] = vcross(a, b);
    acc = vmake(0.0, 0.0, 0.0);
    for (i = 0; i < 3; i++) acc = vadd(acc, pts[i]);
    vprint("sum", acc);
    printf("perpendicular: %.6f %.6f\n", vdot(pts[2], a), vdot(pts[2], b));

    /* nested calls, each returning a struct by value */
    vprint("nested", vadd(vscale(vadd(a, b), 0.5), vsub(b, a)));
    printf("member of a returned value: %.6f\n", vcross(a, b).z);
    return 0;
}
