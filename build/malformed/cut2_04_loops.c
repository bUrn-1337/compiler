/* 04 -- for, while, do-while and until, with nested break and continue.
   `until (c) S` is a PRE-CHECK loop: it is equivalent to while (!(c)) S. */
int main(void) {
    int i;
    int j;
    int n;
    int sum;

    sum = 0;
    for (i = 0; i < 10; i = i + 1) {
        if (i == 3) continue;        /* continue targets the increment */
        if (i == 7) break;
        sum = sum + i;
    }
    printf("for sum=%d i=%d\n", sum, i);

    i = 0; sum = 0;
    while (i < 10) {
        i = i + 1;
        if (i % 2 == 0) continue;    /* continue targets the condition */
        if (i > 7) break;
        sum = sum + i;
    }
    printf("while sum=%d i=%d\n", sum, i);

    i = 0; sum = 0;
    do {
        i = i + 1;
        if (i == 2) continue;        /* continue targets the bottom test */
        sum = sum + i;
    } while (i < 5);
    printf("do sum=%d i=%d\n", sum, i);

    i = 0; sum = 0;
    until (i >= 5) {                 /* pre-check: runs while i < 5 */
        sum = sum + i;
        i = i + 1;
    }
    print