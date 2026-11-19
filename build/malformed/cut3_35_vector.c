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
struct Vec vcross(struct Vec a, struct 