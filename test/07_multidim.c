/* 07 -- multi-dimensional arrays: row-major layout, mixed subscript and
   pointer forms, and 2-D arrays passed to functions. */
int grid[3][4];
int cube[2][2][3];

int rowsum(int m[][4], int row) {
    int j;
    int s;
    s = 0;
    for (j = 0; j < 4; j = j + 1) s = s + m[row][j];
    return s;
}

int main(void) {
    int a[3][4];
    int b[2][3] = {{1, 2, 3}, {4, 5, 6}};
    int c[2][3] = {{1}, {4, 5}};        /* partially initialised */
    int i;
    int j;
    int k;

    for (i = 0; i < 3; i = i + 1)
        for (j = 0; j < 4; j = j + 1)
            a[i][j] = i * 10 + j;

    for (i = 0; i < 3; i = i + 1) {
        for (j = 0; j < 4; j = j + 1) printf("%d ", a[i][j]);
        printf("\n");
    }

    /* the three equivalent ways of reaching a[1][2] */
    printf("%d %d %d\n", a[1][2], *(*(a + 1) + 2), *(a[1] + 2));

    /* row stride is sizeof(int[4]) == 16 bytes, i.e. 4 ints */
    printf("%d %d\n", (int)(a[1] - a[0]), (int)(&a[2][0] - &a[0][0]));
    printf("%d %d %d\n", (int)sizeof a, (int)sizeof a[0], (int)sizeof a[0][0]);

    for (i = 0; i < 2; i = i + 1) {
        for (j = 0; j < 3; j = j + 1) printf("%d ", b[i][j]);
    }
    printf("\n");
    for (i = 0; i < 2; i = i + 1) {
        for (j = 0; j < 3; j = j + 1) printf("%d ", c[i][j]);
    }
    printf("\n");

    for (i = 0; i < 3; i = i + 1) printf("%d ", rowsum(a, i));
    printf("\n");

    /* globals, and three dimensions */
    for (i = 0; i < 3; i = i + 1)
        for (j = 0; j < 4; j = j + 1)
            grid[i][j] = (i + 1) * (j + 1);
    printf("%d %d\n", grid[2][3], rowsum(grid, 1));

    for (i = 0; i < 2; i = i + 1)
        for (j = 0; j < 2; j = j + 1)
            for (k = 0; k < 3; k = k + 1)
                cube[i][j][k] = i * 100 + j * 10 + k;
    printf("%d %d %d\n", cube[0][0][0], cube[1][0][2], cube[1][1][2]);
    printf("%d\n", (int)sizeof cube);
    return 0;
}
