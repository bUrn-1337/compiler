#!/usr/bin/env python3
"""tools/ircheck.py -- structural validity checker for the three-address IR.

A VERIFICATION TOOL, not part of the generator.  It reads only the IR text file
as specified in docs/IR-DESIGN.md and reports every violation it finds:

  * every label is defined exactly once within its function;
  * every goto / if / ifFalse target is a label defined in the same function;
  * no register is read before it has been written (parameters, and any
  *   register written on some path that reaches the read, count as written);
  * each call's argument count equals the number of immediately preceding,
    not-yet-consumed `param` instructions;
  * every function's last instruction is a `return`, and every path out of the
    body ends in one;
  * loads and stores use a width (.b .w .s .d) consistent with the operand size
    and type recorded for the slot they address, where that can be determined;
  * `addr name` names a declared slot; `addr @name` names a declared data
    object; `call @name` names a defined function or a declared extern, and
    `faddr @name` / `init.faddr @name` name a function;
  * every operation agrees with the types of the registers it touches: an
    integer operation never reads or writes a float/double register and a
    `.s`/`.d` operation never reads or writes an integer one, conversions
    relate the two register files in the direction their mnemonic states, and
    a plain copy has the same register class on both sides;
  * declared frame size covers every slot;
  * no instruction appears outside begin/end, and no duplicate function names.

Exit status is 0 when the file is valid, 1 otherwise.

    usage: ircheck.py <file.ir> [more.ir ...]
"""

import re
import sys

LABEL_RE = re.compile(r'^(\.L\d+):$')
REG_RE = re.compile(r'%([A-Za-z_.][A-Za-z0-9_.]*)')


def strip_comment(line):
    """Remove a trailing ';' comment.  Quoted ctype strings may not contain ';',
    and data byte lists are numeric, so a plain split is safe."""
    i = line.find(';')
    return line if i < 0 else line[:i]


class Func:
    def __init__(self, name, line):
        self.name = name
        self.line = line
        self.frame = 0
        self.nparams = 0
        self.rettag = 'int'
        self.sret = False
        self.declared_regs = 0
        self.params = []            # (name, 'reg'|'slot', value, tag)
        self.slots = {}             # name -> (offset, size, tag)
        self.named_regs = {}        # name -> tag
        self.body = []              # (irline, tokens, raw)
        self.labels = {}            # label -> index in body


def tokenize(s):
    """Split into tokens, keeping quoted strings whole and dropping commas."""
    out, i = [], 0
    while i < len(s):
        c = s[i]
        if c.isspace() or c == ',':
            i += 1
            continue
        if c == '"':
            j = s.find('"', i + 1)
            if j < 0:
                j = len(s)
            out.append(s[i + 1:j])
            i = j + 1
            continue
        if c == ':':
            out.append(':')
            i += 1
            continue
        j = i
        while j < len(s) and not s[j].isspace() and s[j] not in ',:':
            j += 1
        out.append(s[i:j])
        i = j
        if i < len(s) and s[i] == ':':
            out.append(':')
            i += 1
    return out


