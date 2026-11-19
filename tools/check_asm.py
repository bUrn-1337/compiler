#!/usr/bin/env python3
"""tools/check_asm.py -- static checker for the MIPS assembly mipscc writes.

    tools/check_asm.py [-v] [FILE.s...]

With no FILEs, compiles every test/*.c at -O0 and at -O1 with build/mipscc
into build/asmcheck/ and checks the results.  Each file is checked for:

  header     it starts with the comment naming the simulator, the run command
             and the assumptions (MIPS-DESIGN.md section 1);
  labels     every label is defined exactly once;
  targets    every branch/jump target, `la' symbol and `.word' symbol is
             defined in the file (the runtime is linked in, so nothing may be
             left external);
  immediates 16-bit fields hold values that fit: load/store offsets and
             addiu/slti/sltiu immediates in -32768..32767, andi/ori/xori in
             0..65535, shift amounts in 0..31 (frames over 32 KB must use a
             computed address, never a large offset);
  functions  walking each function's instructions in order:
             - $sp moves only by known amounts (addiu, or addu/subu of a
               register just loaded with li, or move $sp,$fp), and every
               label is reached with the same $sp offset by every branch to
               it and by falling through;
             - at every jal/jalr, $sp is 8-byte aligned (entry is aligned by
               the convention; `main' realigns it) and the 16-byte home area
               is reserved (offset <= -16);
             - at every jr $ra, $sp is back at its entry value and $ra, $fp,
               $s0-$s7 and $f20-$f31 hold their entry values: each one the
               function writes was saved before the first write and reloaded
               from the same slot;
             - a function does not fall through into the next one.

The function walk is linear: a label's $sp offset is the fall-through one,
or after an unconditional jump the one recorded by the first branch to it.
This is exact for the code mipscc generates, where $sp changes only in the
prologue and epilogue and every return goes through one epilogue.

Exits 1 if any file has a violation; prints one line per violation as
file:line: message.  -v also prints a summary line per file.
"""
import glob
import os
import re
import subprocess
import sys

CALLEE_SAVED = (['$s%d' % i for i in range(8)] +
                ['$f%d' % i for i in range(20, 32)] + ['$fp', '$ra'])
BRANCH1 = {'b', 'j', 'bc1t', 'bc1f'}                     # target is operand 1
BRANCH2 = {'beqz', 'bnez', 'bgtz', 'blez', 'bltz', 'bgez'}  # operand 2
BRANCH3 = {'beq', 'bne', 'blt', 'ble', 'bgt', 'bge',
           'bltu', 'bleu', 'bgtu', 'bgeu'}               # operand 3
UNCOND = {'b', 'j', 'jr'}
NO_DEST = {'sw', 'sb', 'sh', 'swc1', 'sdc1', 's.s', 's.d', 'jr', 'jal', 'jalr',
           'syscall', 'mult', 'multu', 'nop', 'break', 'bc1t', 'bc1f'} | BRANCH1 | BRANCH2 | BRANCH3
MEM_OPS = {'lw', 'sw', 'lb', 'lbu', 'sb', 'lh', 'lhu', 'sh',
           'lwc1', 'swc1', 'ldc1', 'sdc1', 'l.s', 's.s', 'l.d', 's.d'}
SIGNED16 = {'addiu', 'addi', 'slti', 'sltiu'}
UNSIGNED16 = {'andi', 'ori', 'xori'}
SHIFTS = {'sll', 'srl', 'sra'}
LABEL_RE = re.compile(r'^([A-Za-z_.$][\w.$]*):(.*)$')
MEM_RE = re.compile(r'^(-?\d+)?\((\$\w+)\)$')
HEADER_WORDS = ('Simulator', 'Run', 'Assumes')


def strip_comment(line):
    """Removes a # comment, leaving # inside a string literal alone."""
    q = False
    for i, c in enumerate(line):
        if c == '"' and (i == 0 or line[i - 1] != '\\'):
            q = not q
        elif c == '#' and not q:
            return line[:i]
    return line


