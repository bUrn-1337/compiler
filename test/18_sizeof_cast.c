/* 18 -- sizeof (folded to a constant at compile time) and casts. */
struct S { char a; int b; char c; };
union  U { char a[6]; int b; };
typedef int Row[4];
enum E { E0, E1 };

int main(void) {
    char  c;
    int   i;
    int   a[7];
    Row   r;
    struct S s;
    union  U u;
    int   big;

    /* sizeof of a type name */
    printf("%d %d %d\n", (int)sizeof(char), (int)sizeof(int), (int)sizeof(enum E));
    printf("%d %d\n", (int)sizeof(struct S), (int)sizeof(union U));
    printf("%d %d\n", (int)sizeof(Row), (int)sizeof(int[3]));

    /* sizeof of an expression: the expression is NOT evaluated */
    i = 5;
    printf("%d %d %d\n", (int)sizeof i, (int)sizeof c, (int)sizeof a);
    printf("%d %d\n", (int)sizeof r, (int)sizeof s);
    printf("%d %d\n", (int)sizeof u, (int)sizeof a[0]);
    printf("%d\n", (int)sizeof(i + 1));

    /* sizeof is a constant expression, so it can size an array */
    {
        char blob[sizeof(struct S) * 2];
        printf("%d\n", (int)sizeof blob);
    }

    /* integer casts */
    big = 1000;
    c = (char)big;                 /* truncates to 8 bits */
    printf("%d\n", c);
    printf("%d\n", (char)1000);
    printf("%d\n", (int)(char)200);
    c = 'A';
    printf("%d %d\n", (int)c, (int)(c + 1));

    /* a cast in the middle of an expression */
    printf("%d\n", (int)(char)(65 + 256) + 1);

    /* pointer casts: a char* view of an int array, written and read as bytes */
    {
        int   v[2];
        char *cp;
        v[0] = 0; v[1] = 0;
        cp = (char *)v;
        cp[0] = 1;
        printf("%d %d\n", cp[0], v[0] != 0);
    }

    /* void* round trip */
    {
        int   x;
        void *vp;
        int  *ip;
        x = 77;
        vp = (void *)&x;
        ip = (int *)vp;
        printf("%d\n", *ip);
    }
    return 0;
}
