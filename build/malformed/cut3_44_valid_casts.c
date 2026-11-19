/* 44 -- casts: nested and repeated casts, casts between pointer types, a cast
   between function-pointer types, casts in conditions and arguments, and the
   narrowing that a cast makes explicit. */
int add(int a, int b) { return a + b; }
typedef int (*Fn)(int, int);
typedef double (*DFn)(double, double);

double dadd(double a, double b) { return a + b; }

struct Bytes { char b[4]; };

int main(void) {
    int    i = 300;
    char   c;
    double d = -2.75;
    float  f;
    int   *p;
    char  *cp;
    void  *vp;
    int    arr[4];
    Fn     fn;
    struct Bytes bs;
    int    k;

    arr[0] = 0x01020304; arr[1] = 2; arr[2] = 3; arr[3] = 4;

    /* nested and repeated casts collapse to