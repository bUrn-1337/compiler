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
    int i;
    int j;
    int key;
    for (i = 1; i < n; i = i + 1) {
        key = a[i];
        j = i - 1;
        while (j >= 0 && a[j] > key) { a[j + 1] = a[j]; j = j - 1; }
        a[j + 1] = key;
    }
}

void quick(int *a, int lo, int hi) {           /* recursive */
    int i;
    int j;
    int pivot;
    int t;
    if (lo >= hi) return;
    pivot = a[hi];
    i = lo;
    for (j = lo; j < hi; j = j + 1)
        if (a[j] < pivot) { t = a[i]; a[i] = a[j]; a[j] = t; i = i + 1; }
    t = a[i]; a[i] = a[hi]; a[hi] = t;
    quick(a, lo, i - 1);
    quick(a, i + 1, hi);
}

int bsearch_(int *a, int n, int key) {
    int lo;
    int hi;
    int mid;
    lo = 0;
    hi = n - 1;
    while (lo <= hi) {
        mid = (lo + hi) / 2;
        if (a[mid] == key) return mid;
        if (a[mid] < key) lo = mid + 1; else hi = mid - 1;
    }
    return -1;
}

int isSorted(int *a, int n) {
    int i;
    for (i = 1; i < n; i = i + 1) if (a[i - 1] > a[i]) return 0;
    return 1;
}

int main(void) {
    int data[10];
    int work[10];
    int i;
    int n;
    int buckets[4];
    struct Stats st;

    data[0] = 42; data[1] = 7;  data[2] = 19; data[3] = 7;  data[4] = -3;
    data[5] = 88; data[6] = 0;  data[7] = 23; data[8] = 61; data[9] = 12;
    n = 10;

    show("input:", data, n);

    st.comparisons = 0;
    st.swaps = 0;
    copyInto(work, data, n);
    bubble(work, n, &st);
    show("bubble:", work, n);
    printf("comparisons=%d swaps=%d sorted=%d\n", st.comparisons, st.swaps, isSorted(work, n));

    copyInto(work, data, n);
    selection(work, n);
    show("selection:", work, n);

    copyInto(work, data, n);
    insertion(work, n);
    show("insertion:", work, n);

    copyInto(work, data, n);
    quick(work, 0, n - 1);
    show("quick:", work, n);
    printf("all agree=%d\n", isSorted(work, n));

    /* binary search over the sorted copy */
    printf("find 23 -> %d\n", bsearch_(work, n, 23));
    printf("find -3 -> %d\n", bsearch_(work, n, -3));
    printf("find 88 -> %d\n", bsearch_(work, n, 88));
    printf("find 99 -> %d\n", bsearch_(work, n, 99));

    /* a histogram, with a goto to skip the out-of-range values */
    for (i = 0; i < 4; i = i + 1) buckets[i] = 0;
    for (i = 0; i < n; i = i + 1) {
        int v;
        v = data[i];
        if (v < 0) goto next;
        if (v >= 100) goto next;
        buckets[v / 25] = buckets[v / 25] + 1;
    next:
        ;
    }
    for (i = 0; i < 4; i = i + 1) printf("%d-%d: %d\n", i * 25, i * 25 + 24, buckets[i]);
    return 0;
}
