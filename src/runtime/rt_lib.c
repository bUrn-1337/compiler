/* rt_lib.c -- the runtime library of mipscc, written in the compiler's own
 * source language and compiled by it (makefile: stage0 --runtime -O1).
 *
 * In runtime mode every function and global of this file is named
 * __rt_<name> / __rtg_<name> in the assembly, so `printf' in a user program
 * (which the back end calls as __rt_printf) and `malloc' here are the same
 * symbol.  Each function or global becomes one unit, and the compiler copies
 * into a program only the units it actually reaches (MIPS-DESIGN.md sec. 8).
 *
 * The behaviour of every routine is that of tools/irsim.cpp, the Stage 3 IR
 * interpreter, which in turn is that of glibc as seen by `gcc -m32':
 *   - printf: every flag, width/precision (also `*'), d i u o x X c s p
 *     f F e E g G a A and %%, with doubles converted EXACTLY (big-number
 *     arithmetic, ties to even), so the digits are glibc's;
 *   - scanf: the irsim algorithm, with a correctly rounded strtod;
 *   - malloc: irsim's first-fit allocator over sbrk (8-byte rounding, whole
 *     blocks reused, no splitting), with checked free/realloc;
 *   - FILE*: a pointer to an entry of rt_files[] (see struct rtfile).
 * The language has no unsigned type, so unsigned arithmetic is spelled out
 * with masks; it has no 64-bit integer, so doubles are taken apart as two
 * words (little-endian: word 0 is the low half).
 */

/* ---------------------------------------------------------------------
 * Provided by rt_core.s.
 */
int   sys_write(int fd, char *buf, int n);
int   sys_read(int fd, char *buf, int n);
int   sys_open(char *name, int flags, int mode);
int   sys_close(int fd);
char *sys_sbrk(int n);
char *memmove(char *d, char *s, int n);
void  bzero(char *p, int n);
void  exit(int status);

/* ---------------------------------------------------------------------
 * Small helpers.
 */
int is_space(int c) {
    return c == ' ' || (c >= 9 && c <= 13);
}

int is_digit(int c) {
    return c >= '0' && c <= '9';
}

int strlen(char *s) {
    int n;
    n = 0;
    while (s[n]) n++;
    return n;
}

/* Writes `msg' to stderr and exits with status 70, as irsim does for every
   run-time error it detects. */
void rt_fatal(char *msg) {
    sys_write(2, "runtime error: ", 15);
    sys_write(2, msg, strlen(msg));
    sys_write(2, "\n", 1);
    exit(70);
}

/* ---------------------------------------------------------------------
 * Output sink of the printf family.  out_str is non-zero for sprintf;
 * otherwise characters collect in out_buf and go to out_fd.
 */
int   out_fd;
char *out_str;
int   out_count;
int   out_len;
char  out_buf[256];

void out_flush(void) {
    if (out_len > 0) sys_write(out_fd, out_buf, out_len);
    out_len = 0;
}

void out_char(int c) {
    out_count++;
    if (out_str) {
        *out_str = c;
        out_str = out_str + 1;
        return;
    }
    out_buf[out_len] = c;
    out_len++;
    if (out_len == 256) out_flush();
}

void out_pad(int c, int n) {
    while (n > 0) {
        out_char(c);
        n--;
    }
}

void out_mem(char *s, int n) {
    int i;
    for (i = 0; i < n; i++) out_char(s[i]);
}

/* The digit character for d (0..35). */
int dig_char(int d, int upper) {
    if (d < 10) return '0' + d;
    if (upper) return 'A' + d - 10;
    return 'a' + d - 10;
}

/* Writes the digits of v, read as UNSIGNED, in base 8, 10 or 16 into dg,
   least significant first; returns their number. */
int udigits(int v, int base, int upper, char *dg) {
    int n, d, q;
    n = 0;
    if (v < 0) {
        /* one step by hand, so that the rest is ordinary signed division */
        if (base == 10) {
            q = ((v >> 1) & 0x7fffffff) / 5;
            d = v - q * 10;
        } else if (base == 16) {
            q = (v >> 4) & 0x0fffffff;
            d = v & 15;
        } else {
            q = (v >> 3) & 0x1fffffff;
            d = v & 7;
        }
        dg[n++] = dig_char(d, upper);
        v = q;
    }
    do {
        d = v % base;
        v = v / base;
        dg[n++] = dig_char(d, upper);
    } while (v != 0);
    return n;
}

/* Writes v >= 0 (or INT_MIN's magnitude) in decimal, at least mind digits. */
void out_num(int v, int mind) {
    char b[16];
    int  n;
    n = udigits(v, 10, 0, b);
    while (n < mind) b[n++] = '0';
    while (n > 0) out_char(b[--n]);
}

/* ---------------------------------------------------------------------
 * printf conversions.  The flags of the conversion being formatted:
 */
int pf_left;
int pf_plus;
int pf_space;
int pf_alt;
int pf_zero;
int pf_width;
int pf_prec;      /* -1: no precision */

void pad_before(int len) {
    if (!pf_left) out_pad(' ', pf_width - len);
}

void pad_after(int len) {
    if (pf_left) out_pad(' ', pf_width - len);
}

/* %d %i %u %o %x %X with glibc's rules: the precision is a minimum digit
   count (and turns the '0' flag off), precision 0 prints nothing for 0,
   '#' gives a leading 0 for %o and 0x/0X for a non-zero %x/%X, '+' and ' '
   only apply to the signed conversions. */
void fmt_int(int v, int conv) {
    char dg[16];
    char pre[4];
    int  nd, np, zeros, base, len, i;
    base = 10;
    np = 0;
    if (conv == 'o') base = 8;
    if (conv == 'x' || conv == 'X') base = 16;
    if (conv == 'd' || conv == 'i') {
        if (v < 0) {
            pre[np++] = '-';
            v = -v;                     /* INT_MIN stays, read as unsigned */
        } else if (pf_plus) pre[np++] = '+';
        else if (pf_space) pre[np++] = ' ';
    }
    nd = 0;
    if (!(v == 0 && pf_prec == 0)) nd = udigits(v, base, conv == 'X', dg);
    zeros = 0;
    if (pf_prec > nd) zeros = pf_prec - nd;
    if (conv == 'o' && pf_alt && zeros == 0 && (nd == 0 || dg[nd - 1] != '0'))
        zeros = 1;
    if ((conv == 'x' || conv == 'X') && pf_alt && v != 0) {
        pre[np++] = '0';
        pre[np++] = conv;
    }
    len = np + zeros + nd;
    if (pf_zero && !pf_left && pf_prec < 0 && pf_width > len) {
        zeros = zeros + pf_width - len;
        len = pf_width;
    }
    pad_before(len);
    out_mem(pre, np);
    out_pad('0', zeros);
    for (i = nd - 1; i >= 0; i--) out_char(dg[i]);
    pad_after(len);
}

