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
    r = tick(1) &&