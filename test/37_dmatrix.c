/* 37 -- matrices of doubles: multiplication, transposition, a determinant by
   expansion, and a linear system solved by Gaussian elimination with partial
   pivoting.  Everything is passed as a pointer to the first row, the way C
   handles a two-dimensional array. */
double dabs(double v) { return v < 0.0 ? -v : v; }

void matmul(double a[3][3], double b[3][3], double out[3][3]) {
    int i, j, k;
    for (i = 0; i < 3; i++)
        for (j = 0; j < 3; j++) {
            double s = 0.0;
            for (k = 0; k < 3; k++) s += a[i][k] * b[k][j];
            out[i][j] = s;
        }
}

void transpose(double a[3][3], double out[3][3]) {
    int i, j;
    for (i = 0; i < 3; i++)
        for (j = 0; j < 3; j++) out[j][i] = a[i][j];
}

double det3(double m[3][3]) {
    return m[0][0] * (m[1][1] * m[2][2] - m[1][2] * m[2][1])
         - m[0][1] * (m[1][0] * m[2][2] - m[1][2] * m[2][0])
         + m[0][2] * (m[1][0] * m[2][1] - m[1][1] * m[2][0]);
}

void show(char *tag, double m[3][3]) {
    int i, j;
    printf("%s\n", tag);
    for (i = 0; i < 3; i++) {
        for (j = 0; j < 3; j++) printf("%10.4f", m[i][j]);
        printf("\n");
    }
}

/* solve a 3x3 system in place; returns 0 if the matrix is singular */
int solve(double a[3][3], double *b, double *x) {
    int i, j, k;
    for (i = 0; i < 3; i++) {
        int piv = i;
        for (k = i + 1; k < 3; k++)
            if (dabs(a[k][i]) > dabs(a[piv][i])) piv = k;
        if (dabs(a[piv][i]) < 1e-12) return 0;
        if (piv != i) {
            double t;
            for (j = 0; j < 3; j++) { t = a[i][j]; a[i][j] = a[piv][j]; a[piv][j] = t; }
            t = b[i]; b[i] = b[piv]; b[piv] = t;
        }
        for (k = i + 1; k < 3; k++) {
            double f = a[k][i] / a[i][i];
            for (j = i; j < 3; j++) a[k][j] -= f * a[i][j];
            b[k] -= f * b[i];
        }
    }
    for (i = 2; i >= 0; i--) {
        double s = b[i];
        for (j = i + 1; j < 3; j++) s -= a[i][j] * x[j];
        x[i] = s / a[i][i];
    }
    return 1;
}

int main(void) {
    double a[3][3];
    double b[3][3];
    double c[3][3];
    double t[3][3];
    double sys[3][3];
    double rhs[3];
    double x[3];
    int i, j;

    for (i = 0; i < 3; i++)
        for (j = 0; j < 3; j++) a[i][j] = (i + 1) * 1.5 + j * 0.25;
    b[0][0] = 1.0; b[0][1] = 0.0; b[0][2] = 2.0;
    b[1][0] = -1.0; b[1][1] = 3.0; b[1][2] = 0.5;
    b[2][0] = 0.0; b[2][1] = 1.0; b[2][2] = -2.0;

    show("a", a);
    show("b", b);
    matmul(a, b, c);
    show("a*b", c);
    transpose(c, t);
    show("(a*b)T", t);
    printf("det a = %.6f  det b = %.6f  det(a*b) = %.6f\n",
           det3(a), det3(b), det3(c));
    printf("det(a*b) == det a * det b: %d\n",
           dabs(det3(c) - det3(a) * det3(b)) < 1e-9);

    sys[0][0] = 2.0; sys[0][1] = 1.0; sys[0][2] = -1.0; rhs[0] = 8.0;
    sys[1][0] = -3.0; sys[1][1] = -1.0; sys[1][2] = 2.0; rhs[1] = -11.0;
    sys[2][0] = -2.0; sys[2][1] = 1.0; sys[2][2] = 2.0; rhs[2] = -3.0;
    if (solve(sys, rhs, x))
        printf("x = %.6f %.6f %.6f\n", x[0], x[1], x[2]);
    else
        printf("singular\n");

    /* a singular system is detected rather than dividing by zero */
    sys[0][0] = 1.0; sys[0][1] = 2.0; sys[0][2] = 3.0; rhs[0] = 1.0;
    sys[1][0] = 2.0; sys[1][1] = 4.0; sys[1][2] = 6.0; rhs[1] = 2.0;
    sys[2][0] = 3.0; sys[2][1] = 6.0; sys[2][2] = 9.0; rhs[2] = 3.0;
    printf("singular detected: %d\n", solve(sys, rhs, x) == 0);
    printf("%d %d\n", (int)sizeof(a), (int)sizeof(a[0]));
    return 0;
}