/* %s: at most `precision' characters; a null pointer prints "(null)", or
   nothing when the precision is below 6 (glibc). */
void fmt_str(char *s) {
    int n;
    if (s == 0) {
        if (pf_prec >= 0 && pf_prec < 6) s = "";
        else s = "(null)";
    }
    n = 0;
    while (s[n] && (pf_prec < 0 || n < pf_prec)) n++;
    pad_before(n);
    out_mem(s, n);
    pad_after(n);
}

/* ---------------------------------------------------------------------
 * Exact decimal expansion of a double.  A finite double is m * 2^e with an
 * integer m < 2^53; for e < 0 it equals m * 5^-e / 10^-e, so the decimal
 * digits are those of the integer m * 5^-e (or m * 2^e for e >= 0), which
 * fd_decode computes in base 10000.  The result is
 *     value = 0.fd_dig[0] fd_dig[1] ... fd_dig[fd_n-1]  x  10^fd_exp
 * with no leading or trailing zero digits (fd_n == 0 for zero).
 */
int  fd_big[208];
int  fd_nbig;
char fd_dig[840];
int  fd_n;
int  fd_exp;

/* fd_big *= m  (m <= 78125, so a limb product stays below 2^31) */
void fd_mul(int m) {
    int i, t, carry;
    carry = 0;
    for (i = 0; i < fd_nbig; i++) {
        t = fd_big[i] * m + carry;
        fd_big[i] = t % 10000;
        carry = t / 10000;
    }
    while (carry) {
        fd_big[fd_nbig++] = carry % 10000;
        carry = carry / 10000;
    }
}

/* fd_big += a  (a >= 0) */
void fd_add(int a) {
    int i;
    i = 0;
    while (a) {
        if (i == fd_nbig) fd_big[fd_nbig++] = 0;
        a = a + fd_big[i];
        fd_big[i] = a % 10000;
        a = a / 10000;
        i++;
    }
}

/* Sets fd_dig/fd_n/fd_exp to the exact value of the finite double whose
   words are hi:lo, ignoring its sign. */
void fd_decode(int hi, int lo) {
    int ex, e, k, t, i, j, nd, frac;
    ex = (hi >> 20) & 0x7ff;
    hi = hi & 0xfffff;
    if (ex) {
        hi = hi | 0x100000;
        e = ex - 1075;
    } else e = -1074;
    fd_nbig = 0;
    fd_add(hi);
    fd_mul(65536);
    fd_add((lo >> 16) & 0xffff);
    fd_mul(65536);
    fd_add(lo & 0xffff);
    fd_n = 0;
    fd_exp = 0;
    if (fd_nbig == 0) return;
    frac = 0;
    if (e > 0) {
        k = e;
        while (k >= 13) { fd_mul(8192); k = k - 13; }
        fd_mul(1 << k);
    } else if (e < 0) {
        k = -e;
        frac = k;
        while (k >= 7) { fd_mul(78125); k = k - 7; }
        t = 1;
        while (k > 0) { t = t * 5; k--; }
        fd_mul(t);
    }
    nd = 0;
    for (i = fd_nbig - 1; i >= 0; i--) {
        t = fd_big[i];
        fd_dig[nd]     = '0' + t / 1000;
        fd_dig[nd + 1] = '0' + t / 100 % 10;
        fd_dig[nd + 2] = '0' + t / 10 % 10;
        fd_dig[nd + 3] = '0' + t % 10;
        nd = nd + 4;
    }
    j = 0;
    while (fd_dig[j] == '0') j++;
    for (i = j; i < nd; i++) fd_dig[i - j] = fd_dig[i];
    nd = nd - j;
    fd_exp = nd - frac;
    while (nd > 0 && fd_dig[nd - 1] == '0') nd--;
    fd_n = nd;
}

/* Rounds the expansion to its first n digits (n may be <= 0: then to a
   unit of the place just above the first digit), ties to even -- what
   glibc does in the default rounding mode. */
void fd_round(int n) {
    int up, i;
    if (n >= fd_n) return;
    if (n < 0) { fd_n = 0; return; }
    if (n == 0) {
        up = fd_dig[0] > '5' || (fd_dig[0] == '5' && fd_n > 1);
        fd_n = 0;
        if (up) {
            fd_dig[0] = '1';
            fd_n = 1;
            fd_exp++;
        }
        return;
    }
    up = fd_dig[n] > '5'
      || (fd_dig[n] == '5' && (fd_n > n + 1 || (fd_dig[n - 1] - '0') % 2 == 1));
    fd_n = n;
    if (up) {
        i = n - 1;
        while (i >= 0 && fd_dig[i] == '9') i--;
        if (i < 0) {
            fd_dig[0] = '1';
            fd_n = 1;
            fd_exp++;
        } else {
            fd_dig[i] = fd_dig[i] + 1;
            fd_n = i + 1;
        }
    }
    while (fd_n > 0 && fd_dig[fd_n - 1] == '0') fd_n--;
}

/* The digit at index i of the expansion ('0' outside the stored digits). */
int fd_at(int i) {
    if (i >= 0 && i < fd_n) return fd_dig[i];
    return '0';
}

/* The body of %f: integer part, optional point, prec fraction digits. */
void emit_f(int prec, int point) {
    int i;
    if (fd_exp > 0) {
        for (i = 0; i < fd_exp; i++) out_char(fd_at(i));
    } else out_char('0');
    if (point) out_char('.');
    for (i = 1; i <= prec; i++) out_char(fd_at(fd_exp - 1 + i));
}

/* The body of %e: d.ddd then e+XX (at least two exponent digits). */
void emit_e(int prec, int point, int upper) {
    int i, x;
    out_char(fd_at(0));
    if (point) out_char('.');
    for (i = 1; i <= prec; i++) out_char(fd_at(i));
    out_char(upper ? 'E' : 'e');
    x = 0;
    if (fd_n) x = fd_exp - 1;
    if (x < 0) { out_char('-'); x = -x; }
    else out_char('+');
    out_num(x, 2);
}

/* %a / %A as glibc prints it: 0x1.<hex>p<exp> for a normal number,
   0x0.<hex>p-1022 for a subnormal, 0x0p+0 for zero; without a precision
   the 13 fraction digits lose their trailing zeros, with one they are
   rounded (ties to even) and a carry may make the lead digit 2. */
