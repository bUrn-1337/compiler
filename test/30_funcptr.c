/* 30 -- function pointers: declaration, assignment from a function name and
   from &f, calls as fp(a,b) and (*fp)(a,b), a typedef'd pointer type, an array
   of pointers, a pointer inside a struct, a function returning one, global
   initializers, and comparison against another pointer and against 0. */
int add(int a, int b) { return a + b; }
int sub(int a, int b) { return a - b; }
int mul(int a, int b) { return a * b; }

typedef int (*BinOp)(int, int);

struct Calc { char name; BinOp fn; };

int (*gfp)(int, int) = add;
BinOp gtab[2] = { add, sub };

int apply(int (*f)(int, int), int a, int b) { return f(a, b); }
BinOp pick(int i) { return i ? sub : add; }

int main(void) {
    int (*fp)(int, int);
    BinOp ops[3];
    struct Calc c;
    int i;

    fp = add;
    printf("fp=%d (*fp)=%d\n", fp(3, 4), (*fp)(10, 4));
    fp = &sub;
    printf("sub=%d\n", fp(10, 4));
    printf("apply=%d\n", apply(mul, 6, 7));
    printf("global=%d %d %d\n", gfp(1, 2), gtab[0](5, 5), gtab[1](5, 3));

    ops[0] = add; ops[1] = sub; ops[2] = mul;
    for (i = 0; i < 3; i++) printf("ops[%d](9,3)=%d\n", i, ops[i](9, 3));

    c.name = '+'; c.fn = add;
    printf("c.fn=%d %c\n", c.fn(2, 3), c.name);

    printf("pick=%d %d\n", pick(0)(8, 2), pick(1)(8, 2));

    printf("cmp: %d %d %d %d\n", fp == add, fp == sub, fp != 0, add == add);
    fp = 0;
    printf("null=%d\n", fp == 0);
    return 0;
}
