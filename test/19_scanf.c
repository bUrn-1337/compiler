/* 19 -- scanf and friends reading from standard input (test/input/19_scanf.in),
   plus sprintf/sscanf over in-memory buffers. */
int main(void) {
    int   a;
    int   b;
    int   n;
    char  word[32];
    char  line[64];
    char  buf[64];
    int   values[5];
    int   i;
    int   sum;
    char  ch;

    n = scanf("%d", &a);
    printf("n=%d a=%d\n", n, a);

    n = scanf("%d %d", &a, &b);
    printf("n=%d %d %d %d\n", n, a, b, a * b);

    n = scanf("%s", word);
    printf("n=%d word=[%s] len=%d\n", n, word, (int)strlen(word));

    n = scanf("%c", &ch);              /* the newline left by %s */
    printf("n=%d ws=%d\n", n, ch == '\n');

    n = scanf("%c", &ch);
    printf("n=%d ch=%c\n", n, ch);

    /* read a counted list of integers */
    scanf("%d", &n);
    sum = 0;
    for (i = 0; i < n; i = i + 1) { scanf("%d", &values[i]); sum = sum + values[i]; }
    printf("count=%d sum=%d\n", n, sum);
    for (i = 0; i < n; i = i + 1) printf("%d ", values[i]);
    printf("\n");

    /* read until scanf stops matching */
    n = 0;
    sum = 0;
    while (scanf("%d", &a) == 1) { n = n + 1; sum = sum + a; }
    printf("tail n=%d sum=%d\n", n, sum);

    /* sprintf into a buffer, then parse it straight back out */
    sprintf(buf, "%d:%s:%d", 42, "mid", -7);
    printf("buf=[%s]\n", buf);
    sscanf(buf, "%d", &a);
    printf("a=%d\n", a);
    sscanf("111 222", "%d %d", &a, &b);
    printf("%d %d\n", a, b);
    sscanf("token rest", "%s", word);
    printf("[%s]\n", word);

    sprintf(line, "%s/%c/%d", "x", 'y', 3);
    printf("[%s] %d\n", line, (int)strlen(line));
    return 0;
}