void fmt_hexf(int hi, int lo, int upper, char *pre, int np) {
    int nib[16];
    int i, ex, lead, e, prec, up, rest, len, zeros, ax, point;
    ex = (hi >> 20) & 0x7ff;
    for (i = 0; i < 5; i++) nib[i] = (hi >> (16 - 4 * i)) & 15;
    for (i = 0; i < 8; i++) nib[5 + i] = (lo >> (28 - 4 * i)) & 15;
    lead = 0;
    e = 0;
    if (ex) { lead = 1; e = ex - 1023; }
    else if ((hi & 0xfffff) != 0 || lo != 0) e = -1022;
    if (pf_prec < 0) {
        prec = 13;
        while (prec > 0 && nib[prec - 1] == 0) prec--;
    } else {
        prec = pf_prec;
        if (prec < 13) {
            rest = 0;
            for (i = prec + 1; i < 13; i++) if (nib[i]) rest = 1;
            if (prec > 0) up = nib[prec - 1] & 1;
            else up = lead & 1;
            up = nib[prec] > 8 || (nib[prec] == 8 && (rest || up));
            if (up) {
                i = prec - 1;
                while (i >= 0 && nib[i] == 15) { nib[i] = 0; i--; }
                if (i < 0) lead++;
                else nib[i]++;
            }
        }
    }
    point = prec > 0 || pf_alt;
    ax = e < 0 ? -e : e;
    len = np + 2 + 1 + (point ? 1 + prec : 0) + 2;
    if (ax >= 10) len++;
    if (ax >= 100) len++;
    if (ax >= 1000) len++;
    zeros = 0;
    if (pf_zero && !pf_left && pf_width > len) zeros = pf_width - len;
    pad_before(len + zeros);
    out_mem(pre, np);
    out_char('0');
    out_char(upper ? 'X' : 'x');
    out_pad('0', zeros);
    out_char(dig_char(lead, upper));
    if (point) out_char('.');
    for (i = 0; i < prec; i++) {
        if (i < 13) out_char(dig_char(nib[i], upper));
        else out_char('0');
    }
    out_char(upper ? 'P' : 'p');
    if (e < 0) out_char('-');
    else out_char('+');
    out_num(ax, 1);
    pad_after(len + zeros);
}

/* %f %F %e %E %g %G %a %A for the double whose words are hi:lo.  The
   digits are exact (fd_decode) and rounded once, so they are glibc's.
   %g picks the style from the exponent X after rounding to P digits:
   %f-style with precision P-1-X when -4 <= X < P, else %e-style with P-1;
   without '#' the trailing zeros (and a bare point) are dropped. */
void fmt_float(int hi, int lo, int conv) {
    char pre[4];
    int  upper, c, np, prec, p, x, t, kind, point, len, zeros, ax;
    upper = conv == 'F' || conv == 'E' || conv == 'G' || conv == 'A';
    c = conv | 32;
    np = 0;
    if (hi < 0) pre[np++] = '-';
    else if (pf_plus) pre[np++] = '+';
    else if (pf_space) pre[np++] = ' ';
    if ((hi & 0x7ff00000) == 0x7ff00000) {
        len = np + 3;
        pad_before(len);
        out_mem(pre, np);
        if ((hi & 0xfffff) != 0 || lo != 0) out_mem(upper ? "NAN" : "nan", 3);
        else out_mem(upper ? "INF" : "inf", 3);
        pad_after(len);
        return;
    }
    if (c == 'a') {
        fmt_hexf(hi, lo, upper, pre, np);
        return;
    }
    fd_decode(hi, lo);
    prec = pf_prec < 0 ? 6 : pf_prec;
    kind = c;
    if (c == 'f') fd_round(fd_exp + prec);
    else if (c == 'e') fd_round(prec + 1);
    else {
        p = prec == 0 ? 1 : prec;
        fd_round(p);
        x = fd_n ? fd_exp - 1 : 0;
        if (x < p && x >= -4) {
            kind = 'f';
            prec = p - 1 - x;
            t = fd_n - fd_exp;
            if (!pf_alt && t < prec) prec = t < 0 ? 0 : t;
        } else {
            kind = 'e';
            prec = p - 1;
            t = fd_n - 1;
            if (!pf_alt && t < prec) prec = t < 0 ? 0 : t;
        }
    }
    point = prec > 0 || pf_alt;
    if (kind == 'f') {
        len = (fd_exp > 0 ? fd_exp : 1) + (point ? 1 + prec : 0);
    } else {
        x = fd_n ? fd_exp - 1 : 0;
        ax = x < 0 ? -x : x;
        len = 1 + (point ? 1 + prec : 0) + 2 + (ax >= 100 ? 3 : 2);
    }
    len = len + np;
    zeros = 0;
    if (pf_zero && !pf_left && pf_width > len) zeros = pf_width - len;
    pad_before(len + zeros);
    out_mem(pre, np);
    out_pad('0', zeros);
    if (kind == 'f') emit_f(prec, point);
    else emit_e(prec, point, upper);
    pad_after(len + zeros);
}

/* Re-emits an unknown conversion's text from fmt[from] (the '%') up to
   fmt[to], with each '*' replaced by the value it took, as irsim does. */
void out_spec(char *fmt, int from, int to, int wv, int pv) {
    int i, dot, v;
    dot = 0;
    for (i = from; i < to; i++) {
        if (fmt[i] == '.' && fmt[i + 1] == '*' && pv < 0) {
            i++;                        /* a negative precision is dropped */
            continue;
        }
        if (fmt[i] == '.') dot = 1;
        if (fmt[i] == '*') {
            v = dot ? pv : wv;
            if (v < 0) { out_char('-'); v = -v; }
            out_num(v, 1);
        } else out_char(fmt[i]);
    }
}

int is_lenmod(int c) {
    return c == 'h' || c == 'l' || c == 'L' || c == 'z' || c == 'j' || c == 't';
}

/* An integer argument of %hd/%hx... is printed as a short and of
   %hhd/%hhx... as a char, as glibc does (the caller passed an int);
   fmt[from..to) are the length modifiers.  Other modifiers are ignored:
   every integer is 32-bit. */
int narrow(int v, char *fmt, int from, int to, int conv) {
    int sgn;
    sgn = conv == 'd' || conv == 'i';
    if (to - from == 1 && fmt[from] == 'h') {
        if (sgn) return (v << 16) >> 16;
        return v & 0xffff;
    }
    if (to - from == 2 && fmt[from] == 'h' && fmt[from + 1] == 'h') {
        if (sgn) return (v << 24) >> 24;
        return v & 0xff;
    }
    return v;
}

/* Parses the flags, width and precision of the conversion starting at
   fmt[i] (just after the '%') into pf_*, taking '*' values from *app.
   Returns the index of the first length modifier or conversion letter;
   the raw '*' values go to wv[0] and pv[0] for out_spec. */
