/* test/prelude.h -- prepended to each test program ONLY when it is compiled by
 * gcc as the reference implementation (see verify.sh).  The generator itself
 * never sees this file: the source language has no preprocessor, so printf,
 * malloc, fopen and friends are built into the compiler, and `until` is a
 * language extension rather than a macro.
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define until(c) while (!(c))
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
    printf("%s %d\n", buf, (int)strlen(buf));
    printf("%d %d %d\n", strcmp("abc", "abc"), strcmp("abc", "abd") < 0,
                         strcmp("abd", "abc") > 0);
    printf("%d %d\n", strncmp("abcdef", "abcxyz", 3), strncmp("abc", "abd", 3) < 0);

    strncpy(small, "xy", 4);
    printf("%s\n", small);

    p = strchr("hello world", 'w');
    printf("%s\n", p);
    printf("%d\n", strchr("abc", 'z') == 0);

    memset(buf, '-', 5);
    buf[5] = 0;
    printf("%s\n", buf);

    strcpy(buf, "source");
    memcpy(buf + 7, "copy", 5);
    printf("%s %s\n", buf, buf + 7);

    /* walking a string by hand */
    n = 0;
    p = greeting;
    while (*p != 0) { n = n + *p; p = p + 1; }
    printf("checksum=%d\n", n);

    /* reverse a string in place */
    strcpy(buf, "stressed");
    n = (int)strlen(buf);
    for (i = 0; i < n / 2; i = i + 1) {
        c = buf[i];
        buf[i] = buf[n - 1 - i];
        buf[n - 1 - i] = c;
    }
    printf("%s\n", buf);

    /* a string literal is indexable */
    printf("%c%c%c\n", "xyz"[0], "xyz"[1], "xyz"[2]);
    return 0;
}
