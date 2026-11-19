/* 42 -- shadowing at every level that C allows: a parameter hiding a global, a
   block-local hiding the parameter, nested blocks each with their own name, a
   local hiding a function name, and a loop variable hiding an outer one. */
int value = 100;
int count = 1;

int value_shadow_probe(void);   /* defined at the bottom of the file */

int bump(int value) {           /* the parameter hides the global */
    value = value + 1;
    {
        int value = -5;         /* and a block hides the parameter */
        {
            int value = 42;
            printf("innermost value=%d\n", value);
        }
        printf("middle value=%d\n", value);
    }
    return value;               /* the parameter again */
}

int helper(int n) { return n * 2; }

int outer(int n) {
    int helper = n + 1;         /* a variable hiding the function name */
    return helper * 10;         /* nothing is called here */
}

int main(void) {
    int i;
    int value = 7;              /* hides the global for the rest of main */

    printf("global via function: %d, local: %d\n", bump(10), value);

    {
        int value = value_shadow_probe();
        printf("block value=%d\n", value);
    }

    for (i = 0; i < 2; i++) {
        int i2 = i;
        {
            int i = 90 + i2;    /* hides the loop variable inside the block */
            printf("loop inner i=%d\n", i);
        }
        printf("loop outer i=%d\n", i);
    }

    printf("outer=%d helper=%d\n", outer(4), helper(4));

    /* a name declared in a block disappears with it */
    {
        int count = 50;
        printf("count=%d\n", count);
    }
    printf("count=%d value=%d\n", count, value);

    /* each arm of a statement is its own scope */
    if (value > 0) { int v = 1; printf("then v=%d\n", v); }
    else           { int v = 2; printf("else v=%d\n", v); }
    while (count < 3) { int count2 = count; count = count2 + 1; }
    printf("count now %d\n", count);
    return 0;
}

int value_shadow_probe(void) { return value + count; }