int parse_spec(char *fmt, int i, int **app, int *wv, int *pv) {
    int c;
    pf_left = 0; pf_plus = 0; pf_space = 0; pf_alt = 0; pf_zero = 0;
    pf_width = 0;
    pf_prec = -1;
    while (1) {
        c = fmt[i];
        if (c == '-') pf_left = 1;
        else if (c == '+') pf_plus = 1;
        else if (c == ' ') pf_space = 1;
        else if (c == '#') pf_alt = 1;
        else if (c == '0') pf_zero = 1;
        else break;
        i++;
    }
    if (fmt[i] == '*') {
        pf_width = **app;
        *app = *app + 1;
        *wv = pf_width;
        if (pf_width < 0) { pf_left = 1; pf_width = -pf_width; }
        i++;
    } else while (is_digit(fmt[i])) { pf_width = pf_width * 10 + fmt[i] - '0'; i++; }
    if (fmt[i] == '.') {
        i++;
        pf_prec = 0;
        if (fmt[i] == '*') {
            pf_prec = **app;
            *app = *app + 1;
            *pv = pf_prec;
            if (pf_prec < 0) pf_prec = -1;      /* "as if omitted" (C99) */
            i++;
        } else while (is_digit(fmt[i])) { pf_prec = pf_prec * 10 + fmt[i] - '0'; i++; }
    }
    return i;
}

/* The printf engine behind vprintf, vfprintf and vsprintf: copies `fmt' to
   the sink, formatting one argument per conversion.  `ap' points to the
   variable arguments, laid out as the words of a struct (a double is
   8-byte aligned and takes two words, low word first).  Length modifiers
   are skipped (every integer is 32 bits and a float argument arrives as a
   double); an unknown conversion is copied out and consumes nothing.
   Returns the number of characters produced. */
int vformat(char *fmt, int *ap) {
    int i, start, mods, conv, wv, pv;
    i = 0;
    while (fmt[i]) {
        if (fmt[i] != '%') { out_char(fmt[i]); i++; continue; }
        if (fmt[i + 1] == '%') { out_char('%'); i = i + 2; continue; }
        start = i;
        wv = 0;
        pv = 0;
        i = parse_spec(fmt, i + 1, &ap, &wv, &pv);
        mods = i;
        while (is_lenmod(fmt[i])) i++;
        if (fmt[i] == 0) { out_spec(fmt, start, mods, wv, pv); break; }
        conv = fmt[i];
        i++;
        switch (conv) {
        case 'd': case 'i': case 'u': case 'o': case 'x': case 'X':
            fmt_int(narrow(*ap, fmt, mods, i - 1, conv), conv);
            ap = ap + 1;
            break;
        case 'c':
            pad_before(1);
            out_char(*ap & 0xff);
            pad_after(1);
            ap = ap + 1;
            break;
        case 's':
            fmt_str((char *)*ap);
            ap = ap + 1;
            break;
        case 'p':
            out_char('0');
            out_char('x');
            pf_alt = 0; pf_prec = -1; pf_width = 0;
            fmt_int(*ap, 'x');
            ap = ap + 1;
            break;
        case 'f': case 'F': case 'e': case 'E':
        case 'g': case 'G': case 'a': case 'A':
            ap = (int *)(((int)ap + 7) & -8);
            fmt_float(ap[1], ap[0], conv);
            ap = ap + 2;
            break;
        case '%':
            out_char('%');              /* glibc ignores flags and width */
            break;
        default:
            out_spec(fmt, start, mods, wv, pv);
            out_char(conv);
            break;
        }
    }
    return out_count;
}

/* ---------------------------------------------------------------------
 * FILE*.  A FILE* is the address of an entry of rt_files[]; rt_stdin is
 * the standard input (fd 0, never closed).  Writes are unbuffered (each
 * call is one write syscall), so nothing needs flushing; reads go through
 * a 512-byte buffer with one character of push-back for scanf.  spim's
 * open(2) syscall takes the host's (Linux) flag values.
 */
struct rtfile {
    int  used;          /* 1 while open                                   */
    int  fd;
    int  flags;         /* open flags without O_TRUNC, for rewind         */
    int  eof;           /* end-of-file indicator (sticky, as in glibc)    */
    int  hasback;       /* a pushed-back character is in `back'           */
    int  back;
    int  pos;           /* read buffer: buf[pos..len)                     */
    int  len;
    char buf[512];
    char name[256];     /* "" when the name did not fit: no rewind        */
};

struct rtfile rt_files[16];
struct rtfile rt_stdin;

/* The open entry `f' points to, or 0 when f is not an open FILE*. */
struct rtfile *file_of(struct rtfile *f) {
    int i;
    for (i = 0; i < 16; i++)
        if (f == &rt_files[i] && rt_files[i].used) return f;
    return 0;
}

/* fgetc on an entry: push-back first, then the buffer, refilled by read. */
int f_getc(struct rtfile *f) {
    int n;
    if (f->hasback) {
        f->hasback = 0;
        return f->back;
    }
    if (f->eof) return -1;
    if (f->pos >= f->len) {
        n = sys_read(f->fd, f->buf, 512);
        if (n <= 0) {
            f->eof = 1;
            return -1;
        }
        f->pos = 0;
        f->len = n;
    }
    n = f->buf[f->pos] & 0xff;
    f->pos++;
    return n;
}

/* Names that remove() has deleted (see remove below). */
char rm_names[2048];
int  rm_used[8];

/* The index of `name' in the removed list, or -1. */
int rm_find(char *name) {
    int i, k;
    for (i = 0; i < 8; i++) {
        if (!rm_used[i]) continue;
        k = 0;
        while (name[k] && name[k] == rm_names[i * 256 + k]) k++;
        if (name[k] == 0 && rm_names[i * 256 + k] == 0) return i;
    }
    return -1;
}

/* fopen: mode "r", "w" or "a", each optionally with '+' (and 'b', which
   is ignored); 0 when the mode is invalid, no entry is free, the file
   cannot be opened, or remove() deleted it and the mode is "r". */
struct rtfile *fopen(char *name, char *mode) {
    struct rtfile *f;
    int i, flags, plus, fd, n;
    f = 0;
    for (i = 0; i < 16 && f == 0; i++) if (!rt_files[i].used) f = &rt_files[i];
    if (f == 0) return 0;
    plus = 0;
    for (i = 1; mode[0] && mode[i]; i++) if (mode[i] == '+') plus = 1;
    if (mode[0] == 'r') flags = plus ? 2 : 0;
    else if (mode[0] == 'w') flags = plus ? 0x242 : 0x241;
    else if (mode[0] == 'a') flags = plus ? 0x442 : 0x441;
    else return 0;
    i = rm_find(name);
    if (i >= 0) {
        if (mode[0] == 'r') return 0;
        rm_used[i] = 0;
    }
    fd = sys_open(name, flags, 0x1a4);
    if (fd < 0) return 0;
    f->used = 1;
    f->fd = fd;
    f->flags = flags & ~0x200;
    f->eof = 0;
    f->hasback = 0;
    f->pos = 0;
    f->len = 0;
    n = strlen(name);
    if (n < 256) {
        for (i = 0; i <= n; i++) f->name[i] = name[i];
    } else f->name[0] = 0;
    return f;
}

