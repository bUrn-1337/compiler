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
int  gzarr[