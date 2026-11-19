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

    /* associativity: assignment and the 