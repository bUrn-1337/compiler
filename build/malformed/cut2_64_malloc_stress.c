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
      