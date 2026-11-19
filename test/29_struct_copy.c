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

    o1 = makeOuter(2);
    o2 = o1;                       /* a nested struct copied whole */
    o2.in.a[1] = -1;
    printf("o1=%d,%d %d,%d,%d %c %d\n", o1.p.x, o1.p.y,
           o1.in.a[0], o1.in.a[1], o1.in.a[2], o1.in.c, o1.tail);
    printf("o2.in.a[1]=%d o1.in.a[1]=%d\n", o2.in.a[1], o1.in.a[1]);

    bx.o = o1;                     /* struct into a struct member */
    strcpy(bx.name, "box");
    bx2 = bx;                      /* copy, array member included */
    printf("boxSum=%d name=%s %s\n", boxSum(bx), bx.name, bx2.name);

    w.i = 0;
    w.b[0] = 1; w.b[1] = 2; w.b[2] = 3; w.b[3] = 4;
    w2 = swapBytes(w);
    printf("w=%d,%d,%d,%d w2=%d,%d,%d,%d\n", w.b[0], w.b[1], w.b[2], w.b[3],
           w2.b[0], w2.b[1], w2.b[2], w2.b[3]);

    fp.f = 7.5f; fp.n = 9;
    fp = halve(fp);
    printf("fp=%.3f %d\n", (double)fp.f, fp.n);

    /* arrays of structs, filled from returned values and copied element-wise */
    for (i = 0; i < 4; i++) { line[i] = origin(); line[i].x = i; line[i].y = i * i; }
    line[3] = line[0];
    for (i = 0; i < 4; i++) printf("line[%d]=%d,%d\n", i, line[i].x, line[i].y);

    ins[0] = o1.in;
    ins[1] = ins[0];
    ins[1].a[2] = 77;
    printf("ins=%d,%d %c\n", ins[0].a[2], ins[1].a[2], ins[1].c);

    /* a member of a struct returned by value, used directly */
    printf("direct=%d %d %c\n", makeOuter(1).p.y, makeOuter(3).tail,
           makeOuter(4).in.c);
    printf("chain=%d\n", halve(fp).n + swapBytes(w).b[0]);
    return 0;
}
