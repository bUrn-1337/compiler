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

    /* sizeof is a constant expression, so it can size an 