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
    int value = 7;              /* hides the global for the res