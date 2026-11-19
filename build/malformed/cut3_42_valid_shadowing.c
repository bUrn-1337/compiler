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
    return 