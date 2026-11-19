/* 73 -- every escape sequence in string and character literals (simple,
   octal and hex; \0 inside a string; \377 as a negative char), strings
   holding text that means something to the assembler (quotes, '#', ':',
   directives, register names), a string longer than 255 bytes, and global
   data: negative and constant-expression initialisers, char 200, doubles,
   zeroed arrays, and pointers into arrays and structs (&a[i][j], &s.m[k],
   a bare array name -- Stage 3 silently stored 0 for all but &g). */
char esc[] = "\a\b\f\n\r\t\v\\\'\"\?";
char oct[] = "\101\102\103\0\60\7\177\377";
char hex[] = "\x41\x7a\x30\x0\xff\x7F";
char asmy[] = "# not a comment: .asciiz \"x\" $t0 main: syscall";
char *pmsg = "pointer to a literal";
char *pmid;
int gneg = -42;
int gexpr = (3 * 4 + 1) << 2;
int gmix = 'A' + 1;
int gneg_hex = -0x10;
int goct = 017;
char gc = 200;
char gq = '\'';
char gzero[100];
int  gzarr[50];
double gdn = -2.5e-3;
double gdi = 7;
double gdarr[3] = {-0.0, 1e100, 3};
int garr[4] = {1, -2, 3, -4};
int *gpa = garr;
int *gpb = &garr[2];
struct rec { int k; char tag[4]; int v[3]; } grec = {5, "abc", {6, 7, 8}};
int gm[2][3] = {{1, 2, 3}, {4, 5, 6}};
int *gpm = &gm[1][1];
char *gpt = &grec.tag[1];
int *gpv = grec.v;
char *gpstr = asmy;

void show(char *name, char *s, int n) {
    int i;
    printf("%s:", name);
    for (i = 0; i < n; i++) printf(" %d", s[i]);
    printf("\n");
}

int main(void) {
    char longs[] = "0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789";
    int i, sum;
    show("esc", esc, sizeof(esc));
    show("oct", oct, sizeof(oct));
    show("hex", hex, sizeof(hex));
    printf("%d %d %d %d %d %d %d\n", '\n', '\0', '\\', '\x41', '\101', '\377', '\'');
    printf("%s|%d\n", asmy, sizeof(asmy));
    printf("%s|%s|%s\n", "tab\there", "quote\"in", "back\\slash");
    printf("100%% sure, \"%s\"\n", "yes");
    printf("%d %d\n", strlen(oct), sizeof("ab\0cd"));
    pmid = pmsg + 8;
    printf("%s / %s / %c\n", pmsg, pmid, *(pmsg + 3));
    printf("%d %d %d %d %d %d %d\n", gneg, gexpr, gmix, gneg_hex, goct, gc, gq);
    sum = 0;
    for (i = 0; i < 100; i++) sum += gzero[i];
    for (i = 0; i < 50; i++) sum += gzarr[i];
    printf("zero sum %d\n", sum);
    printf("%g %g %g %g %g\n", gdn, gdi, gdarr[0], gdarr[1], gdarr[2]);
    printf("%d %d %d %d\n", gpa[1], *(gpa + 3), gpa[0] + garr[2], *gpb);
    printf("%d %s %d %.9s\n", *gpm, gpt, gpv[2], gpstr + 2);
    printf("long %d %c %c\n", strlen(longs), longs[255], longs[279]);
    return sizeof(esc);
}
