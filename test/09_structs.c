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
    o.in.value = 99;
    o.pts[0].x = 11; o.pts[0].y = 12;
    o.pts[1].x = 21; o.pts[1].y = 22;
    o.name[0] = 'o'; o.name[1] = 'k'; o.name[2] = 0;
    printf("%d %c %d %d %d %s\n", o.id, o.in.tag, o.in.value,
           o.pts[1].x, o.pts[0].y, o.name);

    for (i = 0; i < 3; i = i + 1) { arr[i].x = i; arr[i].y = i * i; }
    for (i = 0; i < 3; i = i + 1) printf("%d:%d ", arr[i].x, arr[i].y);
    printf("\n");
    printf("%d\n", sumPoint(&arr[2]));

    /* a struct containing a char followed by an int is padded, so
       sizeof(struct Inner) is 8, not 5 */
    printf("%d %d %d\n", (int)sizeof(struct Point),
                         (int)sizeof(struct Inner),
                         (int)sizeof(struct Outer));

    /* a hand-built two-element list */
    n2.v = 2; n2.next = 0;
    n1.v = 1; n1.next = &n2;
    walk = &n1;
    while (walk != 0) { printf("%d ", walk->v); walk = walk->next; }
    printf("\n");

    /* pointer to a struct member, and a struct member that is an array */
    pp = &o.pts[1];
    printf("%d %d\n", pp->x, pp->y);
    return 0;
}
