/* 16 -- goto and labels: backward jumps, forward jumps to a label defined
   later in the function, breaking out of nested loops, and a label on the
   statement that follows a loop. */
int main(void) {
    int i;
    int j;
    int n;
    int found;

    /* a backward goto makes a loop */
    i = 0;
again:
    i = i + 1;
    if (i < 5) goto again;
    printf("backward i=%d\n", i);

    /* a forward goto skips code */
    n = 0;
    goto skip;
    n = 999;                 /* never executed */
skip:
    printf("forward n=%d\n", n);

    /* goto escaping two nested loops at once */
    found = 0