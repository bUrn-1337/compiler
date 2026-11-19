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
    ***