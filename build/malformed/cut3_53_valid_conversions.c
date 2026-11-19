/* 53 -- the conversions a program performs without a cast: char and enum to
   int, int to double at assignment, argument, return and comparison, the
   usual arithmetic conversions in mixed expressions, and the truncation that
   an assignment to a narrower type performs.  Every value stays inside the
   range of its type, so nothing here overflows. */
enum Size { SMALL = 1, MEDIUM = 10, LARGE = 100 };

double asDouble(double v) { return v; }
int    asInt(int v)       { return v; }
char   asChar(char v)     { return v; }
double ratio(int a, int b) { return (double)a / b; }
int    truncate(double v) { return v; }      /* the return converts */

struct Mixed { char c; int i; double d; float f; };

int main(void) {
    char   c = 'A';
    char   small = 100;
    int    i = 1000;
    double d = 2.5;
    float  f = 1.5f;
    enum Size s = MEDIUM;
    struct Mixed m;
    double acc;
    int    k;

    /* char and enum behave as int in an expression */
    printf("%d %d 