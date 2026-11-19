/* Several unrelated errors in one file: every one of them must be reported,
   and no IR file may be left behind. */
int g;
char g;                                 /* 1. conflicting types */

struct Point { int x; int y; };

int takesTwo(int a, int b) { return a + b; }

void voidFunc(void) {
    return 7;                           /* 2. value returned from void */
}

int main(void) {
    int    i;
    int   *p;
    int    a[3];
    struct Point pt;

    i = undefinedVar;                   /* 3. undeclared identifier */
    i = alsoUndefined(1);               /* 4. undeclared function */
    i = takesTwo(1);                    /* 5. wrong argument count */
    i = takesTwo(pt, 2);                /* 6. wrong argument type */
    i = p;                              /* 7. type mismatch */
    5 = i;                              /* 8. assignment to a non-lvalue */
    i = pt.missing;                     /* 9. unknown member */
    i = *i;                             /* 10. dereference of a non-pointer */
    i = i[0];                           /* 11. indexing a non-array */
    continue;                           /* 12. continue outside a loop */
    case 2:                             /* 13. case outside a switch */
        i = 1;
    switch (i) {
        case 1: break;
        case 1: break;                  /* 14. duplicate case value */
    }
    goto missingLabel;                  /* 15. undefined label */
    {
        int x;
        int x;                          /* 16. redeclaration in a block */
        x = a[0];
    }
    return i;
}
