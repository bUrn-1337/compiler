/* calling an undeclared function, and calling something that is not one */
int main(void) {
    int x;
    int v;
    x = mystery(1, 2);      /* never declared anywhere */
    x = v(3);               /* v is an int, not a function */
    return x;
}
