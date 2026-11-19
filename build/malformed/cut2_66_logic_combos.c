/* 66 -- && and || nested in every combination, as conditions and as
   values, with side effects that show exactly which operands were
   evaluated (short-circuit order).  This found a Stage 3 bug: in
   `(a || b) && c` a true `a` skipped `c`, and in `(a && b) || c` a false
   `a` skipped `c` (see README, "Stage 3 bugs fixed"). */
int trace;

int t(int id, int v) {
    trace = trace * 10 + id;
    return v;
}

int main(void) {
    int a, b, c, d, r, n;
    char ch;
    char *s;
    n = 0;
    for (a = 0; a < 2; a++)
        for (b = 0; b < 2; b++)
            for (c = 0; c < 2; c++)
                for (d = 0; d < 2; d++) {
                    printf("%d%d%d%d:", a, b, c, d);
                    trace = 0; r = (t(1, a) || t(2, b)) && t(3, c);
                    printf(" %d/%d", r, trace);
                    trace = 0; r = (t(1, a) && t(2, b)) || t(3, c);
                    printf(" %d/%d", r, trace);
                    trace = 0; r = (t(1, a) || t(2, b)) && (t(3, c) || t(4, d));
                    printf(" %d/%d", r, trace);
                    trace = 0; r = (t(1, a) && t(2, b)) || (t(3, c) && t(4, d));
                    printf(" %d/%d", r, trace);
          