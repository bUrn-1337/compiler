/* A floating-point value used where only an integer, a pointer or a struct
   will do. */
struct P { int x; int y; };

void takesPtr(int *p) { (void)p; }
void takesStruct(struct P p) { (void)p; }

int main(void) {
    float f = 1.5f;
    double d = 2.5;
    int a[4];
    int *p;
    struct P s;

    a[f] = 1;               /* 1. a float as an array subscript */
    switch (d) {            /* 2. a float as the switch expression */
        case 1: break;
        default: break;
    }
    switch (3) {
        case 1.5: break;    /* 3. a float as a case label */
        default: break;
    }
    p = f;                  /* 4. float converted to a pointer */
    d = p;                  /* 5. pointer converted to a double */
    takesPtr(d);            /* 6. a double where a pointer is expected */
    takesStruct(f);         /* 7. a float where a struct is expected */
    s = d;                  /* 8. a double assigned to a struct */
    f = s;                  /* 9. a struct assigned to a float */
    return (int)f;
}
