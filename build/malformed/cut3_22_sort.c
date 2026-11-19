/* 22 -- a realistic mixed program: four sorts over the same data, a binary
   search, and a struct-based histogram.  Arrays, functions, pointers, goto. */
struct Stats { int comparisons; int swaps; };

void copyInto(int *dst, int *src, int n) {
    int i;
    for (i = 0; i < n; i = i + 1) dst[i] = src[i];
}

void show(char *label, int *a, int n) {
    int i;
    printf("%-10s", label);
    for (i = 0; i < n; i = i + 1) printf("%4d", a[i]);
    printf("\n");
}

void bubble(int *a, int n, struct Stats *st) {
    int i;
    int j;
    int t;
    for (i = 0; i < n - 1; i = i + 1) {
        int swapped;
        swapped = 0;
        for (j = 0; j < n - 1 - i; j = j + 1) {
            st->comparisons = st->comparisons + 1;
            if (a[j] > a[j + 1]) {
                t = a[j]; a[j] = a[j + 1]; a[j + 1] = t;
                st->swaps = st->swaps + 1;
                swapped = 1;
            }
        }
        if (!swapped) break;
    }
}

void selection(int *a, int n) {
    int i;
    int j;
    int m;
    int t;
    for (i = 0; i < n - 1; i = i + 1) {
        m = i;
        for (j = i + 1; j < n; j = j + 1) if (a[j] < a[m]) m = j;
        if (m != i) { t = a[i]; a[i] = a[m]; a[m] = t; }
    }
}

void insertion(int *a, int n) {
    int