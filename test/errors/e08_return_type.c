/* return type mismatches */
struct S { int a; };

void giveNothing(void) {
    return 1;               /* a value returned from a void function */
}

int giveInt(void) {
    return;                 /* no value returned from an int function */
}

int giveStruct(void) {
    struct S s;
    return s;               /* struct returned where int is expected */
}

int *givePtr(void) {
    char *cp;
    return cp;              /* incompatible pointer type */
}

int main(void) { giveNothing(); return giveInt(); }