def parse(path):
    errors = []
    data = {}          # name -> (size, align)
    strings = {}       # name -> length
    externs = {}       # name -> nparams or -1 for variadic
    funcs = []
    faddr_inits = []   # (lineno, function name) from init.faddr
    cur = None
    in_body = False
    cur_data = None

    with open(path) as fh:
        for lineno, raw in enumerate(fh, 1):
            t = tokenize(strip_comment(raw))
            if not t:
                continue
            head = t[0]

            if head in ('.data', '.enddata'):
                continue
            if head == 'str':
                name = t[1].lstrip('@')
                ln = int(t[t.index('len') + 1]) if 'len' in t else 0
                nbytes = len(t[t.index('bytes') + 1:]) if 'bytes' in t else 0
                if nbytes != ln:
                    errors.append(f'{path}:{lineno}: string @{name} declares len '
                                  f'{ln} but lists {nbytes} bytes')
                strings[name] = ln
                data[name] = (ln, 1)
                continue
            if head == 'global':
                cur_data = t[1].lstrip('@')
                size = int(t[t.index('size') + 1]) if 'size' in t else 0
                align = int(t[t.index('align') + 1]) if 'align' in t else 1
                data[cur_data] = (size, align)
                data[cur_data + '#filled'] = 0
                continue
            if head.startswith('init.'):
                if cur_data is None:
                    errors.append(f'{path}:{lineno}: initializer outside any global')
                    continue
                w = {'init.byte': 1, 'init.word': 4, 'init.addr': 4,
                     'init.faddr': 4, 'init.float': 4, 'init.double': 8}.get(head)
                if w is None and head == 'init.zero':
                    w = int(t[1])
                elif w is None:
                    errors.append(f'{path}:{lineno}: unknown directive {head}')
                    continue
                if head == 'init.faddr':
                    faddr_inits.append((lineno, t[1].lstrip('@')))
                data[cur_data + '#filled'] += w
                continue
            if head == 'extern':
                name = t[1].lstrip('@')
                n = int(t[t.index('nparams') + 1]) if 'nparams' in t else 0
                externs[name] = -1 if 'variadic' in t else n
                continue

            if head == 'func':
                cur = Func(t[1].lstrip('@'), lineno)
                cur.sret = 'sret' in t
                for k, v in zip(t, t[1:]):
                    if k == 'ret':
                        cur.rettag = v
                    elif k == 'nparams':
                        cur.nparams = int(v)
                    elif k == 'frame':
                        cur.frame = int(v)
                    elif k == 'regs':
                        cur.declared_regs = int(v)
                funcs.append(cur)
                in_body = False
                continue
            if cur is None:
                errors.append(f'{path}:{lineno}: text outside any function: {raw.strip()!r}')
                continue

            if head == '.param':
                name = t[2]
                tag = t[t.index('type') + 1] if 'type' in t else '?'
                size = int(t[t.index('size') + 1]) if 'size' in t else 4
                if 'byval' in t:
                    # "byval slot O from reg %p": the incoming value is the
                    # caller's address, in %p; the object itself lives in slot O.
                    off = int(t[t.index('slot') + 1]) if 'slot' in t else 0
                    r = t[t.index('reg') + 1].lstrip('%') if 'reg' in t else None
                    cur.params.append((name, 'byval', r, tag))
                    cur.slots[name] = (off, size, tag)
                    if r is not None:
                        cur.named_regs[r] = 'ptr'
                    else:
                        errors.append(f'{path}:{lineno}: byval parameter {name} '
                                      f'names no incoming register')
                elif 'slot' in t:
                    off = int(t[t.index('slot') + 1])
                    cur.params.append((name, 'slot', off, tag))
                    cur.slots[name] = (off, size, tag)
                elif 'reg' in t:
                    r = t[t.index('reg') + 1].lstrip('%')
                    cur.params.append((name, 'reg', r, tag))
                    cur.named_regs[r] = tag
                else:
                    errors.append(f'{path}:{lineno}: parameter {name} has no storage')
                continue
            if head == '.local':
                off = int(t[t.index('slot') + 1]) if 'slot' in t else 0
                size = int(t[t.index('size') + 1]) if 'size' in t else 0
                tag = t[t.index('type') + 1] if 'type' in t else '?'
                cur.slots[t[1]] = (off, size, tag)
                continue
            if head == '.reg':
                tag = t[t.index('type') + 1] if 'type' in t else '?'
                cur.named_regs[t[1].lstrip('%')] = tag
                continue
            if head == 'begin':
                in_body = True
                continue
            if head == 'end':
                in_body = False
                cur = None
                continue
            if not in_body:
                errors.append(f'{path}:{lineno}: stray line outside begin/end: {raw.strip()!r}')
                continue

            m = LABEL_RE.match(raw.strip().split(';')[0].strip())
            if m or (len(t) >= 2 and t[1] == ':'):
                lab = t[0]
                if lab in cur.labels:
                    errors.append(f'{path}:{lineno}: label {lab} redefined in @{cur.name}')
                cur.labels[lab] = len(cur.body)
            cur.body.append((lineno, t, raw.rstrip('\n')))

    return errors, data, strings, externs, funcs, faddr_inits


