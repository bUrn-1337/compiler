/* 10 -- unions.  Every member starts at offset 0 and the union is as large as
   its largest member.  Only the most recently stored member is read back, so
   this test never reads a member it did not write (that would be unspecified). */
union Value {
    int  i;
    char bytes[4];
};

union Mix {
    int          n;
    char         c;
    int          pair[2];
};

struct Tagged {
    int          kind;      /* 0 = integer, 1 = text */
    union {
        int  num;
        char text[8];
    } u;
};

int main(void) {
    union Value v;
    union Mix m;
    struct Tagged t;
    int i;

    v.i = 7;
    printf("%d\n", v.i);

    /* write through one member, read back the same one */
    for (i = 0; i < 4; i = i + 1) v.bytes[i] = 'a' + i;
    printf("%c%c%c%c