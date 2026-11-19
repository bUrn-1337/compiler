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

int 