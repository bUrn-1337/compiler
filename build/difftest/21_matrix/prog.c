/* test/prelude.h -- prepended to each test program ONLY when it is compiled by
 * gcc as the reference implementation (see verify.sh).  The generator itself
 * never sees this file: the source language has no preprocessor, so printf,
 * malloc, fopen and friends are built into the compiler, and `until` is a
 * language extension rather than a macro.
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define until(c) while (!(c))
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

int isSymmetric(int a[][3], int n) {
    int i;
    int j;
    for (i = 0; i < n; i = i + 1)
        for (j = 0; j < n; j = j + 1)
            if (a[i][j] != a[j][i]) return 0;
    return 1;
}

int main(void) {
    int a[3][3];
    int b[3][3];
    int c[3][3];
    int t[3][3];
    int i;
    int j;
    int flat[9];
    int *p;

    /* fill a with a predictable pattern and b with the identity times 2 */
    for (i = 0; i < 3; i = i + 1)
        for (j = 0; j < 3; j = j + 1) {
            a[i][j] = i * 3 + j + 1;
            b[i][j] = (i == j) ? 2 : 0;
        }

    show("a:", a, 3);
    show("b:", b, 3);

    multiply(a, b, c, 3);
    show("a*b:", c, 3);

    transpose(a, t, 3);
    show("a^T:", t, 3);

    multiply(a, t, c, 3);
    show("a*a^T:", c, 3);

    printf("trace(a)=%d trace(a*a^T)=%d\n", trace(a, 3), trace(c, 3));
    printf("det(a)=%d det(b)=%d\n", det3(a), det3(b));
    printf("sym(a)=%d sym(a*a^T)=%d\n", isSymmetric(a, 3), isSymmetric(c, 3));

    /* a 2-D array is one contiguous block: walk it as a flat vector */
    p = &a[0][0];
    for (i = 0; i < 9; i = i + 1) flat[i] = p[i];
    for (i = 0; i < 9; i = i + 1) printf("%d ", flat[i]);
    printf("\n");
    printf("a[1][2]=%d p[5]=%d *(*(a+1)+2)=%d\n", a[1][2], p[5], *(*(a + 1) + 2));
    return 0;
}
