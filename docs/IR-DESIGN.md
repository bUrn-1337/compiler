# IR design

This document specifies the intermediate representation emitted by `build/irgen`.
It is meant to be sufficient on its own: a MIPS code generator can be written
from this document without reading the generator's source.

Everything described here is produced by [`src/ir.cpp`](../src/ir.cpp) (the
writer) and consumed by [`tools/irsim.cpp`](../tools/irsim.cpp) (a reference
interpreter) and [`tools/ircheck.py`](../tools/ircheck.py) (a validator). Those
two tools are the executable specification: if this document and the tools ever
disagree, the tools are what the test suite checks.

---

## 1. Shape of the IR

The IR is classic three-address code.

* Every instruction has **at most one operator**. `a = b + c * d` becomes two
  instructions.
* Values live in **virtual registers**, numbered without limit. Register
  allocation is entirely the back end's problem. There are **two disjoint
  register classes**, integer-or-pointer and floating (single or double); §7
  says how a reader tells which class a register is in.
* Control flow is explicit: labels, `goto`, `if`, `ifFalse`. There are no
  nested or structured statements left, and no expression trees.
* Conditions are **jumping code**: `&&`, `||`, `!` and `?:` are already
  expanded into branches, so short-circuit evaluation is a property of the
  emitted IR, not something the back end has to re-create.
* Memory is accessed only through `load`/`store` and the two block operations
  `blkcopy`/`memzero`. An address is only ever produced by `addr` (a slot or a
  data symbol), `faddr` (a function), or integer arithmetic on one of those.
* A struct or union value is **always represented by an address**: there is no
  instruction that puts an aggregate in a register, and `blkcopy` is the only
  way one is ever copied.
* The file is plain text, one instruction per line, and is designed to be
  parsed with "split the line on whitespace".

## 2. Target model

| property | value |
|---|---|
| `char` | 1 byte, **signed** |
| `int` | 4 bytes, signed, two's complement |
| `enum` | 4 bytes, same as `int` |
| `float` | 4 bytes, IEEE 754 single, 4-byte aligned |
| `double` | 8 bytes, IEEE 754 double, **8-byte aligned** |
| pointer (any) | 4 bytes; a function pointer is a pointer like any other |
| `struct` | sum of members, each member aligned to its own alignment, total size rounded up to the largest member alignment |
| `union` | every member at offset 0, size = largest member (rounded up to its alignment) |
| array | `n * sizeof(element)`, alignment = element alignment |
| stack alignment | frames are a multiple of 8 bytes |
| byte order | nothing in the IR depends on it; the interpreter is little-endian because the host is |

All of this is computed in exactly one place, `typeSize` / `typeAlign` /
`layoutTag` in [`src/ast.cpp`](../src/ast.cpp). Nothing else in the compiler
contains a hard-coded size.

There are no unsigned types in the source language (see §13), so **every
*unsuffixed* arithmetic, shift and comparison operator in the IR is the signed
32-bit integer one**. `>>` is an arithmetic shift. `/` and `%` truncate toward
zero, and `%` takes the sign of the left operand — i.e. MIPS `div`/`mfhi`
semantics, not Euclidean.

