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
    