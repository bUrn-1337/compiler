#!/usr/bin/env python3
"""tools/check_comments.py -- every function longer than 30 lines must carry
a comment.

    tools/check_comments.py [--limit N] [--list] [FILE...]

Checks the C and C++ sources of the compiler (src/*.cpp, src/*.h,
src/runtime/*.c, the C code in src/*.y and src/*.l, and tools/*.cpp) or the
FILEs given.  A function is a brace-enclosed body whose header ends in a
parameter list, at file, namespace or class scope (so member functions
defined inside a class count, and lambdas and control statements do not).
Its length is counted from the first line of the header to the closing
brace.  A function longer than the limit (default 30 lines) passes only if
a comment ends directly above its header: on the line just before it, or
before a template<...> line that precedes it.

Prints one line per violation (file:line: function NAME is N lines and has
no comment) and exits 1 if there are any; --list also prints every long
function that passes.  For bison and flex files only the C sections (the
%{ %} prologue and the code after the second %%) are checked; the grammar
actions are not functions.
"""
import glob
import os
import re
import sys

CONTROL = {'if', 'for', 'while', 'switch', 'catch', 'do', 'else', 'return',
           'sizeof', 'defined'}


def c_sections(path, text):
    """Blanks out the parts of a .y/.l file that are not C code, keeping line
    numbers: only %{ ... %} blocks and everything after the second %% stay."""
    if not path.endswith(('.y', '.l')):
        return text
    lines = text.split('\n')
    keep = [False] * len(lines)
    seps = 0
    inblock = False
    for i, ln in enumerate(lines):
        s = ln.strip()
        if seps < 2 and s == '%{':
            inblock = True
            continue
        if inblock and s == '%}':
            inblock = False
            continue
        if not inblock and s == '%%':
            seps += 1
            continue
        keep[i] = inblock or seps >= 2
    return '\n'.join(ln if k else '' for ln, k in zip(lines, keep))


def scan(text):
    """Returns (code, comment_lines): the text with comments, strings and
    character literals replaced by spaces (newlines kept), and for each line
    whether a comment starts on it / ends on it."""
    out = []
    starts, ends = set(), set()
    i, n, line = 0, len(text), 1
    while i < n:
        c = text[i]
        if text.startswith('//', i):
            starts.add(line)
            ends.add(line)
            while i < n and text[i] != '\n':
                out.append(' ')
                i += 1
            continue
        if text.startswith('/*', i):
            starts.add(line)
            j = text.find('*/', i + 2)
            j = n if j < 0 else j + 2
            for ch in text[i:j]:
                if ch == '\n':
                    line += 1
                out.append('\n' if ch == '\n' else ' ')
            ends.add(line)
            i = j
            continue
        if c in '"\'':
            q = c
            out.append(' ')
            i += 1
            while i < n and text[i] != q and text[i] != '\n':
                if text[i] == '\\':
                    out.append(' ')
                    i += 1
                out.append(' ')
                i += 1
            out.append(' ')
            i += 1
            continue
        if c == '\n':
            line += 1
        out.append(c)
        i += 1
    return ''.join(out), starts, ends


def functions(code):
    """Yields (name, header_line, open_line, close_line) for every function
    body at file, namespace or class scope."""
    stack = []          # kinds of the open braces: 'ns', 'class', 'func', 'other'
    seg_start = 0       # where the text before the next '{' begins
    line = 1
    seg_line = 1
    open_info = []      # parallel to stack: (name, header_line, open_line)
    for i, c in enumerate(code):
        if c == '\n':
            line += 1
            continue
        if c in ';{}':
            if c == '{':
                head = code[seg_start:i]
                kind, name = classify(head, stack)
                hl = seg_line + leading_newlines(head)
                stack.append(kind)
                open_info.append((name, hl, line))
            elif c == '}':
                if stack:
                    kind = stack.pop()
                    name, hl, ol = open_info.pop()
                    if kind == 'func':
                        yield name, hl, ol, line
            seg_start = i + 1
            seg_line = line
            # a ':' access label inside a class ends a segment too
        elif c == ':' and stack and stack[-1] == 'class':
            prev = code[seg_start:i].strip()
            if prev in ('public', 'private', 'protected'):
                seg_start = i + 1
                seg_line = line


def leading_newlines(s):
    k = 0
    for ch in s:
        if ch == '\n':
            k += 1
        elif not ch.isspace():
            break
    return k


def classify(head, stack):
    """Decides what the '{' after `head` opens."""
    inside = [k for k in stack if k not in ('ns', 'class')]
    h = ' '.join(' '.join(ln for ln in head.split('\n')
                          if not ln.lstrip().startswith('#')).split())
    if re.match(r'^(extern\s+"C"\s*)?namespace\b', h) or h.startswith('extern'):
        return 'ns', ''
    if inside:
        return 'other', ''
    if re.match(r'^(typedef\s+)?(class|struct|union|enum)\b[^()=]*$', h):
        return 'class', ''
    if h.endswith('=') or '=' in h.split('(')[0]:
        return 'other', ''
    # strip a constructor initializer list and trailing qualifiers
    m = re.search(r'([A-Za-z_][\w:~]*)\s*\(', h)
    if not m:
        return 'other', ''
    if not re.search(r'\)\s*(const|override|noexcept|final|\s)*(:.*)?$', h):
        return 'other', ''
    name = m.group(1)
    if name.split('::')[-1] in CONTROL:
        return 'other', ''
    # a header with several statements in it is not a declaration
    return 'func', name


def check(path, limit, listing):
    raw = open(path, encoding='utf-8', errors='replace').read()
    text = c_sections(path, raw)
    code, starts, ends = scan(text)
    lines = text.split('\n')
    bad = []
    for name, hl, ol, cl in functions(code):
        length = cl - hl + 1
        if length <= limit:
            continue
        k = hl - 1
        while k >= 1 and lines[k - 1].strip().startswith('template'):
            k -= 1
        ok = k in ends
        if ok:
            if listing:
                print(f'{path}:{hl}: ok    {name} ({length} lines)')
        else:
            bad.append(f'{path}:{hl}: function {name} is {length} lines and has no comment')
    return bad


def main(argv):
    limit = 30
    listing = False
    files = []
    k = 0
    while k < len(argv):
        if argv[k] == '--limit':
            limit = int(argv[k + 1])
            k += 2
            continue
        if argv[k] == '--list':
            listing = True
        else:
            files.append(argv[k])
        k += 1
    if not files:
        root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
        for pat in ('src/*.cpp', 'src/*.h', 'src/*.y', 'src/*.l', 'src/runtime/*.c',
                    'tools/*.cpp'):
            files += sorted(glob.glob(os.path.join(root, pat)))
        files = [os.path.relpath(f) for f in files]
    bad = []
    for f in files:
        bad += check(f, limit, listing)
    for b in bad:
        print(b)
    print(f'{len(files)} files checked, {len(bad)} violation(s) '
          f'(functions over {limit} lines without a comment)')
    return 1 if bad else 0


if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))
