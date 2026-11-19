/* 06 -- int and char arrays, array initializers (complete, partial and from a
   string literal), and arrays decaying to pointers when passed to a function. */
int gi[5] = {1, 2, 3, 4, 5};
int gpartial[6] = {7, 8};
int gzero[4];
char gmsg[8] = "glob";
char gstr[] = "auto";

int total(int *v, int n) {
    int i;
    int s;
    s = 0;
    for (i = 0; i < n; i = i + 1) s = s + v[i];
    return s;
}

void bump(int v[], int n) {           /* an array parameter IS a pointer */
    int i;
    for (i = 0; i < n; i = i + 1) v[i] = v[i] + 1;
}

int main(void) {
    int a[5] = {10, 20, 30, 40, 50};
    int part[5] = {1, 2};             /* the rest is zero-filled */
    char buf[8] = "hi";
    char letters[4];
    int i;

    for (i = 0; i < 5; i = i + 1) printf("%d ", a[i]);
    printf("\n");
    for (i = 0; i < 5; i = i + 1) printf("%d ", part[i]);
    printf("\n");
    for (i = 0; i < 6; i = i + 1) prin