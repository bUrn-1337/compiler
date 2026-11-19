/* 14 -- command-line input: main(int argc, char *argv[]).
   argv[0] is deliberately never printed: it is the program path, which differs
   between the gcc reference build and the IR interpreter. */
int main(int argc, char *argv[]) {
    int   i;
    int   sum;
    char *p;
    char **q;

    printf("argc=%d\n", argc);

    for (i = 1; i < argc; i = i + 1) printf("[%s]", argv[i]);
    printf("\n");

    /* argv is a char **: walk it with a pointer instead of an index */
    q = argv + 1;
    while (*q != 0) { printf("%d ", (int)strlen(*q)); q = q + 1; }
    printf("\n");

    /* convert the arguments to integers and add them up */
    sum = 0;
    for (i = 1; i < argc; i = i + 1) sum = sum + atoi(argv[i]);
    printf("sum=%d\n", sum);

    /* index into an argument's characters */
    if (argc > 1) {
        p = argv[1];
        printf("first=%c last=%c\n", p[0], p[strlen(p) - 1]);
    }

    /* a flag-style argument compared with strcmp */
    for (i = 1; i < argc; i = i + 1)
        if (strcmp(argv[i], "-v") == 0) printf("verbose\n");

    return argc - 1;             /* a non-zero exit status, checked too */
}
