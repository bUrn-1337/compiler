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
int jr(int ra) { return ra + 1; }
int __rt_printf(int x) { return x * 2; }      /* a runtime name */
int fn_main(int x) { return x + 1000; }       /* the prefix itself */
int gv_add(int x) { return -x; }
int L0(int x) { return x * 3; }
int main_(int x) { return x; }
double mov_d(double f0, double f2) { return f0 * f2; }
int bne(struct reg r) { return r.t0 + r.v0 + (int)r.s0 + r.a0; }

int main(void) {
    int t0, t1, v0, a0, s0, s8, lo, hi, end, loop, sll;
    struct reg r;
    struct reg *ptr;
    add = 1; sub = 2; li = 3; la = 4; lw = 5; sw = 6; j = 7; jal = 8; b = 9;
    beq = 10; nop = 11; syscall = 12;
    f0 = 1.5; f12 = 2.25;
    data[0] = 'd'; data[1] = 0;
    text[0] = 't'; text[1] = 0;
    asciiz[0] = 'z'; asciiz[1] = 0;
    t0 = move(10, 3);
    t1 = divu(17, 5);
    v0 = mul(6, 7);
    a0 = jr(41);
    s0 = __rt_printf(21);
    s8 = fn_main(1) + gv_add(2) + L0(3) + main_(4);
    lo = zero + at + sp + ra + fp + gp + k0;
    hi = globl * word + space - align;
    printf("%d %d %d %d %d %d %d %d %d %d %d %d\n", add, sub, li, la, lw, sw, j, jal, b, beq, nop, syscall);
    printf("%d %d %d %d %d %d %d %d\n", t0, t1, v0, a0, s0, s8, lo, hi);
    printf("%s %s %s %.4f\n", data, text, asciiz, mov_d(f0, f12));
    r.t0 = 1; r.v0 = 2; r.s0 = 3.75; r.a0 = 4;
    ptr = &r;
    ptr->v0 = ptr->v0 + 20;
    printf("struct %d %d %.2f %d bne=%d\n", r.t0, r.v0, r.s0, r.a0, bne(r));
    loop = 0;
    sll = 0;
end:
    sll = sll + loop;
    loop++;
    if (loop < 5) goto end;
    goto syscall_;
syscall_:
    printf("labels %d %d\n", loop, sll);
    return 0;
}
