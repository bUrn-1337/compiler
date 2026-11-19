/* 61 -- tables of function pointers: dispatch by index, a table in a
   struct, functions returning function pointers, pointers compared and
   passed as callbacks, and a tiny stack machine driven by a table. */
typedef int (*binop)(int, int);

int add(int a, int b) { return a + b; }
int sub(int a, int b) { return a - b; }
int mul(int a, int b) { return a * b; }
int quo(int a, int b) { if (b == 0) return 0; return a / b; }
int maxi(int a, int b) { return a > b ? a : b; }

binop table[5];
char *names[5];

struct op { char sym; binop fn; };

binop pick(char c) {
    if (c == '+') return add;
    if (c == '-') return sub;
    if (c == '*') return mul;
    return quo;
}

int fold(int *v, int n, binop f, int init) {
    int i;
    for (i = 0; i < n; i++) init = f(init, v[i]);
    return init;
}

double apply_d(double (*f)(double), double x, int times) {
    while (times-- > 0) x = f(x);
    return x;
}
double half(double x) { return x / 2; }
double sq(double x) { return x * x; }

/* runs a postfix program: digits push, operators pop two and push one */
int machine(char *prog) {
    int stack[32];
    int sp, i;
    struct op ops[4];
    sp = 0;
    ops[0].sym = '+'; ops[0].fn = add;
    ops[1].sym = '-'; ops[1].fn = sub;
    ops[2].sym = '*'; ops[2].fn = mul;
    ops[3].sym = '/'; ops[3].fn = quo;
    for (; *prog; prog++) {
      