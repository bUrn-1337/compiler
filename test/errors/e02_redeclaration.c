/* redeclaration in the same scope */
int g;
char g;                     /* same scope, different type */

int main(void) {
    int x;
    int x;                  /* same block */
    {
        int x;              /* legal: an inner scope shadows */
        x = 1;
    }
    return x;
}
