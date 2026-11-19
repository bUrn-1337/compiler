/* indexing something that is neither an array nor a pointer, and a
   non-integer subscript */
struct S { int a; };

int main(void) {
    int    n;
    int    a[4];
    int   *p;
    struct S s;
    int    r;

    r = a[1];               /* legal */
    r = p[1];               /* legal: a pointer may be indexed */
    r = n[2];               /* an int cannot */
    r = s[0];               /* nor a struct */
    r = a[p];               /* the subscript must be an integer */
    return r;
}
