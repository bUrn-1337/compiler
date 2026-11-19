/* Several unrelated mistakes in the three new features, in one file: every one
   of them must be reported, and no IR file may be left behind. */
struct P { int x; double y; };
struct Q { int x; };

int    add(int a, int b)   { return a + b; }
void   takeP(struct P p)   { (void)p; }
double half(double d)      { return d / 2.0; }

int main(void) {
    float  f = 1.5f;
    double d = 2.5;
    int    i = 0;
    int    a[4];
    struct P p;
    struct Q q;
    int (*fp)(int, int) = add;

    p.x = 0; p.y = 0.0; q.x = 0; a[0] = 0;

    i = f % 2;              /* 1. '%' on a float */
    i = ~d;                 /* 2. '~' on a double */
    a[d] = 1;               /* 3. a double as a subscript */
    i = p + q;              /* 4. '+' on two structs */
    p = q;                  /* 5. assignment between different struct types */
    takeP(f);               /* 6. a float where a struct is expected */
    i = fp(1);              /* 7. too few arguments through a function pointer */
    fp = half;              /* 8. an incompatible signature */
    fp = 7;                 /* 9. an integer without a cast */
    d = i(1);               /* 10. calling an int */
    return i;
}
