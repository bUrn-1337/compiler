/* 08 -- pointers: address-of, dereference, pointer arithmetic (scaled by the
   element size), pointer difference, multi-level pointers, and *p++. */
int g = 100;
int *gp = &g;

void setTo(int *p, int v) { *p = v; }
void swap(int *a, int *b) { int t; t = *a; *a = *b; *b = t; }

int main(void) {
    int x;
    int y;
    int *p;
    int *q;
    int **pp;
    int ***ppp;
    int a[6] = {0, 10, 20, 30, 40, 50};
    char s[6] = "abcde";
    char *cp;
    int i;

    x = 1; y = 2;
    p = &x;
    printf("%d %d\n", *p, x);
    *p = 7;
    printf("%d\n", x);

    pp = &p;
    printf("%d\n", **pp);
    **pp = 9;                       /* one load, then a store */
    printf("%d\n", x);

    ppp = &pp;
    printf("%d\n", ***ppp);
    ***ppp = 11;
    printf("%d\n", x);

    /* a pointer can be repointed */
    p = &y;
    printf("%d %d\n", *p, **pp);

    /* pointer arithmetic scales by the element size */
    p = a;
    printf("%d %d %d\n", *p, *(p + 3), p[5]);
    q = a + 4;
    printf("%d %d\n", *q, (int)(q - p));
    printf("%d\n", (int)(&a[5] - &a[2]));

    /* &arr[2] is the same as arr + 2 */