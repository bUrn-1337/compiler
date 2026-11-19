/* 48 -- operator corners that are all well defined: precedence and
   associativity, the comma operator, compound assignment on members and
   through pointers, bit operations and shifts, and sizeof's precedence.
   Each statement modifies an object at most once, so nothing here depends on
   the order in which a compiler evaluates operands. */
int side(int *c, int v) { *c = *c + 1; return v; }

struct Box { int n; int arr[3]; struct Box *self; };

int main(void) {
    int a = 2;
    int b = 3;
    int c = 4;
    int x;
    int arr[4];
    int *p;
    struct Box box;
    int calls = 0;
    int i;

    arr[0] = 1; arr[1] = 2; arr[2] = 3; arr[3] = 4;
    p = arr;

    /* precedence: * before +, + before <<, relational before equality */
    printf("%d %d %d\n", a + b * c, (a + b) * c, a + b << 1);
    printf("%d %d %d\n", a < b == 1, a < (b == 1), a & b | c);
    printf("%d %d\n", a | b ^ c, (a | b) ^ c);
    printf("%d %d\n", ~a, -~a);
    printf("%d %d %d\n", !a, !!a, !a + 1);

    /* associativity: assignment and the conditional go right to left */
    x = a = b = 7;
    printf("%d %d %d %d\n", x, a, b, c);
    a = 2; b = 3;

    /* the comma operator: both sides run, the right one is the value */
    x = (a = 10, b = 20, a + b);
    printf("%d %d %d\n", x, a, b);
    for (i = 0, x = 10; i < x; i++, x--) ;
    printf("%d %d\n", i, x);
    a = 2; b = 3;

    /* compound assignment, including on a member and through a pointer */
    box.n = 10;
    box.arr[0] = 1; box.arr[1] = 2; box.arr[2] = 3;
    box.self = &box;
    box.n 