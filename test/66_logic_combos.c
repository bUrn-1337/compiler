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
                    trace = 0; r = !(t(1, a) || t(2, b)) && !t(3, c);
                    printf(" %d/%d", r, trace);
                    trace = 0; r = ((t(1, a) || t(2, b)) && t(3, c)) || t(4, d);
                    printf(" %d/%d", r, trace);
                    trace = 0;
                    if ((t(1, a) || t(2, b)) && (t(3, c) || !t(4, d))) n++;
                    printf(" if/%d", trace);
                    trace = 0;
                    while ((t(1, a) && t(2, b)) || t(3, c)) { if (++n > 1000 || 1) break; }
                    printf(" while/%d", trace);
                    trace = 0;
                    r = (t(1, a) || t(2, b)) ? t(3, c) : t(4, d);
                    printf(" ?/%d/%d\n", r, trace);
                }
    printf("n = %d\n", n);
    for (s = "aZm09_ Q"; *s; s++) {
        ch = *s;
        printf("%c:%d%d ", ch, (ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z'),
               (ch >= '0' && ch <= '9') || ch == '_');
    }
    printf("\n");
    a = 0; b = 5;
    if ((a || b) && b > 3) printf("ok1\n");
    if (!((a && b) || !b)) printf("ok2\n");
    if ((1 || a) && (0 || b)) printf("ok3\n");
    if ((0 && a) || (1 && b)) printf("ok4\n");
    return 0;
}
