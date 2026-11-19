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
    until (0) { i++; if (i == 3) break; }
    printf("until break i=%d\n", i);

    /* nested loops with continue and break */
    total = 0;
    for (i = 0; i < 4; i++) {
        for (j = 0; j < 4; j++) {
            if (j == 2) continue;
            if (j == 3) break;
            total += i * 10 + j;
        }
    }
    printf("nested total=%d\n", total);

    /* continue in a while and in a do-while */
    i = 0; total = 0;
    while (i < 6) { i++; if (i % 2) continue; total += i; }
    printf("even total=%d\n", total);
    i = 0; total = 0;
    do { i++; if (i % 2) continue; total += i; } while (i < 6);
    printf("do even total=%d\n", total);

    /* a goto that leaves two loops at once */
    found = -1;
    for (i = 0; i < 5; i++)
        for (j = 0; j < 5; j++)
            if (arr[i] + arr[j] == 31) { found = i * 10 + j; goto out; }
out:
    printf("found=%d\n", found);

    /* a loop whose body is a declaration-free block, and a backward goto */
    k = 0;
again:
    k++;
    if (k < 3) goto again;
    printf("k=%d\n", k);

    /* a loop that never runs */
    total = 0;
    for (i = 5; i < 5; i++) total = 999;
    while (0) total = 999;
    printf("never total=%d\n", total);

    /* a loop variable declared in the enclosing block and reused after */
    for (i = 0; i < 5; i++) { int doubled = arr[i] * 2; total += doubled; }
    printf("total=%d i=%d\n", total, i);
    return 0;
}
