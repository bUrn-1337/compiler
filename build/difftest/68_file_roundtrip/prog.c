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
/* 68 -- files written and read back: every byte value through
   fputc/fgetc (0 and 255 included, EOF after the last), lines longer than
   the runtime's 512-byte buffer, fgets with a small size, fprintf then
   fscanf of mixed ints/doubles/words, two files open at once, append,
   rewind, feof only after a read hits the end, "w+" and "r+", remove()
   and the return values of everything. */
int main(void) {
    FILE *f;
    FILE *g;
    char line[700];
    char word[32];
    int i, c, n, sum, bad, x, y, lines, longest;
    double d, e;
    f = fopen("bytes.bin", "w");
    for (i = 0; i < 256; i++) fputc(i, f);
    fputc(-1, f);                       /* written as 255 */
    printf("fclose=%d\n", fclose(f));
    f = fopen("bytes.bin", "r");
    n = 0; bad = 0; sum = 0;
    while ((c = fgetc(f)) != -1  /* EOF */) {
        if (n < 256 && c != n) bad++;
        sum = sum + c;
        n++;
    }
    printf("bytes: n=%d bad=%d sum=%d last=%d feof=%d again=%d\n", n, bad, sum, c, feof(f) != 0, fgetc(f));
    fclose(f);

    f = fopen("long.txt", "w");
    for (i = 0; i < 600; i++) fputc('a' + i % 26, f);
    fputc('\n', f);
    fputs("short line\n", f);
    fputs("no newline at end", f);
    fclose(f);
    f = fopen("long.txt", "r");
    lines = 0; longest = 0;
    while (fgets(line, 700, f) != 0) {
        lines++;
        if (strlen(line) > longest) longest = strlen(line);
        printf("line %d: len %d starts \"%.5s\" ends %d\n", lines, strlen(line), line, line[strlen(line) - 1]);
    }
    printf("lines=%d longest=%d feof=%d\n", lines, longest, feof(f) != 0);
    rewind(f);
    printf("after rewind feof=%d\n", feof(f) != 0);
    n = 0;
    while (fgets(line, 8, f) != 0) n++;
    printf("fgets(8) pieces=%d\n", n);
    fclose(f);

    f = fopen("data.txt", "w");
    g = fopen("copy.txt", "w");
    for (i = 1; i <= 5; i++) {
        fprintf(f, "%d %.3f item%d\n", i * i - 7, i / 4.0, i);
        fprintf(g, "<%d>", i);
    }
    fclose(f);
    fclose(g);
    f = fopen("data.txt", "r");
    sum = 0; e = 0.0;
    while ((n = fscanf(f, "%d %lf %s", &x, &d, word)) == 3) {
        sum = sum + x;
        e = e + d;
        printf("read %d %.3f %s\n", x, d, word);
    }
    printf("fscanf end n=%d sum=%d total=%.3f feof=%d\n", n, sum, e, feof(f) != 0);
    fclose(f);
    g = fopen("copy.txt", "a");
    fputs("<appended>\n", g);
    fclose(g);
    g = fopen("copy.txt", "r");
    printf("copy: %s", fgets(line, 700, g));
    printf("then: %d\n", fgets(line, 700, g) == 0);
    fclose(g);

    f = fopen("rw.txt", "w+");
    fputs("12 34\n", f);
    rewind(f);
    n = fscanf(f, "%d %d", &x, &y);
    printf("w+: n=%d x=%d y=%d\n", n, x, y);
    fclose(f);
    f = fopen("rw.txt", "r+");
    c = fgetc(f);
    printf("r+: first=%c\n", c);
    fclose(f);

    printf("missing=%d\n", fopen("no_such_file.txt", "r") == 0);
    printf("remove=%d %d %d %d %d\n", remove("bytes.bin"), remove("long.txt"),
           remove("data.txt"), remove("copy.txt"), remove("rw.txt"));
    printf("remove again=%d\n", remove("data.txt"));
    printf("gone=%d %d\n", fopen("data.txt", "r") == 0, fopen("bytes.bin", "r") == 0);
    f = fopen("data.txt", "w");
    fputs("reborn\n", f);
    fclose(f);
    f = fopen("data.txt", "r");
    printf("recreated: %s", fgets(line, 700, f));
    fclose(f);
    remove("data.txt");
    return 0;
}
