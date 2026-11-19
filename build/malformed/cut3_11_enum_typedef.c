/* 11 -- enum constants (compile-time integers) and typedef names, including
   typedefs of pointers, arrays and structs, and a typedef local to a block. */
enum Color { RED, GREEN, BLUE };
enum Code { OK = 0, WARN = 10, ERR, FATAL = 100, AFTER };

typedef int          Int;
typedef int         *IntPtr;
typedef char         Str[16];
typedef struct Pair { Int a; Int b; } Pair;
typedef Pair        *PairPtr;
typedef enum Color   Color;

Int addPair(PairPtr p) { return p->a + p->b; }

int main(void) {
    Color c;
    enum Code e;
    Int i;
    IntPtr p;
    Str s;
    Pair pr;
    PairPtr pp;

    printf("%d %d %d\n", RED, GREEN, BLUE);
    pri