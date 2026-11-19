/* 54 -- the corners of struct and union declarations: a tag declared before it
   is completed, two structs that point at each other, a struct that points at
   itself, tags declared inside a block, a tag spelled like a variable, nested
   struct and array members, and a union whose members are read through the one
   that was last written. */
struct Node;                     /* completed further down */

struct Edge {
    struct Node *to;             /* a pointer to an incomplete type is fine */
    int weight;
};

struct Node {
    int id;
    struct Node *next;           /* at itself */
    struct Edge out[3];          /* at the other, which points back */
    int nout;
};

/* A tag and an ordinary identifier may share a spelling: they live in
   different name spaces. */
struct Point { int x, y; };
int Point = 7;

struct Outer {
    struct Point corners[2];
    struct Inner { int a, b; } in;   /* a tag declared inside another struct */
    int grid[2][3];
};

union Number {
    int i;
    float f;
    struct Point p;
    char bytes[4];
};

int sumEdges(struct Node *n) {
    int i, s = 0;
    for (i = 0; i < n->nout; i++) s += n->out[i].weight;
    return s;
}

int chainLength(struct Node *n) {
    int k = 0;
    while (n) { k++; n = n->next; }
    return k;
}

struct Point addPoints(struct Point a, struct Point b) {
    struct Point r;
    r.x = a.x + b.x;
    r.y = a.y + b.y;
    return r;
}

int main(void) {
    struct Node a, b, c;
    struct Outer o;
    union Number u;
    struct Point p, q, r;
    int i, j;

    /* build a chain a -> b -> c and give a two out-edges */
    c.id = 3; c.next = 0;  c.nout = 0;
    b.id = 2; b.next = &c; b.nout = 0;
    a.id = 1; a.next = &b; a.nout = 2;
    a.out[0].to = &b; a.out[0].weight = 10;
    a.out[1].to = &c; a.out[1].weight = 32;

    printf("%d %d %d\n", chainLength(&a), su