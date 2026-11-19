/* 23 -- a realistic mixed program: word statistics over a block of text.
   char arrays, multi-level pointers, a union, a typedef'd struct, switch and
   do-while all in one place. */
typedef struct {
    char  word[16];
    int   count;
} Entry;

union Value {
    int  i;
    char bytes[4];
};

int myStrlen(char *s) {
    int n;
    n = 0;
    while (*s != 0) { n = n + 1; s = s + 1; }
    return n;
}

void toUpper(char *s) {
    while (*s != 0) {
        if (*s >= 'a' && *s <= 'z') *s = *s - 'a' + 'A';
        s = s + 1;
    }
}

int isLetter(char c) { return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z'); }

/* split text into words, writing each into table[]; returns the word count */
int tokenize(char *text, Entry *table, int max) {
    int   n;
    int   k;
    char *p;
    n = 0;
    p = text;
    while (*p != 0 && n < max) {
        while (*p != 0 && !isLetter(*p)) p = p + 1;
        if (*p == 0) break;
        k = 0;
        while (isLetter(*p) && k < 15) { table[n].word[k] = *p; k = k + 1; p = p + 1; }
        table[n].word[k] = 0;
        table[n].count = k;
        n = n + 1;
    }
    return n;
}

int findWord(Entry *table, int n, char *w) {
    int i;
    for (i = 0; i < n; i = i + 1) if (strcmp(table[i].word, w) == 0) return