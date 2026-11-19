/* wrong number of arguments */
int add(int a, int b) { return a + b; }
void nothing(void) { }

int main(void) {
    int x;
    x = add(1);             /* too few */
    x = add(1, 2, 3);       /* too many */
    nothing(7);             /* a void parameter list takes nothing */
    return x;
}
