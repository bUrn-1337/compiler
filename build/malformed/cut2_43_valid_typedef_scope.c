/* 43 -- typedef names and scope: a typedef name reused as an ordinary
   identifier in an inner scope, a typedef of a typedef, a typedef name
   redefined to a different type inside a block, and a struct tag that shares
   its spelling with a typedef name. */
typedef int Count;
typedef Count Tally;              /* a typedef of a typedef */
typedef double Real;
typedef char *Text;
typedef struct Pair Pair;         /* the tag and the typedef share a spelling */
struct Pair { Count a; Count b; };
typedef Pair PairAlias;
typedef int (*Op)(Count, Count);

Count gcount = 5;
Real  gratio = 1.25;

Count addc(Count a, Count b) { return a + b; }

int useInner(void) {
    int Count = 11;               /* an ordinary variable named like the typedef */
    int Real;
    Real = Count * 2;
    return Count + Real;          /* 33 */
}

/* a parameter named like a typedef hides it inside the body */
int param(int Count, Real Text) {
    Count = Count + 1;
    Text = Text * 2.0;
    return Count + (int)Text;
}

/* members and labels have namespaces of their own, so they may be spelled
   like a typedef name */
struct Holder { int Count; Real Real; };

int labelled(int n) {
    struct Holder h;
    struct Holder *ph = &h;
    h.Count = n;
    ph->Real = 0.5;
    if (n > 0) goto Count;
    return -1;
Count:
    return h.Count +