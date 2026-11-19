/* unknown struct/union member, and member access on a non-aggregate */
struct Point { int x; int y; };
union  U     { int i; char c; };

int main(void) {
    struct Point p;
    struct Point *pp;
    union  U u;
    int   n;
    int   r;

    p.x = 1;                /* legal */
    r = p.z;                /* Point has no member z */
    pp = &p;
    r = pp->w;              /* nor w */
    r = u.missing;          /* U has no member missing */
    r = n.x;                /* n is an int */
    r = p->x;               /* '->' applied to a non-pointer */
    r = pp.x;               /* '.' applied to a pointer */
    return r;
}