int fclose(struct rtfile *f) {
    f = file_of(f);
    if (f == 0) return -1;
    sys_close(f->fd);
    f->used = 0;
    return 0;
}

/* rewind: spim has no lseek, so the file is closed and opened again with
   its original flags minus O_TRUNC. */
void rewind(struct rtfile *f) {
    f = file_of(f);
    if (f == 0) return;
    f->eof = 0;
    f->hasback = 0;
    f->pos = 0;
    f->len = 0;
    if (f->name[0] == 0) return;
    sys_close(f->fd);
    f->fd = sys_open(f->name, f->flags, 0x1a4);
}

/* remove: spim has no unlink, so the file is truncated to length 0 and
   its name recorded; fopen(name, "r") then fails as if it were gone, and
   fopen "w"/"a" forgets the record.  0 if the file existed, else -1.  An
   empty file is left on disk (README, limitations). */
int remove(char *name) {
    int fd, i, k;
    if (rm_find(name) >= 0) return -1;
    fd = sys_open(name, 0, 0);
    if (fd < 0) return -1;
    sys_close(fd);
    fd = sys_open(name, 0x201, 0x1a4);
    if (fd >= 0) sys_close(fd);
    k = strlen(name);
    if (k >= 256) return 0;
    i = 0;
    while (i < 7 && rm_used[i]) i++;
    rm_used[i] = 1;
    for (k = 0; name[k]; k++) rm_names[i * 256 + k] = name[k];
    rm_names[i * 256 + k] = 0;
    return 0;
}

int feof(struct rtfile *f) {
    f = file_of(f);
    if (f == 0) return 1;
    return f->eof;
}

int fgetc(struct rtfile *f) {
    struct rtfile *g;
    g = file_of(f);
    if (g == 0) g = &rt_stdin;
    return f_getc(g);
}

int getchar(void) {
    return f_getc(&rt_stdin);
}

/* fgets: at most n-1 characters, up to and including a newline; 0 when
   nothing was read. */
char *fgets(char *s, int n, struct rtfile *f) {
    struct rtfile *g;
    int i, c;
    g = file_of(f);
    if (g == 0) g = &rt_stdin;
    if (n <= 0) return 0;
    i = 0;
    while (i < n - 1) {
        c = f_getc(g);
        if (c < 0) break;
        s[i] = c;
        i++;
        if (c == '\n') break;
    }
    if (i == 0) return 0;
    s[i] = 0;
    return s;
}

/* The descriptor output to f goes to: stdout for an invalid FILE*. */
int file_fd(struct rtfile *f) {
    f = file_of(f);
    if (f == 0) return 1;
    return f->fd;
}

int fputc(int c, struct rtfile *f) {
    char b[4];
    b[0] = c;
    sys_write(file_fd(f), b, 1);
    return c & 0xff;
}

int fputs(char *s, struct rtfile *f) {
    int n;
    n = strlen(s);
    sys_write(file_fd(f), s, n);
    return n;
}

int putchar(int c) {
    char b[4];
    b[0] = c;
    sys_write(1, b, 1);
    return c & 0xff;
}

int puts(char *s) {
    int n;
    n = strlen(s);
    sys_write(1, s, n);
    sys_write(1, "\n", 1);
    return n + 1;
}

/* ---------------------------------------------------------------------
 * printf family entry points (the variadic stubs are in rt_core.s).
 */
int vprintf(char *fmt, int *ap) {
    out_fd = 1;
    out_str = 0;
    out_count = 0;
    out_len = 0;
    vformat(fmt, ap);
    out_flush();
    return out_count;
}

int vfprintf(struct rtfile *f, char *fmt, int *ap) {
    out_fd = file_fd(f);
    out_str = 0;
    out_count = 0;
    out_len = 0;
    vformat(fmt, ap);
    out_flush();
    return out_count;
}

int vsprintf(char *buf, char *fmt, int *ap) {
    out_str = buf;
    out_count = 0;
    out_len = 0;
    vformat(fmt, ap);
    *out_str = 0;
    out_str = 0;
    return out_count;
}

/* ---------------------------------------------------------------------
 * strtol/strtoul's arithmetic with a 32-bit long, as glibc under gcc -m32
 * (and irsim): the magnitude is accumulated exactly in four 16-bit limbs
 * (acc_ovf once it passes 2^64); a signed result saturates to INT_MIN /
 * INT_MAX, an unsigned one to UINT_MAX, and a '-' negates an unsigned
 * result modulo 2^32.
 */
int acc[4];
int acc_ovf;

void acc_clear(void) {
    acc[0] = 0; acc[1] = 0; acc[2] = 0; acc[3] = 0;
    acc_ovf = 0;
}

void acc_digit(int d, int base) {
    int i, t;
    for (i = 0; i < 4; i++) {
        t = acc[i] * base + d;
        acc[i] = t & 0xffff;
        d = t >> 16;
    }
    if (d) acc_ovf = 1;
}

int acc_value(int neg, int sgn) {
    int v, big;
    big = acc_ovf || acc[2] || acc[3];
    v = (acc[1] << 16) | acc[0];
    if (!sgn) {
        if (big) return -1;             /* UINT_MAX */
        if (neg) return -v;
        return v;
    }
    if (!neg) {
        if (big || acc[1] >= 0x8000) return 0x7fffffff;
        return v;
    }
    if (big || acc[1] > 0x8000 || (acc[1] == 0x8000 && acc[0] != 0))
        return 0x80000000;
    return -v;
}

/* The value of hex/octal/decimal digit c in `base', or -1. */
int digit_val(int c, int base) {
    int d;
    d = -1;
    if (c >= '0' && c <= '9') d = c - '0';
    else if (c >= 'a' && c <= 'f') d = c - 'a' + 10;
    else if (c >= 'A' && c <= 'F') d = c - 'A' + 10;
    if (d >= base) return -1;
    return d;
}

int atoi(char *s) {
    int i, neg, d;
    i = 0;
    while (is_space(s[i])) i++;
    neg = 0;
    if (s[i] == '+' || s[i] == '-') { neg = s[i] == '-'; i++; }
    acc_clear();
    while (1) {
        d = digit_val(s[i], 10);
        if (d < 0) break;
        acc_digit(d, 10);
        i++;
    }
    return acc_value(neg, 1);
}

