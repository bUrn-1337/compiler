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
    q.a[0] = 999;             /* must not be visible to the caller */
    return s + q.c;
}
struct Outer bump(struct Outer o) { o.tail = o.tail + 1; o.p.x = o.p.x + 10; return o; }

int main(void) {
    struct Point a, b, c;
    struct Outer o, o2;
    struct Inner in;
    union U u, v;
    struct Point arr[3];
    struct Point *pp;
    int i;

    a = mk(1, 2);
    b = mk(30, 40);
    c = addp(a, b);
    printf("a=%d,%d b=%d,%d 