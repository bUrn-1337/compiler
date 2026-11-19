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
   