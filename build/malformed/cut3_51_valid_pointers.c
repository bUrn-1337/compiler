/* 51 -- pointers: arrays decaying to pointers, pointers to pointers, pointer
   arithmetic and differences, pointers into structs and arrays of structs,
   void * round trips, and null pointers.  No pointer VALUE is printed, since
   the size of a pointer differs between the target and the reference host. */
struct P { int x; int y; };

int sum(int *a, int n) { int s = 0, i; for (i = 0; i < n; i++) s += a[i]; return s; }
int sum2(int a[], int n)  { return sum(a, n); }
int sum3(int a[10], int n) { return sum(a, n); }

/* a pointer to a two-dimensional array's row */
int rowSum(int (*row)[4], int rows) {
    int s = 0, i, j;
    for (i = 0; i < rows; i++)
        for (j = 0; j < 4; j++) s += row[i][j];
    return s;
}

void swap(int *a, int *b) { int t = *a; *a = *b; *b = t; }
void setThrough(int **pp, int v) { **pp = v; }
char *findChar(char *s, char c) {
    while (*s) { if (*s == c) return s; s++; }
    return 0;
}

int main(void) {
    int  a[6];
    int  m[3][4];
    int *p;
    int *q;
    int **pp;
    void *vp;
    char  text[16];
    c