def parse(path):
    """Returns a list of (lineno, label_or_None, mnemonic, operands, section)."""
    out = []
    section = '.text'
    for no, raw in enumerate(open(path, encoding='utf-8', errors='replace'), 1):
        s = strip_comment(raw).strip()
        while s:
            m = LABEL_RE.match(s)
            if m and not s.startswith('.'):
                out.append((no, m.group(1), None, [], section))
                s = m.group(2).strip()
                continue
            if m and s.startswith('.') and ':' in s.split()[0]:
                out.append((no, m.group(1), None, [], section))
                s = m.group(2).strip()
                continue
            parts = s.split(None, 1)
            mn = parts[0]
            ops = []
            if len(parts) > 1 and not mn.startswith(('.asciiz', '.ascii')):
                ops = [o.strip() for o in parts[1].split(',')]
            if mn in ('.text', '.data', '.rdata', '.kdata', '.ktext'):
                section = mn
            out.append((no, None, mn, ops, section))
            break
    return out


def dests(mn, ops):
    """The registers an instruction writes."""
    if mn in ('jal', 'jalr'):
        return ['$ra']
    if mn.startswith('.') or mn in NO_DEST or mn.startswith('c.') or not ops:
        return []
    if mn in ('div', 'divu') and len(ops) == 2:
        return []
    if mn in ('mtc1', 'mtc1.d'):
        d = ops[1]
    else:
        d = ops[0]
    if not d.startswith('$'):
        return []
    regs = [d]
    parts = mn.split('.')
    if d.startswith('$f') and (mn in ('ldc1', 'l.d') or (len(parts) > 1 and parts[1] == 'd')):
        regs.append('$f%d' % (int(d[2:]) + 1))
    return regs


def imm(text):
    try:
        return int(text, 0)
    except ValueError:
        return None


