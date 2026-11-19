/* 17 -- string literals (with escapes already converted to bytes), char
   arithmetic and promotion, truncation on store, and the string library. */
char *greeting = "hello";
char  tabbed[] = "a\tb\nc";

int main(void) {
    char  buf[32];
    char  small[4];
    char  c;
    int   i;
    int   n;
    char *p;

    printf("%s %s\n", greeting, "literal");
    printf("[%s]\n", tabbed);
    printf("escapes: a\tb\\c\"d\'e\n");
    printf("%d %d %d %d\n", '\n', '\t', '\\', '\0');
    printf("%d %d\n", 'A', 'a' - 'A');

    /* char promotes to int in arithmetic */
    c = 'A';
    printf("%d %c %c\n", c + 1, c + 1, c);
    i = c * 2;
    printf("%d\n", i);

    /* storing into a char truncates to 8 bits and sign-extends on read */
    c = 200;                 /* 200 does not fit a signed char */
    printf("%d\n", c);
    c = 'a' + 256;
    printf("%d %c\n", c, c);
    c = -1;
    printf("%d\n", c);
    small[0] = 300;
    printf("%d\n", small[0]);

    /* the string library */
    strcpy(buf, "abc");
    printf("%s %d\n", buf, (int)strlen(buf));
    strcat(buf, "def");