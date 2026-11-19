/* Function pointers that do not match the function, or the pointer, they are
   being made from. */
typedef int (*BinOp)(int, int);

int    add(int a, int b)      { return a + b; }
int    neg(int a)             { return -a; }
double dscale(double x)       { return x * 2.0; }
void   sink(int a)            { (void)a; }

int (*wrongReturn(void))(int, int) {
    return neg;             /* 1. a one-argument function as a BinOp */
}

int main(void) {
    int (*fp)(int, int);
    int (*one)(int);
    double (*dp)(double);
    BinOp t;
    int i = 0;

    fp = neg;               /* 2. wrong number of parameters */
    fp = dscale;            /* 3. wrong parameter and return types */
    one = add;              /* 4. the other way round */
    dp = add;               /* 5. int(int,int) as double(double) */
    t = sink;               /* 6. through a typedef name */
    fp = 1;                 /* 7. an integer without a cast */
    fp = i;                 /* 8. an int variable without a cast */
    i = fp;                 /* 9. a function pointer assigned to an int */
    fp = &i;                /* 10. a data pointer as a function pointer */
    return i;
}