Floating-point operations are marked by a `.s` (single) or `.d` (double)
suffix on the mnemonic — `+.d`, `<.s`, `load.d`, `cvt.d.w` — and are never
mixed with the integer ones in the same instruction. The two kinds of value
live in **two disjoint register classes**: a register is integer-or-pointer, or
single, or double, for its whole life, and §7 says how a reader tells which.
Floating arithmetic is IEEE 754 with the default rounding mode
(round-to-nearest-even), which is what both MIPS and the host do, so the
interpreter's results are bit-identical to the reference compiler's.
Floating-point to integer conversion **truncates toward zero** (C's rule), which
is why the mnemonic is `trunc.w.d` and not `cvt.w.d`.

## 3. File structure

```
; comment lines ...

.data
  <string literals and globals>
.enddata

extern @printf ret int nparams 1 variadic
extern ...

func @name ret <tag> retctype "<C type>" [retsize S retalign A sret] \
     nparams N frame F regs R temps T   ; line L
  .param 0 <name> : type <tag> ctype "<C type>" size S align A \
      (reg %r | slot O | byval slot O from reg %r) [sret]
  .local <name> : type <tag> ctype "<C type>" size S align A slot O
  .reg %<name> : type <tag> ctype "<C type>"
begin
  <instructions>
end

func ... (one block per function, in source order)
```

Lexical rules:

* A `;` starts a comment that runs to end of line. Comments carry source line
  numbers (`; line 42`) and the readable form of string literals; they are
  never semantically meaningful.
* Tokens are separated by whitespace, except that a quoted `"..."` string
  (the `ctype` fields) is one token and may contain spaces.
* Blank lines are ignored.
* The order of sections is fixed: comments, `.data`, `extern`s, functions.

## 4. Operands and sigils

Every operand is one of four things, and the **first character tells you
which**:

| form | meaning |
|---|---|
| `%name` | a virtual register. `%t17` is an anonymous temporary, `%i` is a named source variable that lives in a register. |
| `@name` | a data-section symbol: a global variable, a string literal (`@.str3`), or, on a `call`, a function. Its *address* is a link-time constant. |
| `name` (bare identifier) | a **frame slot**. Appears only as the operand of `addr`. Never read or written directly. |
| `-12`, `0`, `65` (bare integer) | a 32-bit signed immediate. |
| `.L7` | a code label. Appears only as the target of `goto`/`if`/`ifFalse` and as a label definition. |

Register names are unique within a function; slot names are unique within a
function; data symbols and labels are unique within the module. A source
variable literally named `t7` is renamed `v.t7` in the IR so that it can never
collide with the temporary `%t7`.

Immediates may appear wherever a register may, on either side of a binary
operator and as the value stored by `store`. A back end that wants
register-only operands can expand them with `li` at will.

## 5. Data section

### 5.1 String literals

```
str @.str0 len 7 bytes 37,100,32,37,100,10,0    ; "%d %d\n"
```

* `len` is the number of bytes **including** the terminating zero, which is
  what `bytes` also lists.
* Escapes have already been converted to byte values by the front end; the
  trailing comment shows a readable rendering only.
* Identical literals are emitted once and shared.
* Alignment: 1 byte. The literals are read-only in practice but the IR does not
  say so, so `.data` (not `.rodata`) is a safe choice.

### 5.2 Globals

```
global @counter size 4 align 4 type int ctype "int"
  init.word 7
global @table size 48 align 4 type ptr ctype "int [3][4]"
  init.word 1
  init.word 2
  init.zero 40
global @name size 8 align 1 type str ctype "char [8]"
  init.byte 104
  ...
global @gp size 4 align 4 type ptr ctype "int *"
  init.addr @counter
global @gd size 8 align 8 type double ctype "double"
  init.double 2.5    ; 0x4004000000000000
global @gf size 4 align 4 type float ctype "float"
  init.float 1.5    ; 0x3fc00000
global @gfp size 4 align 4 type ptr ctype "int (*)(int, int)"
  init.faddr @add
```

The `init.*` lines lay the object out **sequentially from offset 0**; their
widths sum to exactly `size`.

| directive | meaning |
|---|---|
| `init.word V` | 4 bytes, signed decimal value `V` |
| `init.byte V` | 1 byte, value `V` (already truncated to 8 bits) |
| `init.zero N` | `N` zero bytes — used for padding, for tail elements of a partly initialised array, and for a whole uninitialised global |
| `init.addr @sym` | 4 bytes holding the address of data symbol `sym` |
| `init.float V` | 4 bytes, an IEEE 754 single |
| `init.double V` | 8 bytes, an IEEE 754 double |
| `init.faddr @f` | 4 bytes holding the address of **function** `f` (a function pointer's initializer) |

`init.float` / `init.double` write the value in decimal, with enough digits to
round-trip exactly (`%.9g` for a single, `%.17g` for a double), so a reader
that parses it with `strtod` reconstructs the same bits. The bit pattern is
repeated in the trailing comment for verification; the comment is not
authoritative, the decimal spelling is.

`init.addr` and `init.faddr` are distinguished because a MIPS assembler
references a data symbol and a text symbol the same way but a reader may want
to know which it has, and because `ircheck.py` checks that an `init.faddr`
names a function and an `init.addr` names a data object.

A global with no initializer gets a single `init.zero size` (C guarantees
static zero-initialisation). Struct padding is emitted explicitly as
`init.zero`, so the back end never has to know the layout rules.

### 5.3 The floating-constant pool

No IR instruction takes a floating-point immediate, because no MIPS instruction
does. Every floating constant a function needs — a literal such as `2.5`, and
also the result of converting an integer *constant* to a floating type — is
therefore interned as an ordinary unnamed global and loaded from memory:

```
global @.fc0 size 8 align 8 type double ctype "double"
  init.double 3.0    ; 0x4008000000000000
```

```
  %t5 = addr @.fc0
  %t6 = load.d %t5
```

* The names are `@.fc0`, `@.fc1`, … in order of first use, and cannot collide
  with a source identifier (a leading `.` is not valid in C).
* The pool is keyed on **(bit pattern, width)**, so two occurrences of `2.5`
  share one object, while `2.5` and `2.5f` do not (they have different widths).
* A single-precision constant is stored as `init.float` and loaded with
  `load.s`; a double with `init.double` and `load.d`.
* A back end is free to recognise the pattern `addr @.fcN` + `load.s/.d` and
  turn it into whatever its assembler prefers (`l.s`/`l.d` with a label, or a
  `lui`/`ori` pair into an integer register and `mtc1`).

## 6. Extern functions

```
extern @printf ret int nparams 1 variadic
extern @malloc ret ptr nparams 1
```

These are the library functions the program actually uses. `nparams` is the
number of **fixed** parameters; `variadic` means more may follow. The front end
knows the signature of every function in §13's list and type-checks calls
against it. The back end only needs these lines to decide which runtime symbols
to reference; it may ignore them if it links against a real libc.

## 7. Function headers

```
func @main ret int retctype "int" nparams 2 frame 80 regs 138 temps 131   ; line 15
  .param 0 argc : type int ctype "int" size 4 align 4 reg %argc
  .param 1 argv : type ptr ctype "char * *" size 4 align 4 slot 0
  .local a : type ptr ctype "int [3][4]" size 48 align 4 slot 12
  .reg %i : type int ctype "int"
begin
  ...
end
```

| field | meaning |
|---|---|
| `ret` / `retctype` | return type tag (§11) and its readable C spelling |
| `nparams` | number of parameters; matches the number of `.param` lines |
| `frame F` | **bytes of local storage this function needs**, already rounded up to a multiple of 8. This covers every `.local` and every slot-resident `.param`. It does *not* include saved registers, the return address, or any outgoing-argument area: those are the back end's choice and must be added on top. |
| `regs R` | total number of virtual registers, named plus anonymous |
| `temps T` | how many of those are anonymous temporaries |
| `retsize S retalign A sret` | present **only** for a function that returns a struct or union by value. The result is `S` bytes with alignment `A`, and the function takes a hidden extra parameter 0 that points at the caller's destination (§9.2). |

`.param i name : ...` — parameter `i`, 0-based, left to right. The tail of the
line says where the incoming value must end up, in one of three forms:

| form | meaning |
|---|---|
| `reg %r` | the parameter arrives as a value in virtual register `%r`. A `float` parameter arrives in a single register, a `double` in a double one. |
| `slot O` | the parameter arrives as a value and must be stored at frame offset `O`. This happens when its address is taken somewhere in the body. |
| `byval slot O from reg %r` | the parameter is a **struct or union passed by value**. The *caller's* address for it arrives in register `%r`, and the callee's prologue copies `size` bytes from there into its own frame slot at offset `O`. Every later use of the parameter reaches the slot, never `%r`, so the callee can modify its parameter without the caller seeing it (§9.1). |

A `.param` line additionally ends in `sret` for the hidden result pointer of a
struct-returning function; that parameter is always `reg`, is always parameter
0, and is named `sret.ptr`.

`.local name : ... slot O` — a frame object at byte offset `O` from the base of
the local area. Offsets are assigned densely and respect each object's
alignment. `size` and `align` are authoritative; the `type` tag on a slot is
advisory (see §11).

`.reg %name : ...` — the declaration of a virtual register, giving its type tag
and C type. Two rules govern which registers get a line:

* **Every named register is declared** — that is, every source variable that
  lives purely in a register because its address is never taken, and every
  register-resident parameter (which therefore appears twice in the header,
  once as `.param` saying where the value arrives and once as `.reg` declaring
  the register).
* **An anonymous temporary is declared if and only if it holds a floating
  value.** Its register class (`$f0`… rather than `$t0`…) and its width cannot
  be recovered from the instructions alone, because `load.s` and `load.w` both
  move four bytes. So the rule a reader may rely on, and which `ircheck.py`
  enforces, is:

  > **a register with no `.reg` line is an integer-or-pointer temporary.**

  Equivalently: a register's class is `float` or `double` exactly when a `.reg`
  line says so.

Shadowed names are made unique: an inner `x` that shadows an outer `x` appears
as `x.1`, `x.2`, and so on.

## 8. Instruction set

There are 19 instruction forms. In the table below, `d` is always a register
(`%...`), `a` and `b` are any operand from §4, `L` is a label, `S` is a byte
count and `tag` is a type tag.

Several mnemonics carry a **type suffix**: `.w` (4-byte integer or pointer),
`.b` (1 byte), `.s` (single), `.d` (double). The suffix is part of the
mnemonic, never optional where it is shown.

### 8.1 Label definition

```
.L7:
```
Defines `.L7` at this point. Appears at the start of a line with no
indentation. Every label is defined exactly once per module and every jump
target is defined somewhere in the same function.

### 8.2 Copy

```
%d = a
```
`d := a`. Used for assignment between register-resident variables, for
materialising constants, and for pinning a value that a later store would
otherwise clobber.

Both sides always have the **same register class**: a copy never converts.
A copy between floating registers is a `mov.s`/`mov.d`; `a` is an immediate
only when `d` is an integer register, because there are no floating immediates
(§5.3).

MIPS: `move`, `li`, `mov.s`, `mov.d`.

### 8.3 Binary operation

```
%d = a <op> b
```

`op` is one of:

| group | operators | notes |
|---|---|---|
| arithmetic | `+` `-` `*` `/` `%` | signed; `/` truncates toward zero, `%` takes the sign of `a` |
| bitwise | `&` `\|` `^` | |
| shift | `<<` `>>` | `>>` is **arithmetic** (sign-propagating); shift counts are already masked to 0–31 by the source program's own semantics, the back end may rely on MIPS's own masking |
| relational | `<` `<=` `>` `>=` `==` `!=` | result is exactly `0` or `1` in the low bit, zero-extended |
| floating arithmetic | `+.s` `-.s` `*.s` `/.s` `+.d` `-.d` `*.d` `/.d` | IEEE 754, round-to-nearest-even. There is **no `%.s`/`%.d`**: `%` on a floating operand is a semantic error in the source language. |
| floating relational | `<.s` `<=.s` `>.s` `>=.s` `==.s` `!=.s` and the `.d` six | **both operands are floating, the result is an ordinary integer `0` or `1`** — this is the one instruction form that crosses the two register classes, and it crosses it in only this direction |

For a floating operator, both operands have already been brought to the
suffix's type by the front end: `+.d` never sees a single operand, and an
expression mixing `float` and `double` carries an explicit `cvt.d.s` first. The
usual arithmetic conversions are therefore entirely a front-end matter.

There is no separate pointer arithmetic: the front end has already multiplied
indices by the element size and divided pointer differences, so `+`, `-`, `*`
and `/` on addresses are plain integer operations. The scale factor for a
`float *` is 4 and for a `double *` is 8, like any other element size.

MIPS: `addu`/`subu`/`mul`/`div`+`mflo`/`div`+`mfhi`, `and`/`or`/`xor`,
`sll`/`sra` (or their variable forms), and `slt`-based sequences for the six
integer comparisons; `add.s`/`add.d`/`sub.`/`mul.`/`div.` for the floating
arithmetic, and a `c.lt.d`-style compare followed by `movf`/`movt` (or a branch
over two `li`s) for a floating comparison, since its result is an integer.

### 8.4 Unary operation

```
%d = - a
%d = ! a
%d = ~ a
%d = -.s a
%d = -.d a
```
Arithmetic negation, logical negation (`a == 0 ? 1 : 0`), bitwise complement,
and floating negation in the two widths. `!` is only emitted where a 0/1
*value* is wanted; in condition position the front end inverts the branch
instead. There is no `!.s`/`~.s`. A floating value used as a *condition* — in
an `if`, a loop, an operand of `&&`, `||` or `!` — is first reduced to an
integer `0`/`1` by comparing it against a `0.0` taken from the constant pool
(`%t = %v !=.d %zero`), which is exactly what C says a floating condition
means; the branch, and `!`'s inversion of it, then work on that integer.
`~` on a floating value is a semantic error.

MIPS: `subu $d,$zero,$a` / `sltiu $d,$a,1` / `nor $d,$a,$zero` /
`neg.s` / `neg.d`.

### 8.5 Sign-extend byte

```
%d = sext.b a
```
Takes the low 8 bits of `a` and sign-extends them to 32 bits. Emitted when a
`char` value is promoted to `int` without going through memory — for instance
after `c = 200`, where the value stored is truncated and the value read back
must be sign-extended.

MIPS: `sll $d,$a,24` then `sra $d,$d,24` (or `seb` where available).

Note that `load.b` **already sign-extends**, so a value read from memory never
needs `sext.b`.

### 8.6 Conversion between integer and floating

```
%d = cvt.s.w a     ; int    -> float
%d = cvt.d.w a     ; int    -> double
%d = cvt.s.d a     ; double -> float
%d = cvt.d.s a     ; float  -> double
%d = trunc.w.d a   ; double -> int, TRUNCATING toward zero
%d = trunc.w.s a   ; float  -> int, TRUNCATING toward zero
```

The mnemonics are MIPS's own, read as `<operation>.<destination>.<source>`.
These six instructions are the **only** place where a value crosses between
the integer and floating register classes in the `a`-to-`d` direction, and
`ircheck.py` checks each one's register classes against its mnemonic.

* The *source* of a conversion is converted exactly as C requires. `cvt.s.w`
  may lose precision (an `int` beyond 2²⁴); the others in that direction do
  not.
* `trunc.w.*` discards the fractional part — it does **not** round, and does
  not honour the rounding mode. Plain `cvt.w.d` would round, so it is never
  emitted.
* A conversion to `char` is a `trunc.w.d` followed by a `sext.b` (§8.5); a
  conversion of a floating value to a pointer does not exist, because it is a
  semantic error.
* An integer *constant* converted to a floating type never produces a
  conversion instruction: the front end folds it into a constant-pool entry
  (§5.3).

MIPS: `cvt.s.w`, `cvt.d.w`, `cvt.s.d`, `cvt.d.s`, `trunc.w.d`, `trunc.w.s`
(each one a single instruction, though an integer operand must first reach a
floating register through `mtc1`, and `trunc.w.*`'s integer result must come
back through `mfc1`).

### 8.7 Address of a frame slot

```
%d = addr buf
```
`d :=` the address of frame slot `buf`. This is the only way a slot is ever
reached.

MIPS: `addiu $d,$fp,<offset>` (or from `$sp`, if the back end does not keep a
frame pointer).

### 8.8 Address of a data symbol

```
%d = addr @counter
%d = addr @.str3
```
`d :=` the address of a data-section object.

MIPS: `la $d,counter`.

### 8.9 Address of a function

```
%d = faddr @add
```
`d :=` the address of the **function** `add`, as a 4-byte pointer value. This
is how a function name decays to a pointer and how `&f` is evaluated; the two
produce identical IR, because in C they are the same value.

It is a separate instruction from `addr @sym` for three reasons: the symbol
lives in the text segment rather than the data segment, so an assembler may
need a different relocation; a reader can tell a function pointer from a data
pointer without consulting the symbol table; and `ircheck.py` can verify that
`faddr` names a function and `addr @` names a data object, which catches a
whole class of generator bug. The static counterpart is `init.faddr` (§5.2).

The value is an ordinary pointer afterwards: it can be copied, stored, compared
with `==`/`!=`, passed as an argument, kept in a struct member or an array
element, and eventually used as the target of an indirect `call` (§8.17).

MIPS: `la $d,add`.

### 8.10 Load

```
%d = load.w a      ; 4 bytes into an integer register
%d = load.b a      ; 1 byte, SIGN-EXTENDED to 32 bits
%d = load.s a      ; 4 bytes into a SINGLE register
%d = load.d a      ; 8 bytes into a DOUBLE register
```
`a` is an address. The width suffix also fixes the destination's register
class: `load.w` writes an integer register and `load.s`/`load.d` a floating
one, and the two are not interchangeable even though `load.w` and `load.s`
move the same number of bytes. That is why a floating temporary is declared
with a `.reg` line (§7).

Alignment is guaranteed by the layout rules in §2: a `load.w`/`load.s` address
is 4-byte aligned and a `load.d` address is **8-byte aligned**, so a back end
may use `ldc1` (or a pair of `lwc1`) without an alignment check.

MIPS: `lw` / `lb` / `lwc1` / `ldc1`.

### 8.11 Store

```
store.w a, b       ; *(word*)a   = b
store.b a, b       ; *(byte*)a   = low 8 bits of b
store.s a, b       ; *(float*)a  = b   (b is a single register)
store.d a, b       ; *(double*)a = b   (b is a double register)
```
`a` is the address, `b` is the value — address first, in every form.
`store.b` discards the upper 24 bits, which is exactly C's truncation on
assignment to a `char`. As with `load`, the suffix fixes `b`'s register class,
and `b` may be an immediate only for `.w` and `.b`.

A `double` value assigned to a `float` object is converted first (`cvt.s.d`)
and then stored with `store.s`; `store.s` never narrows on its own.

MIPS: `sw` / `sb` / `swc1` / `sdc1`.

### 8.12 Block copy

```
blkcopy %d, %s, size 12 align 4
```
Copies exactly `size` bytes from address `%s` to address `%d`, destination
first, like `memcpy`'s argument order. `size` is always a compile-time
constant and `align` is the alignment both ends are **guaranteed** to have, so
a back end can choose its move width from the `align` field alone rather than
proving anything.

**The semantics are `memmove`, not `memcpy`: the two regions may be the same
object or may overlap, and the copy must still be correct.** This matters
because `s = s;` and `*p = *q;` with `p == q` are legal C, and the generator
does not try to prove that they cannot happen. A copy of a whole object onto
itself is the only overlap a *correct* C program can produce (two distinct
struct objects never partly overlap), so an implementation that copies forward
is already right for every well-defined program; `memmove` is specified
because it also makes the undefined cases harmless rather than silently wrong.

`blkcopy` is emitted for:

* whole-struct and whole-union assignment, including `*p = s`, `s = *p` and
  initialisation from another struct;
* array members, which are copied as part of the enclosing struct;
* the prologue copy of a `byval` struct parameter (§9.1);
* the copy of a returned struct into the caller's destination (§9.2).

Earlier revisions of this IR called this instruction `memcpy`, which collided
with the *library* function `memcpy` the source language can also call: a line
`memcpy %d, %s, 12` and a `call @memcpy, 3` meant different things and read the
same. The rename to `blkcopy` keeps the instruction set disjoint from the
runtime-function names, and the `size`/`align` keywords make the operand
meanings self-describing.

MIPS: an unrolled sequence of `lw`/`sw` when the size is small and `align` is
4 or 8, otherwise a byte loop. A size that is not a multiple of 4, or an
`align` of 1 or 2, occurs only for `char` arrays and for structs whose largest
member is a `char`.

### 8.13 Block zero

```
memzero %p, 16
```
Writes 16 zero bytes at address `%p`. Emitted for the tail of a partially
initialised local array or struct, which C requires to be zeroed even when the
initializer lists fewer elements than the object has. Unlike `blkcopy` it
takes no `align`, because a zero store can always be done byte by byte.

MIPS: `sw $zero` sequence or a loop.

### 8.14 Unconditional jump

```
goto .L4
```
MIPS: `j`/`b`.

### 8.15 Conditional jumps

```
if %t goto .L4         ; jump when %t != 0
ifFalse %t goto .L4    ; jump when %t == 0
```
The operand may be an immediate (the front end folds constant conditions, but
a constant may still survive in `for(;;)`-style code).

MIPS: `bne $t,$zero,L` / `beq $t,$zero,L`.

### 8.16 Argument

```
param %t12 : ptr
param 65 : int
param %t31 : double
param %t126 : agg size 8 align 4
param %t125 : ptr size 8 align 4 sret
```
Pushes one argument onto a conceptual argument list for the *next* `call`. The
`: tag` suffix gives the argument's type (§11) so that a back end lowering a
variadic call — `printf`, `scanf` — knows what it is passing, and so that it
knows which register class the value is in. Three forms carry more:

* `: float` / `: double` — the value is in a floating register of that width.
  A back end that passes floating arguments in `$f12`…, or that must split a
  `double` across two integer registers for a variadic call, needs this tag to
  know which arguments those are.
* `: agg size S align A` — a **struct or union passed by value**. The operand
  is the *address* of the object, and `S`/`A` say how big it is; §9.1 says who
  copies it.
* `: ptr size S align A sret` — the hidden result pointer for a call to a
  struct-returning function. It is always the first `param` of its call, and
  `S`/`A` describe the *result* object, not the pointer. See §9.2.

See §9 for the whole convention.

### 8.17 Call

```
%t13 = call @sumPoint, 1      ; direct:   the callee is a symbol
call @freeList, 1             ; direct, result unused
%t61 = call %t59, 1           ; INDIRECT: the callee is a pointer in a register
call %fp, 0                   ; indirect, result unused
```
Calls the named function, or the function at the address in the given register,
with the **last `n` `param` instructions** as its arguments, in order, and
removes them from the pending list. The `%d =` prefix is present exactly when
the result is used; a call to a non-`void` function whose result is discarded
is written without it.

**Direct and indirect calls are told apart by the sigil of the operand**: `@f`
is a symbol and the call is direct (`jal f`), `%r` is a register holding an
address and the call is indirect (`jalr $r`). The two forms are otherwise
identical — the same `param` protocol, the same result register, the same
struct and floating conventions — so a back end that lowers one lowers the
other by swapping `jal` for `jalr`.

The IR deliberately does **not** record the signature at an indirect call site:
the front end has already checked the argument count and every argument's type
against the pointer's declared prototype, so by the time the IR exists the call
is as well-typed as a direct one. What a back end needs — how many arguments
and what class each one is in — is in the `param` lines.

Every `fp(a,b)` and `(*fp)(a,b)` produce exactly the same IR, since `*` on a
function pointer yields a function, which immediately decays back to the same
pointer. A call through a struct member (`s.fn(x)`) or an array element
(`ops[i](a,b)`) is the same shape, with a `load.w` producing the register
first.

### 8.18 Return

```
return %t7
return
```
`return` with an operand in a value-returning function, without one in a `void`
function. Every function body ends with a `return` instruction, even when the
source falls off the end of the body, so the back end never needs a
fall-through epilogue. The value returned by falling off the end of a
non-`void` function is unspecified; the generator emits `return 0`.

The operand's register class follows the function's return type: an integer
register for `int`, `char`, `enum` and any pointer, a single or double register
for `float` and `double`. A function returning a struct or union by value
returns the **hidden result pointer** it was given (`return %sret.ptr`), so
that a caller may use the returned address directly; see §9.2.

## 9. Calling convention

The IR fixes the *order of evaluation* and the *ownership* of every object, and
leaves the *mechanism* — which machine register or stack slot each argument
travels in — to the back end.

0. **At an indirect call, the callee is evaluated before any argument.** So in
   `ops[i++](a, b)` the element is fetched first, and `i`'s increment cannot
   affect which function is called. (C leaves this order unspecified too.)
1. **Argument evaluation order is left to right.** All argument expressions for
   a call are evaluated — including any nested calls, with their own
   `param`/`call` sequences — before the first `param` of that call is emitted.
   A `param` is therefore never separated from its `call` by anything other
   than the other `param`s of the same call, and the pending-argument list
   behaves as a simple stack. (C leaves this order unspecified; the test suite
   avoids programs that depend on it, but the generator is deterministic.)
2. `param` instructions appear in **left-to-right parameter order**: the first
   `param` is argument 0. For a struct-returning call the hidden result
   pointer comes first, before argument 0 (§9.2).
3. Scalar arguments and return values are 32-bit words, except `float` (4
   bytes in a single register) and `double` (8 bytes in a double register).
   `char` arguments are promoted to `int` before the `param`. Arrays, and
   function names, decay to pointers.
4. The callee receives its parameters where its `.param` lines say: in a
   virtual register, at a frame slot, or — for a struct by value — as an
   address to copy from (§9.1).
5. A back end is free to map this onto `$a0`–`$a3` plus stack, O32-style; it
   needs to add its own outgoing-argument area to `frame`.

### 9.1 Struct and union arguments: the callee copies

A struct or union argument is passed **as the address of the caller's object**,
and the *callee* makes the copy. Source:

```c
struct Point { int x, y; };

struct Point shifted(struct Point p, int dx) {
    p.x = p.x + dx;        /* modifies the callee's own copy */
    return p;
}
```

The caller emits the address and tags the `param` as `agg`:

```
  %t1 = addr s
  param %t1 : agg size 8 align 4
  ...
```

and the callee declares the parameter `byval`, naming both the register the
incoming address arrives in and the slot its own copy lives at:

```
func @shifted ret agg retctype "struct Point" retsize 8 retalign 4 sret nparams 3 frame 8 regs 8 temps 5    ; line 3
  .param 0 sret.ptr : type ptr ctype "struct Point *" size 4 align 4 reg %sret.ptr sret
  .param 1 p : type agg ctype "struct Point" size 8 align 4 byval slot 0 from reg %p.ptr
  .param 2 dx : type int ctype "int" size 4 align 4 reg %dx
  .local p : type agg ctype "struct Point" size 8 align 4 slot 0
  .reg %sret.ptr : type ptr ctype "struct Point *"
  .reg %p.ptr : type ptr ctype "struct Point *"
  .reg %dx : type int ctype "int"
begin
  %t3 = addr p   ; line 4
  %t4 = addr p   ; line 4
  %t5 = load.w %t4   ; line 4
  %t6 = %t5 + %dx   ; line 4
  store.w %t3, %t6   ; line 4
  %t7 = addr p   ; line 5
  blkcopy %sret.ptr, %t7, size 8 align 4   ; line 5
  return %sret.ptr   ; line 5
end
```

**The copy is part of the prologue the back end generates; it is not an
instruction in the body.** `byval slot 0 from reg %p.ptr` is an *obligation*
on whoever lowers the function: on entry, copy `size` bytes from the address in
`%p.ptr` into frame offset 0. Nothing in `begin`…`end` performs it — the body
simply reads and writes the slot through `addr p`, exactly as it would an
ordinary local. The reference interpreter does the same thing in its own
prologue (see `byVal` in `tools/irsim.cpp`), which is what makes it the
executable statement of this rule.

Two further points follow from the listing above:

* The parameter also appears as a **`.local` with the same offset**, so a back
  end that walks `.local` lines to lay out the frame needs no special case:
  the storage is already accounted for in `frame`.
* `%p.ptr` is live only across that prologue copy; the generator never reads it
  again. A back end may reuse it immediately.

**Why callee-copies.** C says a parameter is a local object initialised from
the argument, so the callee may assign to its own parameter and the caller must
not see it — as `shifted` does above. Two conventions satisfy that: the caller
copies the object into an outgoing-argument area and passes *that* address, or
the caller passes the original address and the callee copies on entry. This IR
chooses **callee-copies**, for three reasons:

* it needs no outgoing-argument area in the caller's frame, so `frame` stays a
  property of the function's own locals and a back end can still add its own
  argument area without the two interacting;
* the obligation is stated **once per callee** rather than once per call site,
  so a function called from twenty places carries one copy in its prologue
  rather than twenty in the callers;
* it makes the callee's `.param`/`.local` pair the single source of truth about
  where the parameter lives, so every *use* of the parameter in the body is an
  ordinary slot access and nothing in the body has to know it was a parameter.

The consequences a back end must respect:

* The address passed is the *caller's* object, so the caller must keep that
  object alive across the call. It does so automatically: the object is one of
  its own locals, a global, or a compiler-created `.retN` slot (§9.2).
* An argument that is itself a returned struct (`g(f())`) needs no special
  case, because `f()`'s result already lives in a `.retN` slot of the caller's
  frame, and that slot's address is what is passed.
* A back end that *chose* to pass small structs in registers instead would
  have to synthesise the copy at every call site and may do so, but then it
  must keep the `byval` obligation for the callers it did not compile.

### 9.2 Struct and union returns: a hidden result pointer

A function returning a struct or union by value takes a **hidden extra
parameter 0**, a pointer to a destination object the caller owns. The function
writes its result there and returns the same pointer.

For `struct Point addPoints(struct Point a, struct Point b)` the callee reads
(abbreviated only where marked `...`):

```
func @addPoints ret agg retctype "struct Point" retsize 8 retalign 4 sret nparams 3 frame 24 regs 19 temps 16    ; line 50
  .param 0 sret.ptr : type ptr ctype "struct Point *" size 4 align 4 reg %sret.ptr sret
  .param 1 a : type agg ctype "struct Point" size 8 align 4 byval slot 0 from reg %a.ptr
  .param 2 b : type agg ctype "struct Point" size 8 align 4 byval slot 8 from reg %b.ptr
  .local a : type agg ctype "struct Point" size 8 align 4 slot 0
  .local b : type agg ctype "struct Point" size 8 align 4 slot 8
  .local r : type agg ctype "struct Point" size 8 align 4 slot 16
  .reg %sret.ptr : type ptr ctype "struct Point *"
  .reg %a.ptr : type ptr ctype "struct Point *"
  .reg %b.ptr : type ptr ctype "struct Point *"
begin
  ...                                       ; compute r.x and r.y
  %t18 = addr r   ; line 54
  blkcopy %sret.ptr, %t18, size 8 align 4   ; line 54
  return %sret.ptr   ; line 54
end
```

and `r = addPoints(p, q);` in the caller reads:

```
  %t124 = addr r   ; line 89
  %t125 = addr .ret0   ; line 89
  %t126 = addr p   ; line 89
  %t127 = addr q   ; line 89
  param %t125 : ptr size 8 align 4 sret   ; line 89
  param %t126 : agg size 8 align 4   ; line 89
  param %t127 : agg size 8 align 4   ; line 89
  %t128 = call @addPoints, 3   ; line 89
  blkcopy %t124, %t128, size 8 align 4   ; line 89
```

Points that matter to a back end:

* `nparams` **counts the hidden pointer**: `addPoints(a, b)` above has
  `nparams 3`, and its `.param` lines are numbered 0, 1, 2. The `sret` keyword
  on the header and on parameter 0 is what tells the two apart.
* The destination is **always** a compiler-created slot of the caller's frame,
  named `.ret0`, `.ret1`, … and listed as an ordinary `.local`; the generator
  never passes the address of the variable being assigned, even when it could.
  Every struct-returning call therefore looks the same — build in `.retN`,
  then `blkcopy` wherever the value is actually wanted — and `f().x`,
  `g(f())`, a discarded `f();`, and `s = f()` need no separate
  cases. The cost is one extra `blkcopy` on an assignment from a call; the
  benefit is that the `.retN` slot is also what makes the *address* of a
  returned struct well-defined for the rest of the expression, which C needs
  for `f().x` and which a direct hand-over would not give.
* The function **returns the pointer it was given**, which is redundant but
  convenient: the result of `call` is then an address the caller can
  `blkcopy` from or `load` a member out of, with no special case for "a call
  that produced no value in a register".
* A struct rvalue is, throughout the IR, represented by **the address of an
  object holding it**. `f().x` is a `call`, then an `addr`-style offset, then a
  `load`; there is never a struct value in a register.
* `main` is never `sret`, and a `void` function never is either; `sret` appears
  only where `retctype` is a struct or union type.

### 9.3 Variadic calls and floating arguments

The source language's variadic functions are the library's (`printf`, `scanf`
and friends). C's default argument promotions apply, and the front end performs
them before the `param`:

* a `char` argument is promoted to `int` — `param %t : int`;
* a **`float` argument is promoted to `double`** - the IR shows a `cvt.d.s`
  and then `param %t : double`. There is therefore never a `param ... : float`
  at a variadic call, which is what makes `printf("%f", f)` work with the
  single `%f` conversion that `double` uses.
* `scanf("%f", &f)` passes a `float *` and `scanf("%lf", &d)` a `double *`;
  those are ordinary pointers and are not promoted.

A format string is an ordinary string literal in the IR and **nothing in the
generator parses it** - there is no format checking, and a back end needs none
either. The promotions above are what make the usual conversions behave: in
`printf` a length modifier is ignorable, because every integer is already 32
bits and every floating argument is already a `double`, so `%f` and `%lf`
agree; in `scanf` the `l` is significant, because it selects the width of the
object written through the pointer (`%f` writes 4 bytes, `%lf` writes 8).

A back end lowering a variadic call on O32 must place a `double` argument in an
even-numbered register pair (or 8-byte-aligned stack slot); the `: double` tag
on the `param` line is there to make that possible.

## 10. Control flow and labels

* Labels are `.L<n>`, numbered from 1 and unique across the whole module. The
  numbering may have gaps: a label that is allocated but turns out not to be
  needed is simply not emitted.
* Source `goto` labels are *not* reused as IR label names; they become ordinary
  `.L<n>` labels, so a source label named `begin` or `end` cannot confuse the
  parser.
* `continue` targets: the increment of a `for`, the condition of a `while` or
  `until`, the bottom condition of a `do`-`while`.
* `break` targets the end of the innermost enclosing loop **or** `switch`,
  whichever is nearer; `continue` always targets the innermost enclosing loop,
  even from inside a `switch`.
* `switch` evaluates its controlling expression once into a register, then
  emits a chain of `==` comparisons and `if` jumps in source order, then jumps
  to the `default` label (wherever `default` was written) or past the end of the
  switch if there is none. Case bodies are laid out in source order, so
  fall-through is simply the absence of a jump.
* `until (c) S` is a pre-checked loop and is emitted exactly like
  `while (!c) S`.

## 11. Type tags

A tag is a one-word summary of how a value or object is used. It appears on
`.param`, `.local`, `.reg`, `global`, `param` and `func ret`.

| tag | meaning |
|---|---|
| `int` | a 32-bit signed integer (`int`, `enum`) |
| `char` | an 8-bit signed integer held in a 32-bit word |
| `float` | a 4-byte IEEE 754 single; on a register, says the register is in the single class |
| `double` | an 8-byte IEEE 754 double; on a register, says the register is in the double class |
| `ptr` | an address, including a **function** pointer (whose `ctype` then reads `"int (*)(int, int)"`) |
| `str` | an address that points at NUL-terminated character data: a string literal, or a `char` array. Useful when lowering `printf`/`scanf` |
| `agg` | a struct or union object (slots and globals only) |
| `void` | no value (`func ret void` only) |

For a slot or a global, `size` and `align` are authoritative and the tag is
advisory: a non-`char` array object is tagged `ptr` and a `char` array is
tagged `str`, because that is how such an object is almost always used, but
the `ctype` field gives the exact declared type (`"int [3][4]"`) if the back
end wants it.

**On a register the tag is not advisory** — it names the register's class, and
nothing else in the file does. See the `.reg` rule in §7.

There is no tag for a function type: a function pointer is `ptr`, and the thing
`faddr` names is reached through its symbol, never through a typed operand.

## 12. What lives where

The generator decides storage once, after it has seen a whole function body:

* A scalar local or parameter whose address is **never** taken becomes a
  **virtual register** (`.reg`). No load or store is emitted for it. This
  includes a `float` or `double` local — it lives in a floating register — and
  a function pointer, which is an ordinary pointer and lives in an integer
  register.
* Everything else gets a **frame slot** (`.local`), namely:
  * anything whose address is taken with `&`,
  * every array (its name decays to its address),
  * every struct and union object, including a struct or union **parameter**
    passed by value (§9.1) and the `.retN` destination of a struct-returning
    call (§9.2),
  * any parameter that falls into one of the above.
* Globals always live in the data section and are always reached with
  `addr @name` + `load`/`store`.
* Compiler-created temporaries are always registers, except the `.retN`
  destinations of struct-returning calls, which must be memory because a
  struct value has no register form.
* Floating **constants** live in the data section, in the pool of §5.3; they
  are the one kind of value that is never an immediate.

This is the one decision a back end cannot re-derive cheaply, which is why it
is written out explicitly.

## 13. Runtime functions, and what the source language does *not* have

The following library functions are known to the front end, type-checked, and
emitted as ordinary `call @name` with ordinary `param` instructions. There is no
special instruction for any of them.

* output: `printf`, `fprintf`, `sprintf`, `puts`, `putchar`
* input: `scanf`, `fscanf`, `sscanf`, `getchar`
* memory: `malloc`, `calloc`, `realloc`, `free`
* strings: `strlen`, `strcpy`, `strncpy`, `strcat`, `strcmp`, `strncmp`,
  `strchr`, `memset`, `memcpy`
* files: `fopen`, `fclose`, `fgets`, `fputs`, `fgetc`, `fputc`, `feof`,
  `rewind`, `remove`
* misc: `exit`, `abs`, `atoi`

`FILE` is a built-in opaque typedef; a `FILE *` is just a 4-byte pointer the
program never dereferences.

There is **no math library**: `sqrt`, `fabs`, `sin` and the rest are not
declared, so a program that needs them writes them itself (which the test suite
does, in `32_newton.c` and `36_complex.c`). This keeps the runtime surface the
back end must provide to the list above.

`main` is either `main(void)` or `main(int argc, char *argv[])`, returns `int`,
and `argv` is a `char **` whose `argv[argc]` element is a null pointer.

Deliberately **not** in the IR, because they are not in the source language:

* unsigned arithmetic, `long`, `short`, `long double`;
* variable-length arrays, `static`, `const`, `volatile`, bit-fields,
  designated initializers, compound literals;
* the preprocessor (so no `#include`, `#define` or conditional compilation);
* the math library (see above).

A program using any of these is rejected with a diagnostic by the front end, so
the back end never meets one.

Three features that earlier revisions of this document listed here are now
**supported**, and a back end must handle them:

| feature | what it adds to the IR |
|---|---|
| `float` and `double` | the `.s`/`.d` instruction suffixes, the `cvt.`/`trunc.` conversions, `load.s/.d`, `store.s/.d`, the `float`/`double` type tags, the `init.float`/`init.double` directives and the floating-constant pool (§5.3) |
| struct/union **by value** | `agg` arguments with `byval` parameters, `sret` returns, and `blkcopy` (§9.1, §9.2) |
| **function pointers** | `faddr`, `init.faddr`, and the indirect form of `call` (§8.9, §8.17) |

## 14. Worked examples

Every listing in this section is **copied verbatim from the generator's
output**, not written by hand.

### 14.1 Integers, an array and a loop

Source:

```c
int sum(int *a, int n) {
    int i;
    int s;
    s = 0;
    for (i = 0; i < n; i = i + 1) s = s + a[i];
    return s;
}
```

IR, exactly as emitted:

```
func @sum ret int retctype "int" nparams 2 frame 0 regs 10 temps 6    ; line 1
  .param 0 a : type ptr ctype "int *" size 4 align 4 reg %a
  .param 1 n : type int ctype "int" size 4 align 4 reg %n
  .reg %a : type ptr ctype "int *"
  .reg %n : type int ctype "int"
  .reg %i : type int ctype "int"
  .reg %s : type int ctype "int"
begin
  %s = 0   ; line 4
  %i = 0   ; line 5
.L1:
  %t4 = %i < %n   ; line 5
  ifFalse %t4 goto .L4   ; line 5
  %t5 = %i * 4   ; line 5
  %t6 = %a + %t5   ; line 5
  %t7 = load.w %t6   ; line 5
  %t8 = %s + %t7   ; line 5
  %s = %t8   ; line 5
  %t9 = %i + 1   ; line 5
  %i = %t9   ; line 5
  goto .L1   ; line 5
.L4:
  return %s   ; line 6
end
```

Points worth noting:

* `a[i]` became a multiply by 4 and an add. All index scaling is already done.
* The frame is empty (`frame 0`): nothing in this function has its address
  taken, so every local and parameter is a virtual register.
* Register-resident parameters appear **twice** in the header: once as
  `.param` (which says where the incoming value must go) and once as `.reg`
  (which declares the register itself).
* `.L2` and `.L3`, the `continue` and condition labels, were allocated but
  turned out to be unnecessary here, so they are not emitted and the label
  numbers have a gap. Numbering gaps are normal.

### 14.2 Doubles: a constant from the pool, a scaled index, a conversion

Source:

```c
double average(double *v, int n) {
    int i;
    double s;
    s = 0.0;
    for (i = 0; i < n; i = i + 1) s = s + v[i];
    return s / n;
}
```

IR:

```
func @average ret double retctype "double" nparams 2 frame 0 regs 14 temps 10    ; line 1
  .param 0 v : type ptr ctype "double *" size 4 align 4 reg %v
  .param 1 n : type int ctype "int" size 4 align 4 reg %n
  .reg %v : type ptr ctype "double *"
  .reg %n : type int ctype "int"
  .reg %i : type int ctype "int"
  .reg %s : type double ctype "double"
  .reg %t5 : type double ctype "double"
  .reg %t9 : type double ctype "double"
  .reg %t10 : type double ctype "double"
  .reg %t12 : type double ctype "double"
  .reg %t13 : type double ctype "double"
begin
  %t4 = addr @.fc0   ; line 4
  %t5 = load.d %t4   ; line 4
  %s = %t5   ; line 4
  %i = 0   ; line 5
.L1:
  %t6 = %i < %n   ; line 5
  ifFalse %t6 goto .L4   ; line 5
  %t7 = %i * 8   ; line 5
  %t8 = %v + %t7   ; line 5
  %t9 = load.d %t8   ; line 5
  %t10 = %s +.d %t9   ; line 5
  %s = %t10   ; line 5
  %t11 = %i + 1   ; line 5
  %i = %t11   ; line 5
  goto .L1   ; line 5
.L4:
  %t12 = cvt.d.w %n   ; line 6
  %t13 = %s /.d %t12   ; line 6
  return %t13   ; line 6
end
```

with, in the data section:

```
global @.fc0 size 8 align 8 type double ctype "double"
  init.double 0.0    ; 0x0000000000000000
```

Points worth noting:

* `s = 0.0` is **two instructions**, not one: there are no floating
  immediates, so the constant is interned as `@.fc0` and loaded (§5.3). A back
  end may of course recognise a zero and use `mtc1 $zero` instead.
* `v[i]` scales the index by **8**, the size of a `double`. Index scaling is
  ordinary integer arithmetic: `%t7` and `%t8` are integer registers in the
  middle of an otherwise floating expression.
* `%i < %n` is an *integer* comparison, written `<`, while a comparison of two
  doubles would be `<.d` and would still produce an integer result.
* `s / n` converts `n` first: `cvt.d.w` then `/.d`. The usual arithmetic
  conversions are already done; the back end never has to infer one.
* Six of the ten temporaries carry a `.reg` line, and those are exactly the
  floating ones. `%t6`, `%t7`, `%t8` and `%t11` have none, so they are integer
  temporaries (§7).

### 14.3 A call through a function pointer

Source:

```c
int apply(int (*f)(int), int v) { return f(v); }
```

IR:

```
func @apply ret int retctype "int" nparams 2 frame 0 regs 3 temps 1    ; line 1
  .param 0 f : type ptr ctype "int (*)(int)" size 4 align 4 reg %f
  .param 1 v : type int ctype "int" size 4 align 4 reg %v
  .reg %f : type ptr ctype "int (*)(int)"
  .reg %v : type int ctype "int"
begin
  param %v : int   ; line 1
  %t2 = call %f, 1   ; line 1
  return %t2   ; line 1
end
```

Points worth noting:

* The function pointer is just a `ptr` in a register, with the pointed-to
  signature recorded only in the readable `ctype`.
* `call %f, 1` — a register, not an `@symbol` — is the whole of what makes
  this call indirect. The `param` protocol is identical to a direct call's.
* Nothing in the IR re-states the callee's signature: the front end has
  already checked the argument count and types against the pointer's
  prototype.
* `f(v)` and `(*f)(v)` generate exactly this same IR.

### 14.4 Taking a function's address

Source:

```c
int add(int a, int b) { return a + b; }
int (*gfp)(int, int) = add;

int main(void) {
    int (*fp)(int, int);
    fp = add;
    return fp(1, 2) + gfp(3, 4);
}
```

The static initializer becomes a data directive, the local assignment becomes a
`faddr`, and a pointer read out of a global becomes an ordinary `load.w`:

```
global @gfp size 4 align 4 type ptr ctype "int (*)(int, int)"
  init.faddr @add
```

```
func @main ret int retctype "int" nparams 0 frame 0 regs 11 temps 10    ; line 4
  .reg %fp : type ptr ctype "int (*)(int, int)"
begin
  %t1 = faddr @add   ; line 6
  %fp = %t1   ; line 6
  %t2 = 1   ; line 7
  %t3 = 2   ; line 7
  param %t2 : int   ; line 7
  param %t3 : int   ; line 7
  %t4 = call %fp, 2   ; line 7
  %t5 = addr @gfp   ; line 7
  %t6 = load.w %t5   ; line 7
  %t7 = 3   ; line 7
  %t8 = 4   ; line 7
  param %t7 : int   ; line 7
  param %t8 : int   ; line 7
  %t9 = call %t6, 2   ; line 7
  %t10 = %t4 + %t9   ; line 7
  return %t10   ; line 7
end
```

Points worth noting:

* `init.faddr @add` is the static form of `faddr` — the only way a data object
  can hold the address of a function.
* The *same* indirect `call` serves both a pointer in a named register (`%fp`)
  and one just loaded out of a global (`%t6`). Nothing distinguishes where the
  address came from.
* A function name used as a value is always `faddr`; `add` here never becomes
  `addr @add`, which is reserved for data symbols (§8.9).

## 15. Invariants a back end may rely on

These are all checked by `tools/ircheck.py` on every generated file in the test
suite:

1. Every label is defined exactly once, and every `goto`/`if`/`ifFalse` target
   is a label defined in the same function.
2. Every virtual register is written before it is read on **every** path that
   reaches the read.
3. Every `call`, direct or indirect, is preceded within its own function by at
   least `n` pending `param` instructions. For a direct call, `f` is either a
   function defined in the module or a declared `extern`; for an indirect one,
   the target is a register.
4. Every function's instruction list ends with `return`, and control cannot
   fall off the end of a function.
5. Every `addr` operand names a slot of the enclosing function or a data symbol
   that exists; every `faddr` and `init.faddr` operand names a **function**,
   and every `addr @`/`init.addr` operand names a **data object**, never the
   other way round.
6. Every `load`/`store` width is consistent with the size of the object it
   reaches, where that can be determined statically.
7. Every global's `init.*` widths sum to exactly its declared `size`.
8. The number of `.param` lines equals `nparams`, and every slot offset lies
   within `frame`. For an `sret` function, parameter 0 is the hidden result
   pointer and is counted in `nparams`.
9. **The two register classes are never mixed.** An integer operation neither
   reads nor writes a `float`/`double` register; a `.s`/`.d` operation neither
   reads nor writes an integer register; a `cvt.`/`trunc.` relates the two in
   exactly the direction its mnemonic names; a plain copy has the same class on
   both sides. The two deliberate exceptions, both checked: a floating
   *comparison* writes an integer destination, and `load.s`/`load.d`/`store.s`/
   `store.d` take an integer register as the **address** and a floating one as
   the value.
10. Every `blkcopy` has a constant `size` and an `align` that both ends really
    have, and may be implemented with `memmove` semantics (§8.12).

Invariants 1–10 are checked by `tools/ircheck.py` on every file the test suite
generates, and `./verify.sh` additionally *executes* each file with
`build/irsim` and compares the result against the same program compiled by
gcc, so a violation that the checker's static reasoning misses still shows up
as a wrong answer.

## 16. Stage 4 changes

This copy of the Stage 3 document belongs to the MIPS compiler (Stage 4).
The IR it describes is unchanged except for the points below. Each change
is marked "Stage 4" in the source. `--emit-ir` writes exactly this format.

1. **`init.addr @sym+N`**: an address constant with an offset. Stage 3
   accepted `int *p = &a[2];` and `char *q = &s.m;` at file scope but
   emitted `init.word 0` for every `&...` initializer except a plain `&g`.
   The global was silently null, which is a Stage 3 bug.
   - The generator now recognises the address of an element or member at
     a constant offset inside a global (`&g`, `&a[2]`, `&s.m`,
     `&a[1][2].x`, or an array name that decays). It writes
     `init.addr @a+8`; the `+N` (or `-N`) is omitted when it is 0, so
     Stage 3's output is unchanged for `&g`.
   - Other non-constant initializers, such as `int *p = a + 1;`, are still
     rejected with Stage 3's diagnostic (README, limitations).
   - The MIPS back end has to store these words at startup, because spim
     cannot assemble `.word sym+N` (MIPS-DESIGN.md section 7).
2. **`frame` is a multiple of 8 again.** Temporary slots created after
   sema had rounded the frame could leave `frame 252`, contradicting
   section 7. The generator now rounds once more after the last slot.
3. **Short-circuit `&&` / `||` inside each other.**
   - Stage 3 gave the left operand of `&&` the whole condition's true
     label. In `(a || b) && c`, a true `a` therefore jumped to the true
     label without testing `c`. Symmetrically, in `(a && b) || c`, a false
     `a` skipped `c`.
   - The left operand now jumps to a fresh label in front of the right
     operand.
   - The label is created only when the left operand can actually jump
     there, so the IR of every condition that was already correct is
     unchanged, label numbers included.
   - Test 66 covers every combination.
4. **Runtime mode** (`mipscc --runtime`, used only by the makefile): the
   source file defines the library, so the builtins of section 13 are not
   pre-declared. Nothing changes in the IR format.
5. **Nesting limit.** Semantic analysis and IR generation walk the tree
   recursively, so a long left-associative chain such as a sum of 20000
   terms overflowed the C++ stack. Stage 3's `irgen` crashes with SIGSEGV on
   such an input, because bison's 10000-entry stack does not limit it: the
   chain parses with a shallow parser stack. After parsing, the driver now
   measures the tree's depth without recursion. A tree deeper than 10000
   levels is reported as `Syntax Error [Line L, Col C]: expression or
   statement nested too deeply (limit 10000 levels)` at the first node past
   the limit. The compiler runs on a thread with a 1 GiB stack, which is
   reserved but only allocated as used, so that depth is safe in every pass,
   including under AddressSanitizer. This is test `e26`. No IR is affected.
