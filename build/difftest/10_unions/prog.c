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
    printf("%c%c%c%c\n", v.bytes[0], v.bytes[1], v.bytes[2], v.bytes[3]);

    m.pair[0] = 10; m.pair[1] = 20;
    printf("%d %d\n", m.pair[0], m.pair[1]);
    m.c = 'Z';
    printf("%c\n", m.c);
    m.n = -5;
    printf("%d\n", m.n);

    printf("%d %d %d\n", (int)sizeof(union Value),
                         (int)sizeof(union Mix),
                         (int)sizeof(struct Tagged));

    /* a tagged union: the tag says which member is live */
    t.kind = 0;
    t.u.num = 1234;
    if (t.kind == 0) printf("num %d\n", t.u.num);

    t.kind = 1;
    t.u.text[0] = 'h'; t.u.text[1] = 'i'; t.u.text[2] = 0;
    if (t.kind == 1) printf("text %s\n", t.u.text);

    /* a pointer to a union */
    union Value *vp;
    vp = &v;
    vp->i = 321;
    printf("%d\n", v.i);
    return 0;
}
