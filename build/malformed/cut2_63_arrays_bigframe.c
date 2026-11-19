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
    