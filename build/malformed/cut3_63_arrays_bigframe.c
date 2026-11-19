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
    if (n == 0) return bu