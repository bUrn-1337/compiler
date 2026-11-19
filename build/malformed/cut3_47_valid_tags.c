/* 47 -- struct, union and enum tags: a tag redefined in an inner scope, tags
   declared inside a function, a forward declaration completed later, a tag
   that shares its spelling with a typedef name and with a variable, and
   enumerators with and without explicit values. */
struct S { int a; int b; };
struct Fwd;                        /* completed below */
struct List { int v; struct List *next; };
union  U { int i; char c; };
enum   Color { RED, GREEN = 5, BLUE, LAST = 100 };
enum   Flag { OFF, ON };

struct Fwd { double d; int n; };

typedef struct S S;                /* the typedef and the tag share a name */
int S_count = 0;                   /* and so does an ordinary variable */

struct Both { enum Color c; union U u; struct S s; };

int useFwd(struct Fwd *f) { return f->n + (int)f->d; }

int shadowTag(void) {
    struct S { double x; double y; };   /* a different struct S, here 