/* 15 -- file manipulation: fopen/fclose, fprintf/fscanf, fputs/fgets,
   fputc/fgetc, feof, rewind and remove.  FILE is an opaque pointer type. */
int main(void) {
    FILE *f;
    char  line[64];
    int   a;
    int   b;
    int   n;
    int   c;
    int   total;

    /* write with fprintf */
    f = fopen("t15.txt", "w");
    if (f == 0) { printf("cannot write\n"); return 1; }
    fprintf(f, "%d %d\n", 10, 32);
    fprintf(f, "%s\n", "second line");
    fputs("third line\n", f);
    fputc('x', f);
    fputc('\n', f);
    fclose(f);

    /* read the numbers back with fscanf */
    f = fopen("t15.txt", "r");
    if (f == 0) { printf("cannot read\n"); return 1; }
    n = fscanf(f, "%d %d", &a, &b);
    printf("fscanf n=%d a=%d b=%d sum=%d\n", n, a, b, a + b);

    /* then the remaining lines with fgets */
    fgets(line, 64, f);                 /* the rest of the first line */
    fgets(line, 64, f);
    printf("line2=[%s]", line);
    fgets(line, 64, f);
    printf("line3=[%s]", line);
    fclose(f);

    /* read the whole file one character at a time, counting the newlines */
    f = fopen("t15.txt", "r");
    total = 0;
    n = 0;
    c = fgetc(f);
    while (c !=