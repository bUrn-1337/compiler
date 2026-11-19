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

/* solve a 3x3 s