/* 21 -- a realistic mixed program: matrix arithmetic over multi-dimensional
   arrays passed to functions, with nested loops and a cofactor determinant.
   There is no preprocessor in this language, so the dimension is written out. */

void multiply(int a[][3], int b[][3], int out[][3], int n) {
    int i;
    int j;
    int k;
    for (i = 0; i < n; i = i + 1)
        for (j = 0; j < n; j = j + 1) {
            int s;
            s = 0;
            for (k = 0; k < n; k = k + 1) s = s + a[i][k] * b[k][j];
            out[i][j] = s;
        }
}

void transpose(int a[][3], int out[][3], int n) {
    int i;
    int j;
    for (i = 0; i < n; i = i + 1)
        for (j = 0; j < n; j = j + 1) out[j][i] = a[i][j];
}

void show(char *label, int a[][3], int n) {
    int i;
    int j;
    printf("%s\n", label);
    for (i = 0; i < n; i = i + 1) {
        for (j = 0; j < n; j = j + 1) printf("%5d", a[i][j]);
        printf("\n");
    }
}

int trace(int a[][3], int n) {
    int i;
    int t;
    t = 0;
    for (i = 0; i < n; i = i + 1) t = t + a[i][i];
    return t;
}

int det3(int a[][3]) {
    return a[0][0] * (a[1][1] * a[2][2] - a[1][2] * a[2][1])
         - a[0][1] * (a[1][0] * a[2][2] - a[1][2] * a[2][0])
         + a[0][2] * (a[1][0] * a[2][1] - a[1][1] * a[2][0]);
}

in