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
    b.name[0] = 'Z';               /* the caller's copy must not c