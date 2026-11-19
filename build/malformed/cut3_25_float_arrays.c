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

int main