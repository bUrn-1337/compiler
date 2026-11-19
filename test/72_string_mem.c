/* 72 -- the string and memory builtins: strlen, strcpy, strncpy (NUL
   padding, and no terminator when the source is too long), strcat,
   strcmp/strncmp (only the sign is portable; bytes compare as unsigned
   char), strchr (including the terminator), memset, memcpy, abs, atoi,
   puts/putchar, and sprintf building strings piece by piece. */
int sign(int v) { return (v > 0) - (v < 0); }

void dump(char *p, int n) {
    int i;
    for (i = 0; i < n; i++) {
        if (p[i] >= 32 && p[i] < 127) putchar(p[i]);
        else printf("\\%d", p[i] & 255);
    }
    putchar('\n');
}

int main(void) {
    char a[32];
    char b[32];
    char big[200];
    char *p;
    int i, n, arr[8], cp[8];
    printf("%d %d %d\n", strlen(""), strlen("hello"), strlen("tab\there"));
    p = strcpy(a, "copy me");
    printf("%s %d\n", a, p == a);
    memset(b, 'X', 32);
    strncpy(b, "ab", 6);
    dump(b, 8);
    memset(b, 'X', 32);
    strncpy(b, "abcdefgh", 4);
    dump(b, 8);
    strcpy(a, "con");
    p = strcat(a, "cat");
    strcat(a, "");
    strcat(a, "enate");
    printf("%s %d %d\n", a, strlen(a), p == a);
    printf("cmp %d %d %d %d %d %d\n", sign(strcmp("abc", "abd")), sign(strcmp("abd", "abc")),
           sign(strcmp("abc", "abc")), sign(strcmp("ab", "abc")), sign(strcmp("", "a")),
           sign(strcmp("\377", "a")));
    printf("ncmp %d %d %d %d\n", sign(strncmp("abcX", "abcY", 3)), sign(strncmp("abcX", "abcY", 4)),
           sign(strncmp("a", "b", 0)), sign(strncmp("abc", "ab", 5)));
    p = "hello, world";
    printf("chr %d %d %d %d\n", strchr(p, 'o') - p, strchr(p, 'w') - p, strchr(p, 'z') == 0,
           strchr(p, 0) - p);
    for (i = 0; i < 8; i++) arr[i] = i * i;
    memcpy(cp, arr, sizeof(arr));
    memset(arr, 0, 4 * sizeof(int));
    memset(arr + 4, 255, sizeof(int));
    printf("mem");
    for (i = 0; i < 8; i++) printf(" %d/%d", arr[i], cp[i]);
    printf("\n");
    memcpy(big, "0123456789", 11);
    memcpy(big + 5, big, 4);
    printf("%s\n", big);
    printf("abs %d %d %d\n", abs(-5), abs(5), abs(0));
    printf("atoi %d %d %d %d\n", atoi("42"), atoi("  -17xyz"), atoi("+8"), atoi(""));
    n = 0;
    big[0] = 0;
    for (i = 0; i < 10; i++) n += sprintf(big + n, "%d,", i * 7);
    printf("%s len=%d n=%d\n", big, strlen(big), n);
    puts("puts adds a newline");
    puts("");
    putchar('o'); putchar('k'); putchar('\n');
    p = big;
    for (i = 0; i < 20; i++) *p++ = 'a' + i;
    *p = 0;
    printf("%s %d\n", big, strlen(big + 5));
    return strlen(a);
}
