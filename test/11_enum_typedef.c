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
    printf("%d %d %d %d %d\n", OK, WARN, ERR, FATAL, AFTER);

    c = BLUE;
    switch (c) {
        case RED:   printf("red\n");   break;
        case GREEN: printf("green\n"); break;
        case BLUE:  printf("blue\n");  break;
    }

    e = ERR;
    printf("%d %d\n", e, e == 11);

    /* enum constants are usable in constant expressions */
    int table[BLUE + 1];
    for (i = 0; i <= BLUE; i = i + 1) table[i] = i * i;
    printf("%d %d %d\n", table[0], table[1], table[2]);

    i = 5;
    p = &i;
    *p = 6;
    printf("%d\n", i);

    s[0] = 'h'; s[1] = 'e'; s[2] = 'y'; s[3] = 0;
    printf("%s %d\n", s, (int)sizeof s);

    pr.a = 2; pr.b = 3;
    pp = &pr;
    printf("%d %d\n", addPair(&pr), addPair(pp));
    printf("%d\n", (int)sizeof(Pair));

    /* a typedef inside a block shadows the outer meaning of the name and ends
       with the block */
    {
        typedef char Int;            /* here Int means char */
        Int small;
        small = 'q';
        printf("%c %d\n", small, (int)sizeof(Int));
    }
    i = 9;                           /* out here Int is int again */
    {
        Int wide;
        wide = 70000;
        printf("%d %d\n", wide, (int)sizeof(Int));
    }

    /* enum as a value and in arithmetic */
    printf("%d\n", GREEN + BLUE * 2);
    return 0;
}