class Checker:
    def __init__(self, path):
        self.path = path
        self.errors = []
        self.items = parse(path)

    def err(self, no, msg):
        self.errors.append('%s:%d: %s' % (self.path, no, msg))

    def run(self):
        self.check_header()
        self.check_symbols()
        self.check_immediates()
        self.check_functions()
        return self.errors

    def check_header(self):
        head = []
        for ln in open(self.path, encoding='utf-8', errors='replace'):
            if not ln.startswith('#'):
                break
            head.append(ln)
        text = ''.join(head)
        for w in HEADER_WORDS:
            if not re.search(r'^#\s*' + w + r'\s*:', text, re.M):
                self.err(1, "header comment has no '%s :' line" % w)

    def check_symbols(self):
        defined = {}
        for no, lab, mn, ops, sec in self.items:
            if lab is None:
                continue
            if lab in defined:
                self.err(no, "label '%s' already defined on line %d" % (lab, defined[lab]))
            else:
                defined[lab] = no
        for no, lab, mn, ops, sec in self.items:
            if mn is None:
                continue
            want = []
            if mn in BRANCH1 or mn == 'jal':
                want = ops[:1]
            elif mn in BRANCH2:
                want = ops[1:2]
            elif mn in BRANCH3:
                want = ops[2:3]
            elif mn == 'la' and len(ops) == 2 and not MEM_RE.match(ops[1]):
                want = [ops[1]]
            elif mn == '.word':
                want = [o for o in ops if imm(o) is None]
            for t in want:
                sym = re.split(r'[+-]', t)[0]
                if sym and sym not in defined:
                    self.err(no, "%s refers to undefined symbol '%s'" % (mn, sym))

    def check_immediates(self):
        for no, lab, mn, ops, sec in self.items:
            if mn is None:
                continue
            if mn in MEM_OPS and len(ops) == 2:
                m = MEM_RE.match(ops[1])
                if m and m.group(1) and not -32768 <= int(m.group(1)) <= 32767:
                    self.err(no, '%s offset %s does not fit 16 bits' % (mn, m.group(1)))
            elif mn in SIGNED16 and len(ops) == 3:
                v = imm(ops[2])
                if v is not None and not -32768 <= v <= 32767:
                    self.err(no, '%s immediate %d does not fit 16 bits' % (mn, v))
            elif mn in UNSIGNED16 and len(ops) == 3:
                v = imm(ops[2])
                if v is not None and not 0 <= v <= 65535:
                    self.err(no, '%s immediate %d is not an unsigned 16-bit value' % (mn, v))
            elif mn in SHIFTS and len(ops) == 3:
                v = imm(ops[2])
                if v is not None and not 0 <= v <= 31:
                    self.err(no, '%s shift amount %d is out of range' % (mn, v))

    def check_functions(self):
        """Splits the text section into functions (a label without '.' starts
        one) and walks each."""
        funcs = []
        cur = None
        for it in self.items:
            no, lab, mn, ops, sec = it
            if sec != '.text':
                continue
            if lab is not None and '.' not in lab:
                cur = [lab, no, []]
                funcs.append(cur)
            if cur is not None:
                cur[2].append(it)
        for name, no, body in funcs:
            self.walk(name, no, body)

    def walk(self, name, start, body):
        """Follows one function's instructions in order (see the module
        comment): tracks the $sp offset from entry, the slots callee-saved
        registers were saved in and whether each still holds its entry
        value, and the li constants in temporaries (for big-frame $sp
        arithmetic)."""
        delta = 0               # $sp - entry $sp, or None once unknown
        fp_delta = None         # $fp - entry $sp
        slot = {}               # callee-saved reg -> entry-relative save slot
        dirty = set()           # callee-saved regs not holding entry value
        consts = {}             # register -> value from li
        at_label = {}           # label -> $sp offset there
        branches = []           # (lineno, target, delta)
        after_uncond = False
        last = None

        def addr(no, op):
            m = MEM_RE.match(op)
            if not m:
                return None
            off = int(m.group(1) or 0)
            if m.group(2) == '$sp' and delta is not None:
                return delta + off
            if m.group(2) == '$fp' and fp_delta is not None and '$fp' in dirty:
                return fp_delta + off
            return None

        for no, lab, mn, ops, sec in body:
            if lab is not None:
                if lab in at_label:
                    continue
                if after_uncond:
                    known = [d for (_, t, d) in branches if t == lab]
                    delta = known[0] if known else delta
                at_label[lab] = delta
                after_uncond = False
                continue
            if mn.startswith('.'):
                continue
            last = (no, mn, ops)
            after_uncond = False

            # $sp arithmetic
            if ops and ops[0] == '$sp' and mn not in NO_DEST:
                if mn == 'addiu' and ops[1] == '$sp' and imm(ops[2]) is not None:
                    delta = None if delta is None else delta + imm(ops[2])
                elif mn in ('addu', 'subu') and ops[1] == '$sp' and ops[2] in consts:
                    k = consts[ops[2]] * (1 if mn == 'addu' else -1)
                    delta = None if delta is None else delta + k
                elif mn == 'move' and ops[1] == '$fp' and fp_delta is not None:
                    delta = fp_delta
                elif mn == 'and' and ops[1] == '$sp' and name == 'main':
                    delta = 0       # spim's __start leaves $sp 4-aligned
                else:
                    self.err(no, '%s: untracked change of $sp' % name)
                    delta = None
                continue

            # saves of callee-saved registers
            if mn in ('sw', 'swc1', 'sdc1', 's.d', 's.s') and ops[0] in CALLEE_SAVED:
                regs = [ops[0]]
                if mn in ('sdc1', 's.d'):
                    regs.append('$f%d' % (int(ops[0][2:]) + 1))
                a = addr(no, ops[1])
                for r in regs:
                    if r not in dirty and r not in slot and a is not None:
                        slot[r] = a + 4 * regs.index(r)
                continue

            if mn in ('jal', 'jalr'):
                if delta is None:
                    self.err(no, '%s: call with unknown $sp offset' % name)
                else:
                    if delta % 8:
                        self.err(no, '%s: call with $sp not 8-byte aligned (entry%+d)' % (name, delta))
                    if delta > -16:
                        self.err(no, '%s: call without a 16-byte home area (entry%+d)' % (name, delta))
                # an unsaved $ra is reported at the jr $ra (main's stub
                # never returns, so it need not save it)
                dirty.add('$ra')
                for r in ('$v0', '$v1', '$a0', '$a1', '$a2', '$a3') + tuple('$t%d' % i for i in range(10)):
                    consts.pop(r, None)
                continue

            if mn == 'jr':
                after_uncond = True
                if ops and ops[0] == '$ra':
                    if delta != 0:
                        self.err(no, '%s: returns with $sp at entry%s' %
                                 (name, '?' if delta is None else '%+d' % delta))
                    for r in sorted(dirty):
                        self.err(no, '%s: returns without restoring %s' % (name, r))
                continue

            if mn in BRANCH1 | BRANCH2 | BRANCH3:
                t = {1: 0, 2: 1, 3: 2}[1 if mn in BRANCH1 else 2 if mn in BRANCH2 else 3]
                if t < len(ops):
                    branches.append((no, ops[t], delta))
                if mn in UNCOND:
                    after_uncond = True
                continue

            if mn == 'syscall':
                v = consts.get('$v0')
                if v in (10, 17):
                    after_uncond = True
                continue

            ds = dests(mn, ops)
            for d in ds:
                consts.pop(d, None)
                if d not in CALLEE_SAVED:
                    continue
                if mn in ('lw', 'lwc1', 'ldc1', 'l.d', 'l.s') and d in slot:
                    a = addr(no, ops[1])
                    if d == '$fp' and a is None and MEM_RE.match(ops[1]):
                        m = MEM_RE.match(ops[1])
                        if m.group(2) == '$sp' and delta is not None:
                            a = delta + int(m.group(1) or 0)
                    want = slot[d]
                    if len(ds) == 2 and d == ds[1]:
                        a = None if a is None else a + 4
                    if a == want:
                        dirty.discard(d)
                        continue
                if d not in slot:
                    self.err(no, '%s: writes %s before saving it' % (name, d))
                    slot[d] = None
                dirty.add(d)
                if d == '$fp' and mn == 'move' and ops[1] == '$sp':
                    fp_delta = delta
            if mn == 'li' and len(ops) == 2 and imm(ops[1]) is not None:
                consts[ops[0]] = imm(ops[1])

        for no, t, d in branches:
            if t in at_label and d is not None and at_label[t] is not None and d != at_label[t]:
                self.err(no, '%s: branch to %s with $sp at entry%+d, but it is entry%+d there'
                         % (name, t, d, at_label[t]))
        if last is not None and not after_uncond:
            self.err(last[0], '%s: falls through past its last instruction' % name)


def compile_tests(root):
    exe = os.path.join(root, 'build', 'mipscc')
    outdir = os.path.join(root, 'build', 'asmcheck')
    os.makedirs(outdir, exist_ok=True)
    files = []
    for src in sorted(glob.glob(os.path.join(root, 'test', '*.c'))):
        n = os.path.splitext(os.path.basename(src))[0]
        for o in ('O0', 'O1'):
            out = os.path.join(outdir, '%s.%s.s' % (n, o))
            r = subprocess.run([exe, src, '-o', out, '-' + o],
                               stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
            if r.returncode != 0:
                print('%s: mipscc -%s failed:\n%s' % (src, o, r.stdout.decode()))
                continue
            files.append(os.path.relpath(out))
    return files


def main(argv):
    verbose = '-v' in argv
    files = [a for a in argv if a != '-v']
    if not files:
        root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
        files = compile_tests(root)
    total = 0
    for f in files:
        errs = Checker(f).run()
        for e in errs:
            print(e)
        if verbose:
            print('%s: %d violation(s)' % (f, len(errs)))
        total += len(errs)
    print('%d file(s) checked, %d violation(s)' % (len(files), total))
    return 1 if total else 0


if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))
