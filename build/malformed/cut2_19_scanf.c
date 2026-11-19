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
    for (i 