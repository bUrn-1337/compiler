/* 02 -- short-circuit evaluation.  The right operand of && and || must not be
   evaluated when the left one already decides the result, and ?: must evaluate
   only the branch it selects. */
int calls;

int tick(int v) {
    calls = calls + 1;
    return v;
}

int main(void) {
    int r;

    calls = 0;
    r = tick(0) && tick(1);
    printf("%d calls=%d\n", r, calls);

    calls = 0;
    r = tick(1) && tick(0);
    printf("%d calls=%d\n", r, calls);

    calls = 0;
    r = tick(1) || tick(1);
    printf("%d calls=%d\n", r, calls);

    calls = 0;
    r = tick(0) || tick(7);
    printf("%d calls=%d\n", r, calls);

    calls = 0;
    r = tick(1) ? tick(10) : tick(20);
    printf("%d calls=%d\n", r, calls);

    calls = 0;
    r = tick(0) ? tick(10) : tick(20);
    printf("%d calls=%d\n", r, calls);

    /* in a condition, too */
    calls = 0;
    if (tick(0) && tick(1)) printf("yes\n"); else printf("no\n");
    printf("calls=%d\n", calls);

    /* && and || yield exactly 0 or 1 */
    printf("%d %d %d\n", 3 && 4, 3 || 4, !5);
    printf("%d\n", 1 && 0 || 1);

    /* nested, mixed */
    calls = 0;
    r = (tick(1) && tick(0)) || (tick(1) && tick(2));
    printf("%d calls=%d\n", r, calls);
    return 0;
}
