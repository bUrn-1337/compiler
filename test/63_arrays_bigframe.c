/* 63 -- 2D and 3D arrays (row-major, indexed and walked with pointers,
   passed to functions), and stack frames larger than 32 KB, so that frame
   offsets do not fit a 16-bit immediate: big local arrays, scalars that
   live beyond them, a recursive function with a large frame, and a large
   struct copied by value.  The three big-frame parts run one after the
   other so the stack stays within spim's default limit (README). */
int grid[4][5];
double cube[3][4][5];

int trace(int m[][5], int n) {
    int i, t;
    t = 0;
    for (i = 0; i < n; i++) t = t + m[i][i];
    return t;
}

double cube_sum(double c[][4][5]) {
    int i, j, k;
    double t;
    t = 0;
    for (i = 0; i < 3; i++)
        for (j = 0; j < 4; j++)
            for (k = 0; k < 5; k++) t = t + c[i][j][k];
    return t;
}

/* 40 KB of locals per call */
int deep(int n) {
    int buf[10000];
    int i, s;
    for (i = 0; i < 10000; i++) buf[i] = n + i;
    if (n == 0) return buf[9999];
    s = deep(n - 1);
    return s + buf[0] + buf[9999] - buf[5000];
}

struct Huge { int a[9000]; double d; char tag; };

struct Huge fill(int k) {
    struct Huge h;
    int i;
    for (i = 0; i < 9000; i++) h.a[i] = i * k;
    h.d = k / 4.0;
    h.tag = 'a' + k;
    return h;
}

int check(struct Huge h) {
    return h.a[0] + h.a[1] + h.a[8999] + h.tag;
}

/* a 70 KB frame with scalars beyond the array */
int part_big(void) {
    char big[70000];
    int after;
    double dafter;
    int i;
    after = 12345;
    dafter = 2.5;
    for (i = 0; i < 70000; i++) big[i] = i % 100;
    printf("big: %d %d %d after=%d dafter=%.1f\n", big[0], big[69999], big[35555], after, dafter);
    return after;
}

/* a 36 KB struct returned, held and passed by value */
void part_huge(void) {
    struct Huge h;
    h = fill(3);
    printf("huge: %d %d %.2f %c check=%d\n", h.a[100], h.a[8999], h.d, h.tag, check(h));
    printf("huge from call: %d\n", check(fill(2)));
}

int main(void) {
    int local3[2][3][4];
    int after;
    int i, j, k;
    int *p;
    for (i = 0; i < 4; i++)
        for (j = 0; j < 5; j++) grid[i][j] = i * 10 + j;
    printf("grid[2][3]=%d trace=%d\n", grid[2][3], trace(grid, 4));
    p = &grid[0][0];
    printf("flat: %d %d %d\n", p[7], *(p + 19), *(grid[3] + 1));
    for (i = 0; i < 3; i++)
        for (j = 0; j < 4; j++)
            for (k = 0; k < 5; k++) cube[i][j][k] = i + j * 0.5 + k * 0.25;
    printf("cube[2][3][4]=%.2f sum=%.2f\n", cube[2][3][4], cube_sum(cube));
    for (i = 0; i < 2; i++)
        for (j = 0; j < 3; j++)
            for (k = 0; k < 4; k++) local3[i][j][k] = i * 100 + j * 10 + k;
    printf("local3: %d %d %d sizeof %d %d %d\n", local3[1][2][3], local3[0][1][2], local3[1][0][0],
           sizeof(local3), sizeof(local3[0]), sizeof(local3[0][0]));
    after = part_big();
    printf("deep(3) = %d\n", deep(3));
    part_huge();
    return after % 100;
}
