/* 25 -- arrays of float and double: one- and multi-dimensional, pointer
   arithmetic with 4- and 8-byte scaling, and floats passed through pointers. */
double garr[3] = {1.0, 2.5, 4};         /* 4 converts to 4.0 */
float  gfa[4] = {0.5f, 1.5f, 2.5f};     /* the tail is zero-filled */
double gmat[2][2] = { {1.5, 2.5}, {3.5, 4.5} };

double sum(double *a, int n) {
    double s = 0.0;
    int i;
    for (i = 0; i < n; i++) s += a[i];
    return s;
}

float fmax3(float *a) {
    float m = a[0];
    if (a[1] > m) m = a[1];
    if (a[2] > m) m = a[2];
    return m;
}

void scaleRow(double *row, int n, double k) {
    int i;
    for (i = 0; i < n; i++) *(row + i) = row[i] * k;
}

int main(void) {
    double a[5];
    double m[3][4];
    float  fa[4];
    double *p;
    float  *q;
    int i, j;

    for (i = 0; i < 5; i++) a[i] = (double)i + 0.5;
    printf("%.6f %.6f\n", sum(a, 5), a[4]);

    /* pointer arithmetic scales by 8 for double, 4 for float */
    p = a;
    printf("%.1f %.1f %.1f\n", *p, *(p + 3), p[2]);
    p += 2;
    printf("%.1f %d\n", *p, (int)(p - a));
    p--;
    printf("%.1f %d %d\n", *p, p == a + 1, *p < *(p + 1));

    for (i = 0; i < 4; i++) fa[i] = (float)i + 0.25f;
    q = fa;
    printf("%.2f %.2f %.2f\n", (double)*q, (double)q[3], (double)fmax3(fa));
    q = q + 2;
    printf("%.2f %d\n", (double)*q, (int)(q - fa));

    /* a matrix of doubles, filled row by row */
    for (i = 0; i < 3; i++)
        for (j = 0; j < 4; j++)
            m[i][j] = i * 4 + j + 0.5;
    scaleRow(m[1], 4, 2.0);
    for (i = 0; i < 3; i++) {
        for (j = 0; j < 4; j++) printf("%6.2f", m[i][j]);
        printf("\n");
    }
    printf("%.2f %.2f\n", sum(m[0], 4), sum(&m[2][0], 4));

    /* globals, including a two-dimensional one */
    printf("%.2f %.2f %.2f\n", garr[0], garr[1], garr[2]);
    printf("%.2f %.2f %.2f %.2f\n", (double)gfa[0], (double)gfa[1],
           (double)gfa[2], (double)gfa[3]);
    printf("%.2f %.2f\n", gmat[0][1], gmat[1][0]);
    printf("%d %d %d\n", (int)sizeof(a), (int)sizeof(fa), (int)sizeof(gmat));
    return 0;
}
