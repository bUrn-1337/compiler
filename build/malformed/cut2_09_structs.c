/* 09 -- structures: member access, nested structs, pointers to structs,
   arrays of structs, struct assignment, and struct layout with padding. */
struct Point { int x; int y; };

struct Inner { char tag; int value; };

struct Outer {
    int            id;
    struct Inner   in;
    struct Point   pts[2];
    char           name[6];
};

struct Node { int v; struct Node *next; };   /* self-referential */

int sumPoint(struct Point *p) { return p->x + p->y; }

int main(void) {
    struct Point a;
    struct Point b;
    struct Point *pp;
    struct Outer o;
    struct Point arr[3];
    struct Node n1;
    struct Node n2;
    struct Node *walk;
    int i;

    a.x = 3; a.y = 4;
    printf("%d %d %d\n", a.x, a.y, sumPoint(&a));

    b = a;                       /* whole-struct assignment copies every byte */
    b.y = 40;
    printf("%d %d %d %d\n", a.x, a.y, b.x, b.y);

    pp = &a;
    pp->x = 30;
    printf("%d %d %d\n", a.x, pp->x, (*pp).y);
    (*pp).y = 44;
    printf("%d\n", a.y);

    o.id = 1;
    o.in.tag = 'T';
    o.in.value = 9