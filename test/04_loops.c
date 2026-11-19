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
    printf("until sum=%d i=%d\n", sum, i);

    /* until with a condition that is already true runs zero times */
    n = 0;
    until (1) { n = n + 1; }
    printf("until-never n=%d\n", n);

    /* break and continue affect only the innermost loop */
    sum = 0;
    for (i = 0; i < 4; i = i + 1) {
        for (j = 0; j < 4; j = j + 1) {
            if (j == 2) break;
            if (i == 1) continue;
            sum = sum + i * 10 + j;
        }
        sum = sum + 1000;
    }
    printf("nested sum=%d\n", sum);

    /* a for loop with empty sections */
    i = 0;
    for (;;) { i = i + 1; if (i == 3) break; }
    printf("forever i=%d\n", i);

    /* a for loop declaring its own variable */
    sum = 0;
    for (int k = 0; k < 4; k = k + 1) sum = sum + k;
    printf("decl sum=%d\n", sum);

    /* while and until nested inside each other */
    i = 0; sum = 0;
    while (i < 3) {
        j = 0;
        until (j >= 3) { sum = sum + 1; j = j + 1; }
        i = i + 1;
    }
    printf("mix sum=%d\n", sum);
    return 0;
}