/* ---------------------------------------------------------------------
 * Correctly rounded decimal -> double (strtod).  The significant digits
 * are kept in dd_dig (at most 780: any midpoint between two doubles has
 * fewer, so a dropped non-zero tail only needs a sticky '1'), and the
 * value is D * 10^E for the integer D they spell.  D * 10^E is turned into
 * a fraction num/den of big integers (16-bit limbs), scaled by a power of
 * two so that the quotient has 55 or 56 bits; those bits, the remainder,
 * and the exponent give the rounded (ties-to-even) double, subnormals
 * included.
 */
char dd_dig[800];
int  dd_n;
int  dd_adj;
int  dd_sticky;

void dd_clear(void) {
    dd_n = 0;
    dd_adj = 0;
    dd_sticky = 0;
}

/* Appends digit character c, which is a fraction digit when frac != 0. */
void dd_push(int c, int frac) {
    if (dd_n == 0 && c == '0') {
        if (frac) dd_adj--;
        return;
    }
    if (dd_n < 780) {
        dd_dig[dd_n++] = c;
        if (frac) dd_adj--;
    } else {
        if (c != '0') dd_sticky = 1;
        if (!frac) dd_adj++;
    }
}

struct big {
    int n;              /* limbs in use; the top one is non-zero */
    int d[264];         /* 16-bit limbs, least significant first   */
};

struct big bg_num;
struct big bg_den;

void big_set(struct big *b, int v) {
    b->n = 0;
    if (v) { b->d[0] = v; b->n = 1; }
}

/* b = b * m + a  (m <= 32767, a <= 32767) */
void big_muladd(struct big *b, int m, int a) {
    int i, t;
    for (i = 0; i < b->n; i++) {
        t = b->d[i] * m + a;
        b->d[i] = t & 0xffff;
        a = t >> 16;
    }
    if (a) b->d[b->n++] = a;
}

/* b = b * 10^k */
void big_pow10(struct big *b, int k) {
    while (k >= 4) { big_muladd(b, 10000, 0); k = k - 4; }
    while (k > 0) { big_muladd(b, 10, 0); k--; }
}

int big_bits(struct big *b) {
    int t, n;
    if (b->n == 0) return 0;
    n = (b->n - 1) * 16;
    t = b->d[b->n - 1];
    while (t) { n++; t = t >> 1; }
    return n;
}

void big_shl(struct big *b, int bits) {
    int w, r, i, v, carry;
    if (b->n == 0) return;
    w = bits >> 4;
    r = bits & 15;
    if (r) {
        carry = 0;
        for (i = 0; i < b->n; i++) {
            v = (b->d[i] << r) | carry;
            b->d[i] = v & 0xffff;
            carry = v >> 16;
        }
        if (carry) b->d[b->n++] = carry;
    }
    if (w) {
        for (i = b->n - 1; i >= 0; i--) b->d[i + w] = b->d[i];
        for (i = 0; i < w; i++) b->d[i] = 0;
        b->n = b->n + w;
    }
}

void big_shr1(struct big *b) {
    int i;
    for (i = 0; i < b->n; i++) {
        b->d[i] = b->d[i] >> 1;
        if (i + 1 < b->n) b->d[i] = b->d[i] | ((b->d[i + 1] & 1) << 15);
    }
    while (b->n > 0 && b->d[b->n - 1] == 0) b->n--;
}

int big_cmp(struct big *a, struct big *b) {
    int i;
    if (a->n != b->n) return a->n < b->n ? -1 : 1;
    for (i = a->n - 1; i >= 0; i--)
        if (a->d[i] != b->d[i]) return a->d[i] < b->d[i] ? -1 : 1;
    return 0;
}

/* a = a - b, for a >= b */
void big_sub(struct big *a, struct big *b) {
    int i, t, borrow;
    borrow = 0;
    for (i = 0; i < a->n; i++) {
        t = a->d[i] - borrow;
        if (i < b->n) t = t - b->d[i];
        borrow = 0;
        if (t < 0) { t = t + 65536; borrow = 1; }
        a->d[i] = t;
    }
    while (a->n > 0 && a->d[a->n - 1] == 0) a->n--;
}

/* The double with words hi:lo. */
double make_double(int hi, int lo) {
    double d;
    int   *w;
    w = (int *)&d;
    w[0] = lo;
    w[1] = hi;
    return d;
}

/* The double nearest to (neg ? -1 : 1) * D * 10^(dd_adj + e10), D being
   the digits in dd_dig.  See the comment above dd_dig. */
double dd_value(int neg, int e10) {
    int qb[64];
    int mb[64];
    int sign, i, k, sh, len, ex, keep, rb, sticky, hi, lo;
    sign = neg ? (1 << 31) : 0;
    if (dd_sticky) { dd_dig[dd_n++] = '1'; dd_adj--; }
    while (dd_n > 0 && dd_dig[dd_n - 1] == '0') { dd_n--; dd_adj++; }
    if (dd_n == 0) return make_double(sign, 0);
    e10 = e10 + dd_adj;
    if (dd_n + e10 > 310) return make_double(sign | 0x7ff00000, 0);
    if (dd_n + e10 < -326) return make_double(sign, 0);
    big_set(&bg_num, 0);
    for (i = 0; i < dd_n; i++) big_muladd(&bg_num, 10, dd_dig[i] - '0');
    big_set(&bg_den, 1);
    if (e10 >= 0) big_pow10(&bg_num, e10);
    else big_pow10(&bg_den, -e10);
    sh = 55 - (big_bits(&bg_num) - big_bits(&bg_den));
    if (sh > 0) big_shl(&bg_num, sh);
    else if (sh < 0) big_shl(&bg_den, -sh);
    /* num/den is now in (2^54, 2^56): long division, one bit at a time */
    big_shl(&bg_den, 55);
    for (k = 55; k >= 0; k--) {
        qb[k] = 0;
        if (big_cmp(&bg_num, &bg_den) >= 0) {
            big_sub(&bg_num, &bg_den);
            qb[k] = 1;
        }
        big_shr1(&bg_den);
    }
    sticky = bg_num.n != 0;
    len = 56;
    while (qb[len - 1] == 0) len--;
    ex = len - 1 - sh;                  /* exponent of the leading bit */
    if (ex > 1023) return make_double(sign | 0x7ff00000, 0);
    keep = 53;
    if (ex < -1022) keep = ex + 1075;   /* subnormal: fewer bits */
    if (keep < 0) return make_double(sign, 0);
    rb = len - 1 - keep;                /* the rounding bit */
    for (i = 0; i < 64; i++) mb[i] = 0;
    for (i = 0; i < keep; i++) mb[i] = qb[rb + 1 + i];
    for (i = 0; i < rb; i++) if (qb[i]) sticky = 1;
    if (qb[rb] && (sticky || mb[0])) {
        i = 0;
        while (mb[i]) { mb[i] = 0; i++; }
        mb[i] = 1;
    }
    if (keep == 53 && mb[53]) {         /* carried out: 2^53 -> 2^52 */
        for (i = 0; i < 53; i++) mb[i] = mb[i + 1];
        mb[53] = 0;
        ex++;
        if (ex > 1023) return make_double(sign | 0x7ff00000, 0);
    }
    lo = 0;
    for (i = 31; i >= 0; i--) lo = (lo << 1) | mb[i];
    hi = 0;
    for (i = 52; i >= 32; i--) hi = (hi << 1) | mb[i];
    if (keep == 53) hi = (hi & 0xfffff) | ((ex + 1023) << 20);
    return make_double(sign | hi, lo);
}

