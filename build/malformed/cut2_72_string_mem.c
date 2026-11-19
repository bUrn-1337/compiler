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
           sign(strcmp("abc", "abc")), sign(strcmp("