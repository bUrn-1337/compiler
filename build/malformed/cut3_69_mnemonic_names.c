/* 69 -- user identifiers spelled like MIPS mnemonics, registers, assembler
   directives and runtime symbols, as globals, functions, parameters,
   locals, struct members and goto labels.  The compiler prefixes every
   user symbol (fn_, gv_) and uses numbered local labels, so none of these
   can collide with an instruction, a register or the runtime. */
int add, sub, li, la, lw, sw, j, jal, b, beq, nop, syscall;
double f0, f12;
char data[8], text[8], asciiz[8];
int globl = 7, word = 3, space = 1, align = 2;
int zero = 100, at = 5, sp = 6, ra = 9, fp = 11, gp = 12, k0 = 13;

struct reg { int t0; int v0; double s0; char a0; };

int move(int t0, int t1) { return t0 - t1; }
int divu(int v0, int v1) { return v0 / v1 + v0 % v1; }
int mul(int lo, int hi) { return lo * hi; }
int j