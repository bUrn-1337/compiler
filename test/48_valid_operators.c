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
    box.n += 5; box.n -= 2; box.n *= 3; box.n /= 2; box.n %= 7;
    printf("%d\n", box.n);
    box.arr[1] <<= 2; box.arr[2] >>= 1; box.arr[0] |= 8;
    printf("%d %d %d\n", box.arr[0], box.arr[1], box.arr[2]);
    box.self->n += 100;
    printf("%d %d\n", box.n, box.self->self->n);
    *p += 50;
    p[1] *= 4;
    *(p + 2) -= 1;
    printf("%d %d %d %d\n", arr[0], arr[1], arr[2], arr[3]);

    /* shifts stay inside the width of an int, and only by positive amounts */
    printf("%d %d %d\n", 1 << 0, 1 << 10, 1024 >> 3);
    printf("%d %d\n", -16 >> 2, 255 & 0x0f);
    printf("%d %d %d\n", 7 ^ 7, 7 ^ 0, 0xff ^ 0x0f);

    /* ++ and -- in prefix and postfix form, one object per statement */
    a = 5;
    printf("%d ", a++);
    printf("%d ", a);
    printf("%d ", ++a);
    printf("%d ", a--);
    printf("%d\n", --a);
    i = 0;
    arr[i++] = 99;
    printf("%d %d\n", arr[0], i);

    /* sizeof binds tighter than + and takes a parenthesized type */
    printf("%d %d %d\n", (int)sizeof a + 1, (int)sizeof(int) * 2,
           (int)sizeof arr / (int)sizeof arr[0]);

    /* && and || stop as soon as the answer is known */
    calls = 0;
    x = (a > 0) || side(&calls, 1);
    printf("%d calls=%d\n", x, calls);
    x = (a < 0) && side(&calls, 1);
    printf("%d calls=%d\n", x, calls);
    x = (a > 0) && side(&calls, 1);
    printf("%d calls=%d\n", x, calls);

    /* a chain of relations, and the value of a comparison */
    printf("%d %d %d\n", (a > 0) + (b > 0), a != b, (a == a) * 10);
    printf("%d\n", (a > b ? a : b) % 3);
    return 0;
}
