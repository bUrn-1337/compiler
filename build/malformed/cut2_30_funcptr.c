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
    int (*fp)