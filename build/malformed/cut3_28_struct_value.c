/* 28 -- structs and unions passed and returned by value: the callee writes to
   its own copy, a struct is assigned through a pointer and from one, a struct
   assigned to itself must survive, and a member is read straight out of a
   returned value. */
struct Point { int x; int y; };
struct Inner { int a[3]; char c; };
struct Outer { struct Point p; struct Inner in; int tail; };
union U { int i; char b[4]; };

struct Point mk(int x, int y) { struct Point p; p.x = x; p.y = y; return p; }
struct Point addp(struct Point a, struct Point b) {
    a.x = a.x + b.x;          /* writes to the callee's own copy */
    a.y = a.y + b.y;
    return a;
}
int sumInner(struct Inner q) {
    int i, s = 0;
    for (i = 0; i < 3; i++) s = s + q.a[i];
    q.a[0] = 999;             /* must not