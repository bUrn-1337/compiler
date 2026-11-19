/* wrong argument types */
struct S { int a; };
int takesInt(int n)    { return n; }
int takesPtr(int *p)   { return *p; }

int main(void) {
    struct S s;
    char *cp;
    int   x;
    x = takesInt(s);        /* struct where an int is expected */
    x = takesPtr(cp);       /* char * where int * is expected */
    x = takesPtr(3);        /* integer where a pointer is expected */
    return x;
}
