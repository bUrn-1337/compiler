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
/* 65 -- long switch statements: 40 dense cases, sparse and negative case
   values, fall-through chains, default in the middle, nested switches,
   break/continue inside switches inside loops, and a char switch. */
int dense(int x) {
    switch (x) {
    case 0: return 100; case 1: return 101; case 2: return 104; case 3: return 109;
    case 4: return 116; case 5: return 125; case 6: return 136; case 7: return 149;
    case 8: return 164; case 9: return 181; case 10: return 200; case 11: return 221;
    case 12: return 244; case 13: return 269; case 14: return 296; case 15: return 325;
    case 16: return 356; case 17: return 389; case 18: return 424; case 19: return 461;
    case 20: return 500; case 21: return 541; case 22: return 584; case 23: return 629;
    case 24: return 676; case 25: return 725; case 26: return 776; case 27: return 829;
    case 28: return 884; case 29: return 941; case 30: return 1000; case 31: return 1061;
    case 32: return 1124; case 33: return 1189; case 34: return 1256; case 35: return 1325;
    case 36: return 1396; case 37: return 1469; case 38: return 1544; case 39: return 1621;
    }
    return -1;
}

int sparse(int x) {
    int r;
    r = 0;
    switch (x) {
    case -1000000: r = 1; break;
    case -5: r = 2;
    case -4: r = r + 3;
    case 0: r = r + 4; break;
    default: r = 99;
    case 7: r = r + 5; break;
    case 1 << 20: r = 6; break;
    case 2147483647: r = 7; break;
    case -2147483647 - 1: r = 8; break;
    }
    return r;
}

char *kind(char c) {
    switch (c) {
    case 'a': case 'e': case 'i': case 'o': case 'u': return "vowel";
    case ' ': case '\t': case '\n': return "space";
    case '0': case '1': case '2': case '3': case '4':
    case '5': case '6': case '7': case '8': case '9': return "digit";
    default:
        if (c >= 'a' && c <= 'z') return "consonant";
        return "other";
    }
}

int main(void) {
    int i, j, t;
    char *s;
    t = 0;
    for (i = -2; i < 42; i++) t = t + dense(i);
    printf("dense total %d, dense(17)=%d\n", t, dense(17));
    printf("sparse: %d %d %d %d %d %d %d %d %d\n", sparse(-1000000), sparse(-5), sparse(-4),
           sparse(0), sparse(7), sparse(1 << 20), sparse(2147483647), sparse(-2147483647 - 1), sparse(3));
    for (s = "hi 42, you!"; *s; s++) printf("%c:%s ", *s, kind(*s));
    printf("\n");
    for (i = 0; i < 4; i++) {
        for (j = 0; j < 4; j++) {
            switch (i) {
            case 0: continue;
            case 1:
                switch (j) { case 1: printf("[1,1]"); break; default: printf("."); }
                break;
            case 2:
                if (j == 2) break;
                printf("(%d)", j);
                continue;
            default:
                printf("<%d%d>", i, j);
            }
            printf("|");
        }
        printf("\n");
    }
    return dense(39) % 256;
}
