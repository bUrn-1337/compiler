/* 60 -- structs passed and returned by value at sizes 1, 4, 8, 12 and 20
   bytes, and one with a double member (size 16, alignment 8): the callee
   gets a copy, a returned struct can be used directly, and arrays of them
   are copied element by element. */
struct S1  { char c; };
struct S4  { char a; char b; char c; char d; };
struct S8  { int a; int b; };
struct S12 { int a; char b; int c; };
struct S20 { int v[5]; };
struct SD  { char tag; double d; };
struct Big { struct S12 x; struct SD y; struct S1 z; };

struct S1 mk1(char c) { struct S1 s; s.c = c; return s; }
struct S4 mk4(int a, int b, int c) { struct S4 s; s.a = a; s.b = b; s.c = c; s.d = a + c; return s; }
struct S8 swap8(struct S8 s) { int t; t = s.a; s.a = s.b; s.b = t; return s; }
struct S12 add12(struct S12 p, struct S12 q) {
    struct S12 r;
    r.a = p.a + q.a; r.b = p.b + q.b; r.c = p.c + q.c;
    p.a = 999;                       /* the caller's copy must not change */
    return r;
}
struct S20 rev20(struct S20 s) {
    struct S20 r;
    int i;
    for (i = 0; i < 5; i++) r