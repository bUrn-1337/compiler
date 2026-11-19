/* type mismatch in assignment, initialization and operators */
struct S { int a; };

int main(void) {
    int   i;
    int  *p;
    char *cp;
    struct S s;
    struct S t;

    i = p;                  /* pointer assigned to an integer */
    p = cp;                 /* incompatible pointer types */
    s = i;                  /* struct from an integer */
    i = s;                  /* integer from a struct */
    i = s % 2;              /* % on a struct */
    p = s;                  /* pointer from a struct */
    t = s;                  /* legal: same struct type */
    return i;
}
