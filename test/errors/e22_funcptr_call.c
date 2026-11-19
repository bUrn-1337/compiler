/* Calls that are not calls, and calls through a function pointer whose
   signature does not match. */
int add(int a, int b) { return a + b; }
double scale(double x) { return x * 2.0; }

struct S { int x; };

int main(void) {
    int i = 1;
    int *p = &i;
    struct S s;
    int (*fp)(int, int) = add;
    double (*dp)(double) = scale;

    s.x = 0;
    i = i(1);               /* 1. calling an int */
    i = p(1);               /* 2. calling a pointer to int */
    i = s(1);               /* 3. calling a struct */
    i = fp(1);              /* 4. too few arguments through a pointer */
    i = fp(1, 2, 3);        /* 5. too many arguments through a pointer */
    i = fp(&i, 2);          /* 6. wrong argument type through a pointer */
    i = (*fp)(p, 2);        /* 7. the same through an explicit dereference */
    i = dp(&i);             /* 8. a pointer where a double is expected */
    return i;
}
