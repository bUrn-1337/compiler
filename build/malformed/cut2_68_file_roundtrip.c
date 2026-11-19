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
    while