/* ---------------------------------------------------------------------
 * scanf family: irsim's algorithm over a character source that is either
 * a FILE entry (sc_str == 0) or a string.  sc_eof records that the source
 * ran out, which makes a failing scanf return EOF instead of 0 when it
 * has assigned nothing.
 */
int            sc_str;
char          *sc_s;
struct rtfile *sc_f;
int            sc_eof;

int sc_get(void) {
    int c;
    if (sc_str) {
        c = *sc_s & 0xff;
        if (c == 0) c = -1;
        else sc_s = sc_s + 1;
    } else c = f_getc(sc_f);
    if (c < 0) sc_eof = 1;
    return c;
}

void sc_unget(int c) {
    if (c < 0) return;
    if (sc_str) sc_s = sc_s - 1;
    else {
        sc_f->hasback = 1;
        sc_f->back = c;
    }
}

int sc_fail(int assigned) {
    if (assigned) return assigned;
    if (sc_eof) return -1;
    return 0;
}

void sc_skip_space(void) {
    int c;
    c = sc_get();
    while (c >= 0 && is_space(c)) c = sc_get();
    sc_unget(c);
}

/* %d %i %u %x %X %o, as glibc: an optional sign, then digits of the base;
   %i takes a 0x prefix as hex and a leading 0 as octal, %x also allows
   0x, and a "0x" with no hex digit after it reads as 0 (the x is lost).
   The width counts the sign and the prefix.  Stores through the next
   argument unless suppressed.  Returns 1 on success, 0 on a matching
   failure. */
int scan_int(int conv, int width, int suppress, int **app) {
    int c, cnt, neg, base, ndig, d;
    int *p;
    cnt = 0;
    neg = 0;
    acc_clear();
    c = sc_get();
    if (c == '+' || c == '-') { neg = c == '-'; cnt++; c = sc_get(); }
    base = 10;
    if (conv == 'x' || conv == 'X') base = 16;
    if (conv == 'o') base = 8;
    if (conv == 'i') base = 0;
    ndig = 0;
    if ((base == 0 || base == 16) && c == '0' && (!width || cnt < width)) {
        cnt++;
        ndig++;
        c = sc_get();
        if ((!width || cnt < width) && (c == 'x' || c == 'X')) {
            cnt++;
            base = 16;
            c = sc_get();
        } else if (base == 0) base = 8;
    }
    if (base == 0) base = 10;
    while (c >= 0 && (!width || cnt < width)) {
        d = digit_val(c, base);
        if (d < 0) break;
        acc_digit(d, base);
        cnt++;
        ndig++;
        c = sc_get();
    }
    sc_unget(c);
    if (!ndig) return 0;
    if (!suppress) {
        p = (int *)**app;
        *app = *app + 1;
        *p = acc_value(neg, conv == 'd' || conv == 'i');
    }
    return 1;
}

/* %f %e %g %E %G: sign, digits, point, digits, and an exponent only if
   there were digits and the exponent has digits of its own (a lone 'e' is
   consumed but ignored, as in irsim).  %lf stores a double, %f a float. */
int scan_float(int islong, int suppress, int **app) {
    int    c, neg, ndig, eneg, edig, ev, e10;
    double v;
    double *dp;
    float  *fp;
    dd_clear();
    neg = 0;
    c = sc_get();
    if (c == '+' || c == '-') { neg = c == '-'; c = sc_get(); }
    ndig = 0;
    while (is_digit(c)) { dd_push(c, 0); ndig++; c = sc_get(); }
    if (c == '.') {
        c = sc_get();
        while (is_digit(c)) { dd_push(c, 1); ndig++; c = sc_get(); }
    }
    e10 = 0;
    if (ndig && (c == 'e' || c == 'E')) {
        c = sc_get();
        eneg = 0;
        if (c == '+' || c == '-') { eneg = c == '-'; c = sc_get(); }
        edig = 0;
        ev = 0;
        while (is_digit(c)) {
            if (ev < 100000) ev = ev * 10 + c - '0';
            edig++;
            c = sc_get();
        }
        if (edig) e10 = eneg ? -ev : ev;
    }
    sc_unget(c);
    if (!ndig) return 0;
    v = dd_value(neg, e10);
    if (!suppress) {
        if (islong) {
            dp = (double *)**app;
            *dp = v;
        } else {
            fp = (float *)**app;
            *fp = v;
        }
        *app = *app + 1;
    }
    return 1;
}

/* %c (width characters, default 1, no NUL, whitespace not skipped) and %s
   (a run of non-space characters, then a NUL). */
int scan_chars(int conv, int width, int suppress, int **app) {
    char *p;
    int   c, got, n;
    p = 0;
    if (!suppress) { p = (char *)**app; *app = *app + 1; }
    got = 0;
    if (conv == 'c') {
        n = width ? width : 1;
        while (got < n) {
            c = sc_get();
            if (c < 0) break;
            if (p) p[got] = c;
            got++;
        }
        return got > 0;
    }
    c = sc_get();
    while (c >= 0 && !is_space(c)) {
        if (p) p[got] = c;
        got++;
        c = sc_get();
        if (width && got >= width) break;
    }
    sc_unget(c);
    if (!got) return 0;
    if (p) p[got] = 0;
    return 1;
}

/* The scanf engine: white space in the format skips white space, other
   characters must match, and each conversion reads one field (see the
   scan_* routines).  Returns the number of assignments, or EOF (-1) when
   the input ran out before the first one. */
