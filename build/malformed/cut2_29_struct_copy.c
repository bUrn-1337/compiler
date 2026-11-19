/* 29 -- struct and union copies in every position: nested structs, an array
   member copied as part of its struct, arrays of structs, unions, a struct
   holding a float, and a member selected straight out of a returned struct. */
struct Point { int x; int y; };
struct Inner { int a[3]; char c; };
struct Outer { struct Point p; struct Inner in; int tail; };
struct Box   { struct Outer o; char name[8]; };
union  Word  { int i; char b[4]; };
struct FP    { float f; int n; };

struct Point origin(void) { struct Point p; p.x = 0; p.y = 0; return p; }
struct Outer makeOuter(int base) {
    struct Outer o;
    int i;
    o.p.x = base; o.p.y = base + 1;
    for (i = 0; i < 3; i++) o.in.a[i] = base * 10 + i;
    o.in.c = 'a' + base;
    o.tail = base * 100;
    return o;
}
/* a whole struct by value, two levels deep */
int boxSum(struct Box b) {
    int i, s = 0;
    for (i = 0; i < 3; i++) s += b.o.in.a[i];
    b.name[0] = 'Z';               /* the caller's copy must not change */
    return s + b.o.tail + b.o.p.x + b.name[0];
}
union Word swapBytes(union Word w) {
    char t = w.b[0];
    w.b[0] = w.b[3];
    w.b[3] = t;
    return w;
}
struct FP halve(struct FP v) { v.f = v.f / 2.0f; v.n = v.n / 2; return v; }

int main(void) {
    struct Outer o1;
    struct Outer o2;
    struct Box   bx;
    struct Box   bx2;
    union  Word  w;
    union  Word  w2;
    struct FP    fp;
    struct Point line[4];
    struct Inner ins[2];
    int i;

    o1 = makeOuter(