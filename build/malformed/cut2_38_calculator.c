/* 38 -- a calculator driven by a dispatch table: each operator character is
   paired with a function pointer, the table is searched once per expression,
   and the operands are read as doubles from standard input
   (test/input/38_calculator.in). */
typedef double (*BinOp)(double, double);

double opAdd(double a, double b) { return a + b; }
double opSub(double a, double b) { return a - b; }
double opMul(double a, double b) { return a * b; }
double opDiv(double a, double b) { return b == 0.0 ? 0.0 : a / b; }
double opMin(double a, double b) { return a < b ? a : b; }
double opMax(double a, double b) { return a > b ? a : b; }
double opPow(double a, double b) {              /* integer exponent only */
    double r = 1.0;
    int n = (int)b;
    int i;
    if (n < 0) { for (i = 0; i < -n; i++) r *= a; return a == 0.0 ? 0.0 : 1.0 / r; }
    for (i = 0; i < n; i++) r *= a;
    return r;
}

struct Entry { char op; BinOp fn; char *name; };

struct Entry table[7] = {
    { '+', opAdd, "add" },
    { '-', opSub, "sub" },
    { '*', opMul, "mul" },
    { '/', opDiv, "div" },
    { '<', opMin, "min" },
    { '>', opMax, "max" },
    { '^', opPow, "pow" }
};

BinOp lookup(char op, char **name) {
  