int vscan(char *fmt, int *ap) {
    int i, c, fc, assigned, suppress, width, islong, conv, ok;
    assigned = 0;
    i = 0;
    while (fmt[i]) {
        fc = fmt[i] & 0xff;
        if (is_space(fc)) { sc_skip_space(); i++; continue; }
        if (fc != '%') {
            c = sc_get();
            if (c != fc) { sc_unget(c); return sc_fail(assigned); }
            i++;
            continue;
        }
        i++;
        if (fmt[i] == '%') {
            c = sc_get();
            if (c != '%') { sc_unget(c); return sc_fail(assigned); }
            i++;
            continue;
        }
        suppress = 0;
        if (fmt[i] == '*') { suppress = 1; i++; }
        width = 0;
        while (is_digit(fmt[i])) { width = width * 10 + fmt[i] - '0'; i++; }
        islong = 0;
        while (is_lenmod(fmt[i])) {
            if (fmt[i] == 'l' || fmt[i] == 'L') islong = 1;
            i++;
        }
        conv = fmt[i];
        if (conv == 0) break;
        i++;
        if (conv != 'c') sc_skip_space();
        if (conv == 'd' || conv == 'i' || conv == 'u' || conv == 'x' || conv == 'X' || conv == 'o')
            ok = scan_int(conv, width, suppress, &ap);
        else if (conv == 'f' || conv == 'e' || conv == 'g' || conv == 'E' || conv == 'G')
            ok = scan_float(islong, suppress, &ap);
        else if (conv == 'c' || conv == 's')
            ok = scan_chars(conv, width, suppress, &ap);
        else return assigned;
        if (!ok) return sc_fail(assigned);
        if (!suppress) assigned++;
    }
    return assigned;
}

int vscanf(char *fmt, int *ap) {
    sc_str = 0;
    sc_f = &rt_stdin;
    sc_eof = 0;
    return vscan(fmt, ap);
}

int vfscanf(struct rtfile *f, char *fmt, int *ap) {
    f = file_of(f);
    if (f == 0) return -1;
    sc_str = 0;
    sc_f = f;
    sc_eof = 0;
    return vscan(fmt, ap);
}

int vsscanf(char *s, char *fmt, int *ap) {
    sc_str = 1;
    sc_s = s;
    sc_eof = 0;
    return vscan(fmt, ap);
}

/* ---------------------------------------------------------------------
 * The heap: irsim's allocator.  Sizes are rounded up to 8 (malloc(0) is
 * malloc(1)); a request takes the lowest-addressed free block that is big
 * enough, whole (no splitting), or else new memory from sbrk.  Each block
 * has an 8-byte header {size, tag} in front of it, the tag being the
 * block's address xor H_USED or H_FREE, so free() and realloc() reject a
 * pointer that is not a block (exit 70, as irsim) and a double free.  Free
 * blocks are chained in address order through their first word.
 */
char *heap_lo;
char *heap_hi;
char *free_head;

/* The header of block p, or 0 if p is not the start of a block. */
int *heap_header(char *p) {
    int *h;
    if (heap_lo == 0 || (int)p < (int)heap_lo + 8 || (int)p >= (int)heap_hi) return 0;
    if (((int)p & 7) != 0) return 0;
    h = (int *)(p - 8);
    if (h[1] != ((int)p ^ 0x3a1c0de5) && h[1] != ((int)p ^ 0x0f4eeb10)) return 0;
    return h;
}

char *malloc(int n) {
    char *p;
    char *prev;
    int  *h;
    int   need;
    if (n == 0) n = 1;
    if (n < 0 || n > 0x7ffffff0) rt_fatal("out of memory");
    need = (n + 7) & -8;
    prev = 0;
    p = free_head;
    while (p) {
        h = (int *)(p - 8);
        if (h[0] >= need) {
            if (prev) *(int *)prev = *(int *)p;
            else free_head = (char *)*(int *)p;
            h[1] = (int)p ^ 0x3a1c0de5;
            return p;
        }
        prev = p;
        p = (char *)*(int *)p;
    }
    p = sys_sbrk(need + 8);
    if ((int)p == 0 || (int)p == -1) rt_fatal("out of memory");
    if (heap_lo == 0) heap_lo = p;
    heap_hi = p + need + 8;
    h = (int *)p;
    h[0] = need;
    h[1] = ((int)p + 8) ^ 0x3a1c0de5;
    return p + 8;
}

void free(char *p) {
    int  *h;
    char *q;
    char *prev;
    if (p == 0) return;
    h = heap_header(p);
    if (h == 0) rt_fatal("free() of a bad pointer");
    if (h[1] == ((int)p ^ 0x0f4eeb10)) rt_fatal("double free");
    h[1] = (int)p ^ 0x0f4eeb10;
    prev = 0;
    q = free_head;
    while (q && (int)q < (int)p) {
        prev = q;
        q = (char *)*(int *)q;
    }
    *(int *)p = (int)q;
    if (prev) *(int *)prev = (int)p;
    else free_head = p;
}

/* calloc: n*size bytes (32-bit product, as irsim), zeroed. */
char *calloc(int n, int size) {
    char *p;
    n = n * size;
    p = malloc(n);
    if (n > 0) bzero(p, n);
    return p;
}

/* realloc: the same block if it is already big enough, else a new block
   with the old block's whole contents, and the old one freed. */
char *realloc(char *p, int n) {
    int  *h;
    char *q;
    if (p == 0) return malloc(n);
    h = heap_header(p);
    if (h == 0) rt_fatal("realloc() of a bad pointer");
    if (n >= 0 && h[0] >= n) return p;
    q = malloc(n);
    memmove(q, p, h[0]);
    free(p);
    return q;
}

/* ---------------------------------------------------------------------
 * Strings and memory.
 */
char *strcpy(char *d, char *s) {
    int i;
    i = 0;
    while ((d[i] = s[i]) != 0) i++;
    return d;
}

char *strncpy(char *d, char *s, int n) {
    int i;
    i = 0;
    while (i < n) {
        d[i] = s[i];
        if (s[i] == 0) break;
        i++;
    }
    while (i < n) { d[i] = 0; i++; }
    return d;
}

char *strcat(char *d, char *s) {
    strcpy(d + strlen(d), s);
    return d;
}

/* strcmp and strncmp compare unsigned characters and return -1, 0 or 1
   (irsim normalises the host's result the same way); a negative n is
   huge (size_t). */
int strncmp(char *a, char *b, int n) {
    int i, x, y;
    i = 0;
    while (n < 0 || i < n) {
        x = a[i] & 0xff;
        y = b[i] & 0xff;
        if (x != y) return x < y ? -1 : 1;
        if (x == 0) return 0;
        i++;
    }
    return 0;
}

int strcmp(char *a, char *b) {
    return strncmp(a, b, -1);
}

char *strchr(char *s, int c) {
    int i, x;
    c = c & 0xff;
    i = 0;
    while (1) {
        x = s[i] & 0xff;
        if (x == c) return s + i;
        if (x == 0) return 0;
        i++;
    }
    return 0;
}

char *memset(char *p, int v, int n) {
    int i;
    for (i = 0; i < n; i++) p[i] = v;
    return p;
}

char *memcpy(char *d, char *s, int n) {
    if (n > 0) memmove(d, s, n);
    return d;
}

int abs(int v) {
    if (v < 0) return -v;
    return v;
}