def check(path):
    errors, data, strings, externs, funcs, faddr_inits = parse(path)

    seen = set()
    for f in funcs:
        if f.name in seen:
            errors.append(f'{path}:{f.line}: function @{f.name} defined twice')
        seen.add(f.name)
    defined = seen | set(externs)

    for lineno, nm in faddr_inits:
        if nm not in defined:
            errors.append(f'{path}:{lineno}: init.faddr @{nm}, which is neither '
                          f'a defined function nor a declared extern')

    for name in data:
        if name.endswith('#filled'):
            base = name[:-len('#filled')]
            size, _ = data[base]
            if data[name] > size:
                errors.append(f'{path}: global @{base} initializers cover '
                              f'{data[name]} bytes but the object is {size}')

    for f in funcs:
        prefix = f'{path}: @{f.name}'

        if len(f.params) != f.nparams:
            errors.append(f'{prefix}: header says nparams {f.nparams} but '
                          f'{len(f.params)} .param directives were given')

        for nm, (off, size, _tag) in f.slots.items():
            if off < 0 or off + size > f.frame:
                errors.append(f'{prefix}: slot {nm} occupies [{off},{off + size}) '
                              f'which does not fit the declared frame of {f.frame}')

        # ---- labels and jumps ----
        for lineno, t, raw in f.body:
            if t[0] in ('goto', 'if', 'ifFalse'):
                tgt = t[-1]
                if tgt not in f.labels:
                    errors.append(f'{path}:{lineno}: jump to undefined label '
                                  f'{tgt} in @{f.name}')

        # ---- definite assignment, flow sensitive over a simple worklist ----
        # written[i] = set of registers known written on entry to body[i]
        n = len(f.body)
        entry = set()
        for nm, kind, val, _tag in f.params:
            if kind in ('reg', 'byval') and val is not None:
                entry.add(val)

        state = [None] * n
        if n:
            state[0] = set(entry)
        work = [0] if n else []

        def succs(i, t):
            op = t[0]
            if op == 'goto':
                return [f.labels[t[-1]]] if t[-1] in f.labels else []
            if op == 'return':
                return []
            if op in ('if', 'ifFalse'):
                nxt = [i + 1] if i + 1 < n else []
                if t[-1] in f.labels:
                    nxt.append(f.labels[t[-1]])
                return nxt
            return [i + 1] if i + 1 < n else []

        def defined_reg(t):
            if len(t) >= 2 and t[0].startswith('%') and t[1] == '=':
                return t[0][1:]
            return None

        def used_regs(t):
            d = defined_reg(t)
            txt = ' '.join(t[2:]) if d else ' '.join(t)
            return [m for m in REG_RE.findall(txt)]

        bad_use = []
        while work:
            i = work.pop()
            cur = state[i]
            if cur is None:
                continue
            lineno, t, raw = f.body[i]
            for r in used_regs(t):
                if r not in cur:
                    bad_use.append((lineno, r, raw.strip()))
            out = cur
            d = defined_reg(t)
            if d:
                out = cur | {d}
            for s in succs(i, t):
                if state[s] is None:
                    state[s] = set(out)
                    work.append(s)
                else:
                    merged = state[s] & out
                    if merged != state[s]:
                        state[s] = merged
                        work.append(s)

        for lineno, r, raw in sorted(set(bad_use)):
            errors.append(f'{path}:{lineno}: register %{r} is read before it is '
                          f'written on some path into @{f.name}: {raw}')

        # ---- param / call pairing ----
        pending = 0
        for lineno, t, raw in f.body:
            if t[0] == 'param':
                pending += 1
                continue
            idx = t.index('call') if 'call' in t else -1
            if idx >= 0:
                nargs = int(t[idx + 2])
                target = t[idx + 1]
                indirect = target.startswith('%')
                callee = target if indirect else target.lstrip('@')
                # An indirect call names no symbol: its callee is only known at
                # run time, so only the argument count can be checked here.
                if not indirect and callee not in defined:
                    errors.append(f'{path}:{lineno}: call to @{callee}, which is '
                                  f'neither defined nor declared extern')
                if nargs > pending:
                    errors.append(f'{path}:{lineno}: call {callee}, {nargs} but only '
                                  f'{pending} param instruction(s) are pending')
                    pending = 0
                else:
                    pending -= nargs
                continue
            if t[0] in ('goto', 'return') or (len(t) >= 2 and t[1] == ':'):
                if pending and t[0] == 'return':
                    errors.append(f'{path}:{lineno}: {pending} param instruction(s) '
                                  f'were never consumed by a call')
                pending = 0
        if pending:
            errors.append(f'{prefix}: {pending} param instruction(s) left pending '
                          f'at the end of the function')

        # ---- slots, globals, load/store widths ----
        slot_width = {}
        for lineno, t, raw in f.body:
            if len(t) >= 4 and t[1] == '=' and t[2] == 'addr':
                nm = t[3]
                if nm.startswith('@'):
                    if nm[1:] not in data:
                        errors.append(f'{path}:{lineno}: addr of undeclared data '
                                      f'object {nm}')
                elif nm not in f.slots:
                    errors.append(f'{path}:{lineno}: addr of undeclared slot {nm}')
                else:
                    slot_width[t[0][1:]] = f.slots[nm]
            if t[0].startswith('store.') or (len(t) > 2 and t[2].startswith('load.')):
                mnem = t[0] if t[0].startswith('store.') else t[2]
                suffix = mnem.split('.')[-1]
                width = {'b': 1, 'w': 4, 's': 4, 'd': 8}.get(suffix)
                if width is None:
                    errors.append(f'{path}:{lineno}: unknown access width '
                                  f'.{suffix}: {raw.strip()}')
                    continue
                reg = (t[1] if t[0].startswith('store.') else t[3]).lstrip('%')
                if reg in slot_width:
                    off, size, tag = slot_width[reg]
                    if size and width > size:
                        errors.append(f'{path}:{lineno}: {width}-byte access to slot '
                                      f'of size {size}: {raw.strip()}')
                    # A scalar slot is accessed at exactly its own width and in
                    # its own register file; an array or aggregate slot holds
                    # elements, so only the size bound above applies to it.
                    exact = {'char': ('b',), 'int': ('w',),
                             'float': ('s',), 'double': ('d',)}.get(tag)
                    if exact and suffix not in exact:
                        errors.append(f'{path}:{lineno}: .{suffix} access to a '
                                      f'{tag} object: {raw.strip()}')

        # ---- register classes: integer-or-pointer vs float vs double ----
        # docs/IR-DESIGN.md s11.4: a register with no .reg (or .param)
        # declaration is an integer-or-pointer temporary, so an undeclared
        # name is 'int' here.  An immediate is always an integer one -- there
        # is no floating immediate in the IR.
        FLOAT_TAGS = ('float', 'double')
        SUFFIX_TAG = {'s': 'float', 'd': 'double', 'w': 'int', 'b': 'int'}
        RELOPS = ('<', '<=', '>', '>=', '==', '!=')

        def cls_of(tok):
            """'float', 'double', or 'int' for everything else."""
            if tok.startswith('%'):
                tg = f.named_regs.get(tok[1:], 'int')
                return tg if tg in FLOAT_TAGS else 'int'
            return 'int'

        def descr(c):
            return 'a floating (' + c + ') register' if c in FLOAT_TAGS \
                   else 'an integer-or-pointer register'

        def want(lineno, raw, tok, need, role):
            got = cls_of(tok)
            if got != need:
                errors.append(f'{path}:{lineno}: {role} needs {descr(need)} but '
                              f'%{tok.lstrip("%")} is {descr(got)}: {raw.strip()}')

        VALUE_DESCR = {'int': 'an integer-or-pointer',
                       'float': 'a float', 'double': 'a double'}

        def want_dst(lineno, raw, dst, need, role):
            got = cls_of('%' + dst)
            if got != need:
                errors.append(f'{path}:{lineno}: {role} produces '
                              f'{VALUE_DESCR[need]} value but %{dst} is '
                              f'{descr(got)}: {raw.strip()}')

        def split_fsuffix(op):
            """'+.d' -> ('+', 'double'); '+' -> ('+', None)."""
            if len(op) > 2 and op[-2] == '.' and op[-1] in 'sd':
                return op[:-2], SUFFIX_TAG[op[-1]]
            return op, None

        for lineno, t, raw in f.body:
            if len(t) >= 2 and t[1] == ':':
                continue
            head = t[0]

            if head.startswith('store.'):
                want(lineno, raw, t[1], 'int', f'the address operand of {head}')
                want(lineno, raw, t[2], SUFFIX_TAG.get(head.split('.')[-1], 'int'),
                     f'the value stored by {head}')
                continue
            if head == 'blkcopy':
                want(lineno, raw, t[1], 'int', 'the destination of blkcopy')
                want(lineno, raw, t[2], 'int', 'the source of blkcopy')
                size = int(t[t.index('size') + 1]) if 'size' in t else 0
                align = int(t[t.index('align') + 1]) if 'align' in t else 1
                if size <= 0:
                    errors.append(f'{path}:{lineno}: blkcopy of {size} bytes: {raw.strip()}')
                if align < 1 or (align & (align - 1)):
                    errors.append(f'{path}:{lineno}: blkcopy alignment {align} is not '
                                  f'a power of two: {raw.strip()}')
                elif size % align:
                    errors.append(f'{path}:{lineno}: blkcopy size {size} is not a '
                                  f'multiple of its alignment {align}: {raw.strip()}')
                continue
            if head == 'memzero':
                want(lineno, raw, t[1], 'int', 'the address operand of memzero')
                continue
            if head in ('if', 'ifFalse'):
                want(lineno, raw, t[1], 'int', f'the condition of {head}')
                continue
            if head == 'param':
                tag = t[3] if len(t) > 3 else 'int'
                want(lineno, raw, t[1], tag if tag in FLOAT_TAGS else 'int',
                     f'an argument declared {tag}')
                continue
            if head == 'return':
                if len(t) > 1:
                    need = f.rettag if f.rettag in FLOAT_TAGS else 'int'
                    want(lineno, raw, t[1], need,
                         f'the result of a function declared to return {f.rettag}')
                continue

            if not (len(t) >= 3 and head.startswith('%') and t[1] == '='):
                continue
            dst, k = head[1:], t[2]

            if k == 'call':
                if t[3].startswith('%'):
                    want(lineno, raw, t[3], 'int', 'the callee of an indirect call')
                continue
            if k in ('addr', 'faddr'):
                want_dst(lineno, raw, dst, 'int', k)
                continue
            if k == 'sext.b':
                want(lineno, raw, t[3], 'int', 'the operand of sext.b')
                want_dst(lineno, raw, dst, 'int', 'sext.b')
                continue
            if k.startswith('load.'):
                want(lineno, raw, t[3], 'int', f'the address operand of {k}')
                want_dst(lineno, raw, dst, SUFFIX_TAG.get(k.split('.')[-1], 'int'), k)
                continue
            if k.startswith('cvt.') or k.startswith('trunc.'):
                parts = k.split('.')
                if len(parts) != 3 or parts[1] not in SUFFIX_TAG \
                        or parts[2] not in SUFFIX_TAG:
                    errors.append(f'{path}:{lineno}: malformed conversion {k}: {raw.strip()}')
                    continue
                if parts[0] == 'trunc' and parts[1] != 'w':
                    errors.append(f'{path}:{lineno}: trunc may only produce .w: {raw.strip()}')
                    continue
                want(lineno, raw, t[3], SUFFIX_TAG[parts[2]], f'the source of {k}')
                want_dst(lineno, raw, dst, SUFFIX_TAG[parts[1]], k)
                continue
            if len(t) == 3:
                # A plain copy moves a whole register; both sides must be in
                # the same register file.
                want(lineno, raw, t[2], cls_of(head), 'the source of a copy')
                continue
            if len(t) == 4:
                base, fs = split_fsuffix(k)
                need = fs or 'int'
                want(lineno, raw, t[3], need, f'the operand of {k}')
                want_dst(lineno, raw, dst, need, k)
                continue
            if len(t) == 5:
                op = t[3]
                base, fs = split_fsuffix(op)
                need = fs or 'int'
                want(lineno, raw, t[2], need, f'the left operand of {op}')
                want(lineno, raw, t[4], need, f'the right operand of {op}')
                # A comparison's result is an int whatever it compared.
                want_dst(lineno, raw, dst, 'int' if base in RELOPS else need, op)
                continue

        # ---- every function ends in a return ----
        real = [(ln, t) for ln, t, _ in f.body if not (len(t) >= 2 and t[1] == ':')]
        if not real:
            errors.append(f'{prefix}: function body is empty (no return)')
        elif real[-1][1][0] != 'return':
            errors.append(f'{prefix}: last instruction is {real[-1][1][0]!r}, '
                          f'not a return')
        # any instruction that falls off the end of the body
        for i, (lineno, t, raw) in enumerate(f.body):
            if i + 1 == len(f.body) and t[0] not in ('return', 'goto'):
                if not (len(t) >= 2 and t[1] == ':'):
                    errors.append(f'{path}:{lineno}: control can fall off the end '
                                  f'of @{f.name}: {raw.strip()}')

    return errors


def main(argv):
    if len(argv) < 2:
        print(__doc__)
        return 2
    bad = 0
    for path in argv[1:]:
        errs = check(path)
        if errs:
            bad = 1
            for e in errs:
                print(e)
        else:
            print(f'{path}: ok')
    return bad


if __name__ == '__main__':
    sys.exit(main(sys.argv))
