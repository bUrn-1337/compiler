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
    for (i = 0; i < n; i = i + 1) if (strcmp(table[i].word, w) == 0) return i;
    return -1;
}

void reverseInPlace(char *s) {
    int  n;
    int  i;
    char t;
    n = myStrlen(s);
    for (i = 0; i < n / 2; i = i + 1) { t = s[i]; s[i] = s[n - 1 - i]; s[n - 1 - i] = t; }
}

int classify(char c) {
    switch (c) {
        case 'a':
        case 'e':
        case 'i':
        case 'o':
        case 'u':
            return 1;               /* vowel */
        case ' ':
        case '\t':
            return 2;               /* space */
        default:
            if (c >= '0' && c <= '9') return 3;
            return 0;
    }
}

int main(void) {
    char   text[80];
    Entry  table[16];
    int    n;
    int    i;
    int    vowels;
    int    spaces;
    int    digits;
    int    longest;
    char   buf[32];
    char  *p;
    char **pp;
    union Value v;

    strcpy(text, "the quick brown fox jumps over 2 lazy dogs");
    printf("text=[%s] len=%d\n", text, myStrlen(text));

    n = tokenize(text, table, 16);
    printf("words=%d\n", n);
    longest = 0;
    for (i = 0; i < n; i = i + 1) {
        printf("%d:%s(%d) ", i, table[i].word, table[i].count);
        if (table[i].count > table[longest].count) longest = i;
    }
    printf("\nlongest=%s\n", table[longest].word);

    printf("fox at %d, cat at %d\n", findWord(table, n, "fox"), findWord(table, n, "cat"));

    /* character classes, counted with a do-while */
    vowels = 0; spaces = 0; digits = 0;
    i = 0;
    do {
        int cls;
        cls = classify(text[i]);
        if (cls == 1) vowels = vowels + 1;
        else if (cls == 2) spaces = spaces + 1;
        else if (cls == 3) digits = digits + 1;
        i = i + 1;
    } while (text[i] != 0);
    printf("vowels=%d spaces=%d digits=%d\n", vowels, spaces, digits);

    /* reverse a copy, and upper-case another */
    strcpy(buf, table[1].word);
    reverseInPlace(buf);
    printf("reversed=%s\n", buf);
    strcpy(buf, table[2].word);
    toUpper(buf);
    printf("upper=%s\n", buf);

    /* a char ** walking an array of pointers into the table */
    {
        char *words[3];
        words[0] = table[0].word;
        words[1] = table[1].word;
        words[2] = table[2].word;
        pp = words;
        for (i = 0; i < 3; i = i + 1) printf("[%s]", *(pp + i));
        printf("\n");
        p = *(pp + 1);
        printf("%c%c\n", p[0], *(p + 1));
    }

    /* a union viewing an int as four bytes (only the byte we wrote is read) */
    v.i = 0;
    v.bytes[0] = 'A';
    printf("byte0=%c i-nonzero=%d\n", v.bytes[0], v.i != 0);
    return 0;
}
