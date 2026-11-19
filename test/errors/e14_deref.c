/* dereferencing something that is not a pointer */
struct S { int a; };

int main(void) {
    int    n;
    char   c;
    struct S s;
    int    r;
    n = 1;
    r = *n;                 /* int is not a pointer */
    r = *c;                 /* char is not a pointer */
    r = *s;                 /* struct is not a pointer */
    r = *(n + 1);           /* nor is an int expression */
    return r;
}
