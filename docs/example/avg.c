/* average of the positive entries of an array */
double avg(int *a, int n) {
    int i, k;
    double s;
    s = 0.0;
    k = 0;
    for (i = 0; i < n; i++)
        if (a[i] > 0) { s = s + a[i]; k++; }
    return k ? s / k : 0.0;
}

int main(void) {
    int v[5] = {4, -2, 7, 0, 10};
    printf("%.3f\n", avg(v, 5));
    return 0;
}
