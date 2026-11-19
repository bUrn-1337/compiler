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
/* 64 -- heap stress: thousands of blocks of varying sizes allocated,
   written, checked and freed in interleaved order; realloc growth keeps
   the contents; calloc zeroes (also memory that was used before); a
   linked list and a growable array.  Nothing that depends on addresses is
   printed, so gcc's allocator and ours must agree. */
struct node { int v; struct node *next; };

int check_block(char *p, int n, int seed) {
    int i;
    for (i = 0; i < n; i++) if (p[i] != (char)(seed + i)) return 0;
    return 1;
}

int main(void) {
    char *blk[200];
    int sz[200];
    int i, round, ok, n, cap, len;
    int *arr;
    int *z;
    struct node *head;
    struct node *q;
    ok = 1;
    for (i = 0; i < 200; i++) blk[i] = 0;
    for (round = 0; round < 20; round++) {
        for (i = round % 3; i < 200; i = i + 3) {
            if (blk[i]) {
                if (!check_block(blk[i], sz[i], i)) ok = 0;
                free(blk[i]);
                blk[i] = 0;
            } else {
                sz[i] = (i * 37 + round * 11) % 300 + 1;
                blk[i] = malloc(sz[i]);
                for (n = 0; n < sz[i]; n++) blk[i][n] = i + n;
            }
        }
    }
    for (i = 0; i < 200; i++)
        if (blk[i]) {
            if (!check_block(blk[i], sz[i], i)) ok = 0;
            free(blk[i]);
        }
    printf("blocks ok: %d\n", ok);

    cap = 1;
    len = 0;
    arr = (int *)malloc(cap * sizeof(int));
    for (i = 0; i < 5000; i++) {
        if (len == cap) {
            cap = cap * 2;
            arr = (int *)realloc((char *)arr, cap * sizeof(int));
        }
        arr[len++] = i * i;
    }
    ok = 1;
    for (i = 0; i < len; i++) if (arr[i] != i * i) ok = 0;
    printf("realloc: len=%d cap=%d ok=%d\n", len, cap, ok);
    arr = (int *)realloc((char *)arr, 10 * sizeof(int));
    printf("shrunk: %d %d\n", arr[3], arr[9]);
    free((char *)arr);

    for (round = 0; round < 3; round++) {
        z = (int *)malloc(400);
        for (i = 0; i < 100; i++) z[i] = -1;
        free((char *)z);
        z = (int *)calloc(100, sizeof(int));
        n = 0;
        for (i = 0; i < 100; i++) n = n + z[i];
        printf("calloc sum %d\n", n);
        free((char *)z);
    }

    head = 0;
    for (i = 0; i < 1000; i++) {
        q = (struct node *)malloc(sizeof(struct node));
        q->v = i;
        q->next = head;
        head = q;
    }
    n = 0;
    for (q = head; q; q = q->next) n = n + q->v;
    printf("list sum %d\n", n);
    while (head) {
        q = head->next;
        free((char *)head);
        head = q;
    }
    free(0);
    printf("malloc(0) usable: %d\n", malloc(0) != 0);
    return 0;
}
