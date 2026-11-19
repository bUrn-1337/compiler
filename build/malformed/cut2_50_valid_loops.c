/* 50 -- loop forms: an empty for, missing for clauses, comma expressions in a
   for, do-while, the `until' extension, nested loops with break and continue,
   a goto that leaves two loops at once, and loops whose body is a single
   statement or empty. */
int main(void) {
    int i, j, k;
    int total;
    int arr[5];
    int found;

    arr[0] = 4; arr[1] = 8; arr[2] = 15; arr[3] = 16; arr[4] = 23;

    /* a for with an empty body, and one with no initializer */
    for (i = 0; i < 5; i++) ;
    printf("i=%d\n", i);
    i = 0;
    for (; i < 3; ) i++;
    printf("i=%d\n", i);

    /* a for with no condition, left by break */
    total = 0;
    for (i = 0; ; i++) {
        total += i;
        if (i == 4) break;
    }
    printf("total=%d i=%d\n", total, i);

    /* comma expressions in both the initializer and the step */
    for (i = 0, j = 10, total = 0; i < j; i++, j--) total += i + j;
    printf("i=%d j=%d total=%d\n", i, j, total);

    /* do-while runs its body at least once */
    i = 100;
    do { i++; } while (i < 5);
    printf("do i=%d\n", i);
    i = 0;
    do { i += 2; } while (i < 7);
    printf("do i=%d\n", i);

    /* while and the `until' extension (until(c) is while(!c)) */
    i = 0;
    while (i < 4) i++;
    printf("while i=%d\n", i);
    i = 0;
    until (i >= 4) i++;
    printf("until i=%d\n", i);
    i = 0;
    until (0) { i++; if (i =