# MIPS back end: design

This document specifies how `mipscc` (Stage 4) turns the Stage 3 IR
(`docs/IR-DESIGN.md`) into MIPS assembly for SPIM. It covers:

- registers, the stack frame and the calling convention
- the lowering of every IR instruction
- data layout, naming and the runtime library
- the `-O1` register allocator
- how all of this was verified

Section numbers are referred to from the source (`src/mips.cpp`,
`src/runtime/rt_core.s`, `src/runtime/rt_lib.c`, `tools/check_asm.py`), so
they are stable.

Where this document makes a claim about spim's behaviour, the claim was
checked against the simulator itself (version below) with a small probe
program, not taken from the manual.

---

## 1. Target and simulator

### 1.1 Which simulator

| | |
|---|---|
| Simulator | **SPIM Version 8.0 of January 8, 2010**: the command-line `spim` of the Debian/Ubuntu package `spim 8.0+dfsg-7` |
| Install | `sudo apt-get install -y spim` |
| Run | `spim -file prog.s [arg...] < input` |
| QtSpim | Not tested here: there is no display, and QtSpim is not packaged. It is built from the same simulator core (see 1.3). |

**The generated file assumes spim's defaults:**

- **Pseudo-instructions accepted.** The back end uses `li`, `la`, `move`,
  `b` and the three-register `mul`.
- **No branch delay slots and no load delay slots.** These are spim's
  defaults: `-delayed_branches` and `-delayed_loads` are off.
- **The default exception handler is loaded.** Its `__start` calls the
  global label `main` with argc in `$a0`, argv in `$a1` and envp in `$a2`.
  When the program returns from `main`, `__start` would exit with syscall 10
  (status 0), so the runtime's `main` stub never returns: it exits with
  syscall 17 instead (section 8.1).
- **Little-endian memory.** spim uses the host's byte order, and the host
  is x86. This matters only where the runtime takes a double apart into two
  words (word 0 is the low half) and for the bit patterns of section 7.3.

**Each of these facts about spim 8.0 was observed with a probe:**

- The banner is 5 lines on **stdout**, the last being
  `Loaded: .../exceptions.s`. `-quiet` does *not* suppress it. The test
  scripts strip everything up to and including the `Loaded:` line.
- `argv[0]` is the path of the `.s` file, and the remaining command-line
  words follow: `spim -file a.s xx yy` gives `argc == 3`.
- At the entry to `main`, `$sp & 7 == 4`: the stack pointer is only
  4-byte aligned. The entry stub realigns it (section 8.1).
- Syscall 17 (`exit2`) exits with status `$a0 & 0xff` (300 gives 44).
  Syscall 10 always gives 0.
- Syscalls 13/14/15/16 (open/read/write/close) work on the host's files.
  `open` passes its flags straight to the host's open(2), so they are the
  **Linux** values: `O_WRONLY|O_CREAT|O_TRUNC` = `0x241`. Stdin redirection
  works with syscall 14 on fd 0.
- Syscall 9 (`sbrk`) works and rounds the request up to a multiple of 8.
- There is no `lseek` and no `unlink` syscall (section 8.5 explains the
  consequences).
- `c.lt.d` / `c.le.d` with a NaN operand print
  `Exception 15 [Floating point] occurred and ignored` **on stdout**.
  `c.olt.d` / `c.ole.d` do not (section 5.4).
- `.word sym+4` is a parse error; only `.word sym` is accepted
  (section 7.4).
- Inside `.asciiz`, `\n`, `\t` and `\"` work, but `\\` assembles as **two**
  backslashes and octal escapes are rejected (section 7.2).
- `ldc1` / `sdc1` at an address that is only 4-aligned do not trap in spim.
  The back end keeps doubles 8-aligned anyway (section 3.5).
- The default stack is a little over 256 KB. Deeper recursion needs
  `spim -lstack <bytes>`. Test 58 recurses several hundred frames deep and
  test 63 has a frame of over 32 KB; both run with the default stack.

### 1.2 The header of every `.s` file

Every generated file starts with a comment giving:

- the simulator and its version
- how to install it
- the run command, with arguments and input
- the banner
- the assumptions listed above
- the stack limit and `-lstack`
- how the exit status is formed
- the optimisation level

`tools/check_asm.py` checks that the `Simulator :`, `Run :` and `Assumes :`
lines are present.

### 1.3 QtSpim

QtSpim (9.x) is the Qt front end to the same simulator core: the same
parser, the same instruction set, the same syscalls including 17, and the
same default exception handler with `__start` calling `main`. Nothing the
back end emits is specific to the command-line version.

To run a file in QtSpim:

1. Keep the default settings. "Simulate bare machine" and "Enable delayed
   branches" must be **off**, and "Load exception handler" must be **on**.
2. *File → Reinitialize and Load File*, then *Simulator → Run*.
3. Program arguments go in *Simulator → Run Parameters*.
4. Standard input is typed into the console window; QtSpim has no input
   redirection.

The only observable differences are QtSpim's own: there is no banner in the
console, and the exit status is shown rather than returned to a shell.

---

## 2. Registers

| register | use |
|---|---|
| `$zero` | constant 0; also used as the operand for an IR immediate 0 |
| `$at` | reserved for the assembler's pseudo-instructions, never used directly |
| `$v0` | integer, pointer and sret results; syscall number |
| `$v1` | unused |
| `$a0`–`$a3` | the first 16 bytes of the argument area (section 4) |
| `$t0`–`$t2` | operand scratch: an instruction's operands and result while it is lowered |
| `$t3`–`$t6` | block-copy scratch: up to four words loaded before any is stored (section 5.8) |
| `$t7` | address scratch for frame offsets that do not fit 16 bits (section 3.4) |
| `$t8` | unused |
| `$t9` | callee address of an indirect call (`jalr $t9`) |
| `$s0`–`$s7` | `-O1` only: integer IR registers (callee-saved) |
| `$k0`, `$k1` | kernel, untouched |
| `$gp` | untouched (spim's default); globals are addressed with `la` |
| `$sp` | stack pointer, 8-byte aligned at every call |
| `$fp` | frame pointer = the caller's `$sp` at entry (callee-saved) |
| `$ra` | return address (saved by every non-leaf function, which is every compiled function) |
| `$f0` (`$f0:$f1`) | float (double) result |
| `$f4`, `$f6`, `$f8` | floating operand scratch (even registers, so they hold doubles) |
| `$f20`–`$f30` (even) | `-O1` only: float and double IR registers (callee-saved, so `$f20`–`$f31` with the odd halves) |
| FPU condition flag 0 | written by `c.*`, read immediately by `bc1t` / `bc1f` |

**Callee-saved:** `$s0`–`$s7`, `$fp`, `$ra`, `$f20`–`$f31`, and `$sp`
itself. Everything else may be changed by a call.

The register-class split of the IR (IR-DESIGN.md section 15, invariant 9)
maps one-to-one onto the integer and FPU register files: an integer IR
register lives in an integer register or a word slot, and a float or double
IR register lives in an FPU register or a 4- or 8-byte slot. The two meet
only through `mtc1` / `mfc1` in the conversions (section 5.5) and through
the condition flag in floating comparisons (section 5.4).

---

## 3. Stack frame

### 3.1 Layout

The stack grows downwards. `$fp` is set to the caller's `$sp` at entry, so
every offset in a frame is a fixed negative offset from `$fp`. Incoming
arguments are at non-negative offsets from `$fp`.

```
              caller's frame
        +----------------------------+  higher addresses
        | stack arguments (bytes 16+)|  16($fp) ...
        | home area for $a0-$a3      |  0..15($fp)   <- $fp = caller's $sp
        +============================+  (both written by the CALLER's outgoing area)
        | saved $ra                  |  -4($fp)
        | saved caller's $fp         |  -8($fp)
        | saved $f20..$f30 (8 each)  |  -O1, doubles first, so 8-aligned
        | saved $s0..$s7   (4 each)  |  -O1, padded to a multiple of 8
        +----------------------------+  localBase (8-aligned)
        | IR frame slots (.local and |  localBase + slot offset, exactly as the
        | slot-resident .param)      |  IR's `frame F` bytes (F rounded to 8)
        +----------------------------+
        | stack homes of IR registers|  -O0: every register; -O1: the ones not
        | (4 bytes, doubles 8-aligned)|  given a physical register
        +----------------------------+  (8-aligned)
        | outgoing argument area     |  max(16, largest call), multiple of 8
        +----------------------------+  0($sp)       lower addresses
```

- The frame size, `$fp - $sp`, is a multiple of 8. It is `localBase`
  minus the register homes minus the outgoing area.
- Every function's header comment lists the frame: each parameter's
  incoming offset and register, the saved registers, each local slot with
  its C type and size, and each IR register's home or physical register.
  Section 3.6 shows an example.

**Why this layout:**

- **A frame pointer equal to the incoming `$sp`.** Incoming arguments are
  at fixed non-negative offsets, and everything the function owns is at a
  fixed negative offset. Both are known before the body is lowered, and
  neither changes when `$sp` does. Frame offsets are computed once, in
  `layoutFrame`.
- **`$ra` and `$fp` are saved below the incoming `$sp` before `$sp` moves**
  (`sw $ra,-4($sp)`; `sw $fp,-8($sp)`). The prologue therefore needs no
  scratch register even when the frame size does not fit an immediate.
- **The caller provides the 16-byte home area** for `$a0`–`$a3`, as in
  o32. The callee stores the register arguments there, so its whole
  argument list is one contiguous struct in memory at `0($fp)`. This makes
  struct-like argument layout (section 4.1) and the variadic routines
  (section 4.2) trivial.
- **`-O0` keeps every IR register in its own stack home.** Each IR
  instruction is lowered on its own: operands are loaded into `$t0`/`$t1`
  (`$f4`/`$f6`) and the result is stored. Nothing is live across IR
  instructions in a machine register, so this mode is obviously correct and
  is the reference that `-O1` must match.

### 3.2 Prologue

```
fn_f:
        sw      $ra, -4($sp)
        sw      $fp, -8($sp)
        move    $fp, $sp
        addiu   $sp, $sp, -N        # or: li $t7, N ; subu $sp, $sp, $t7   (N > 32768)
        sdc1    $f20, -16($fp)      # -O1: callee-saved registers this function uses
        sw      $s0, -36($fp)       #      (offsets via $t7 if they were ever too big)
        sw      $a0, 0($fp)         # home the register arguments that exist
        sw      $a1, 4($fp)
        # param a : ptr at 0($fp)   # then move each parameter where the body wants it:
        lw      $s0, 0($fp)         #   its physical register (-O1),
        lw      $t0, 4($fp)         #   or its register home / frame slot (-O0)
        sw      $t0, -16($fp)
```

Each parameter goes where its `.param` line says (IR-DESIGN.md section 9,
point 4):

- **A register parameter** is loaded from the incoming area into its
  physical register or its stack home.
- **A slot parameter** (one whose address is taken) is copied into its frame
  slot. A `double` takes two words; a `char` uses `sb`.
- **A struct passed by value** arrives as the caller's address. The callee
  copies the object into its own frame slot with the block copy of
  section 5.8. This is the IR's "callee copies" rule (IR-DESIGN.md
  section 9.1).

Only the argument registers that actually carry argument bytes are homed.

### 3.3 Epilogue

There is one epilogue per function, at the label `fsym.ret`:

```
fn_f.ret:
        ldc1    $f20, -16($fp)      # -O1: restore what the prologue saved
        lw      $s0, -36($fp)
        move    $sp, $fp
        lw      $ra, -4($sp)
        lw      $fp, -8($sp)
        jr      $ra
```

- Every IR `return` moves its value into place and branches to
  `fsym.ret`, except the function's last instruction (always a `return`;
  IR-DESIGN.md section 15, invariant 4), which falls into the epilogue.
- `move $sp,$fp` releases the frame whatever its size, so no large
  immediate is needed here.

### 3.4 Frame offsets that do not fit 16 bits

A MIPS load or store displacement is a signed 16-bit immediate. Every
`$fp`-relative access whose offset lies outside `-32768..32767` is
computed instead:

```
        li      $t7, -40020
        addu    $t7, $t7, $fp
        lw      $t0, 0($t7)
```

- Taking such an address (`addr v`) is `li $t7,off` then
  `addu dst,$t7,$fp`.
- The frame allocation itself becomes `li $t7,N; subu $sp,$sp,$t7`.
- Outgoing-argument stores (`0($sp)` upwards) go through the same helper,
  although no realistic call needs it.
- **Test 63** has frames larger than 32 KB (a local array of 10 000 ints
  and locals behind it), passes such arrays to functions, and reads and
  writes variables on both sides of the 32 KB boundary.
- `tools/check_asm.py` rejects any displacement or `addiu` immediate
  outside 16 bits.

### 3.5 Alignment

- **`$sp` is 8-byte aligned at every `jal` / `jalr`.**
  - The entry stub aligns it (section 8.1).
  - Every frame size is a multiple of 8.
  - The variadic stubs of the runtime move `$sp` by 24.
  - The other hand-written routines do not touch `$sp`.
  - `tools/check_asm.py` tracks `$sp` through every function and checks
    this at every call (section 10).
- **A `double` is always 8-aligned:**
  - in a frame (saved `$f` registers, slots, register homes and argument
    positions are all at 8-aligned `$fp` offsets, and `$fp` is 8-aligned);
  - in data (`.align 3`);
  - in the heap (malloc returns 8-aligned blocks);
  - inside structs (the IR's layout already aligns `double` members to 8).

  spim itself would accept 4-aligned `ldc1` (section 1.1). The 8-alignment
  keeps the code correct for real MIPS hardware and keeps the layout
  identical to the IR's model.

### 3.6 Example: a frame header (`-O1`)

Here is the real output for `double avg(int *a, int n)` (the worked example
in the README):

```
# function avg (line 2), returns double
# frame 72 bytes ($fp = $sp at entry):
#   0($fp)	param a (ptr, arrives in $a0)
#   4($fp)	param n (int, arrives in $a1)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -16($fp)	saved $f20
#   -24($fp)	saved $f22
#   -32($fp)	saved $f24
#   -36($fp)	saved $s0
#   ...
#   $s0	%a : ptr
#   $f22	%s : double
#   ...
#   0($sp)	outgoing arguments (16 bytes)
```

---

## 4. Calling convention

### 4.1 Normal calls

The arguments of a call are laid out **as if they were the members of a
struct**:

- Every `int`, `char` (already promoted by the IR), pointer, `float` and
  struct address takes one 4-byte word.
- A `double` takes 8 bytes at the next 8-aligned offset.

**Where the bytes travel:**

- The first 16 bytes of that struct travel in `$a0`–`$a3`, one word each.
  A double in the first 16 bytes therefore travels as two integer
  registers, low word first.
- The rest is stored by the caller at `16($sp)`, `20($sp)`, … of its own
  frame.

**The lowering:**

- Each IR `param` stores its value into the caller's outgoing area at its
  struct offset: `sw`, `swc1` or `sdc1` at `off($sp)`. The pending offset
  is tracked from one `param` to the next.
- The `call` then loads the first `min(16, bytes)` of the area into
  `$a0`–`$a3` and executes `jal fsym`.

**Why this is safe:**

- The IR guarantees that a call's `param` instructions are contiguous and
  immediately precede it (IR-DESIGN.md section 9, point 1). All nested
  calls are complete before the first `param`, so the outgoing area is
  never overwritten by a nested call between a `param` and its `call`.
- The bytes that travel in `$a0`–`$a3` are also present at `0..15($sp)`.
  The callee stores the registers there again, into the same words: the
  outgoing area *is* the callee's home area.
- The outgoing area is sized for the largest call of the function, and is
  never smaller than 16 bytes, because a callee may home its register
  arguments there.

**Results:**

- `int`, `char` and pointer results come back in `$v0`.
- `float` results come back in `$f0`; `double` results in `$f0:$f1`.
- The struct result convention is in section 4.4.

Test 59 calls functions with more than ten arguments, mixing `int`,
`char`, `float` and `double` in every order. Test 12 covers ordinary calls
and recursion, and test 58 covers deep recursion.

### 4.2 Variadic calls

- A call to `printf` and its relatives is lowered exactly like any other
  call. The IR has already applied the default promotions: `char` to
  `int`, and `float` to `double` (IR-DESIGN.md section 9.3).
- In the outgoing area, the variable arguments therefore form a correctly
  aligned array of words and 8-aligned doubles, right after the fixed
  ones.
- The runtime's variadic entry points (`__rt_printf`, `__rt_fprintf`,
  `__rt_sprintf`, `__rt_scanf`, `__rt_fscanf`, `__rt_sscanf` in
  `rt_core.s`) work as follows:
  1. Store `$a0`–`$a3` back into the caller-provided home area.
  2. Push a 24-byte frame for `$ra`.
  3. Call the matching `v…` routine of `rt_lib.c` with the fixed arguments
     and a pointer `ap` to the first variable one.
- The `v…` routines walk `ap` as an `int *`. Before reading a double they
  round it up to a multiple of 8. This is correct because the argument
  area starts at the caller's `$sp`, which is 8-aligned (section 3.5).
- Because a double is 8-aligned in the argument area, it travels in
  `$a0:$a1`, in `$a2:$a3`, or wholly on the stack. It never straddles the
  last register and the stack. An `int` before a double leaves a padding
  word, exactly as `ap` rounding expects.
- **Test 59** mixes `int`, `char`, `float` and `double` arguments in every
  order, for user functions and for printf. printf calls with doubles
  after one or more integers occur throughout tests 24–37 and 67.

### 4.3 Indirect calls (function pointers)

```
        lw      $t9, -20($fp)       # the pointer (or move $t9, $sN at -O1)
        jalr    $t9
```

- An indirect call differs from a direct one only in its last
  instruction. The `param` / `call` protocol, the argument layout and the
  result registers are identical (IR-DESIGN.md section 8.17).
- `$t9` holds the target because MIPS PIC code expects it there, and
  because no argument or `-O1` register lives in it.
- A function's address (`faddr`, `init.faddr`) is its `fn_` label, taken
  with `la` or `.word`.

Tests 30, 31, 40 and 61 cover pointers in variables, struct members and
arrays, callbacks, functions returning function pointers, and comparisons
between function pointers.

### 4.4 Structs by value

**Arguments.** A struct or union argument is passed as **the address of the
caller's object**, in its word of the argument area (`param %t : agg size S
align A`). The callee copies it into its own frame slot in the prologue
(section 3.2). This is the IR's own rule: the callee copies (IR-DESIGN.md
section 9.1). It means:

- A struct argument costs one word however big it is.
- The callee can modify its copy freely.

**Results** use a hidden result pointer, the IR's `sret` (IR-DESIGN.md
section 9.2):

- The caller passes the address of a result object as argument 0. In the
  IR this is `param %t : ptr size S align A sret`, so it arrives in `$a0`.
- The callee writes the result through that pointer and returns the same
  pointer in `$v0`. The caller may use the returned address directly
  (`f().x`, `g(f())`).

Copying a struct (assignment, argument copy-in, or a return through the
sret pointer) uses the `blkcopy` lowering of section 5.8, which has
memmove semantics. That makes `s = *p` correct even when `p` points into
`s`.

Tests 27, 28, 29, 36, 39 and 60 cover this. Test 60 passes and returns
structs of 1, 4, 8, 12 and 20 bytes, and one with a double member (size
16, alignment 8).

### 4.5 `float` and `double`

- **Arguments** are stored into the argument area like everything else
  (`swc1` / `sdc1`), so a `double` among the first 16 bytes reaches the
  callee in two integer registers. The callee homes `$a0`–`$a3` first and
  then reads the parameter with `lwc1` / `ldc1` from its incoming area, so
  a floating parameter never needs an `mtc1` pair.
- **A non-variadic `float` parameter stays a 4-byte float.** The IR does
  not promote it (only variadic arguments are promoted).
- **Results** come back in `$f0` (float) or `$f0:$f1` (double).

Tests 24–27, 32–37, 59 and 71 cover this.

### 4.6 Relation to o32, and why it differs

The memory image of the argument list is the o32 one: struct-like,
doubles 8-aligned, 16 bytes in `$a0`–`$a3` with a caller-allocated home
area. The results are the o32 ones too. There are three **deliberate
deviations**:

1. **No floating-point argument registers.** o32 passes leading `float` /
   `double` arguments in `$f12` / `$f14` and everything else in integer
   registers, with special rules for mixed and variadic lists. This back
   end always passes argument bytes in `$a0`–`$a3` and memory.
   - *Why:* a single rule serves direct, indirect and variadic calls
     alike, and the IR's `param` tags are enough to apply it.
   - *Cost:* a floating argument makes a round trip through memory, which
     spim does not charge for.
2. **Struct arguments are passed by address, and the callee copies.** o32
   copies the struct itself into the argument words. *Why:* this is what
   the IR specifies (IR-DESIGN.md section 9.1). The IR has the callee copy
   and gives `param` the object's address, so following o32 would mean
   re-deriving the copy in the caller.
3. **The frame is `$fp`-based, with `$ra` / `$fp` at fixed offsets
   `-4` / `-8`.** *Why:* simplicity and readability of the output. o32
   does not mandate a frame layout.

All code in the program, user code and runtime alike, comes from this
compiler or from `rt_core.s`, which follows the same convention. Nothing
is linked against foreign o32 code, so these deviations cannot break an
interface.

---

## 5. Lowering of the IR

Every IR instruction is preceded in the output by a comment holding its IR
text exactly as `--emit-ir` writes it. Labels are emitted as labels.

Operand access depends on where the IR register lives:

- **`-O0`:** a register operand is loaded from its stack home into the
  instruction's scratch register (`$t0` for the first operand, `$t1` for
  the second, `$f4` / `$f6` for floating ones). The result is computed into
  `$t0` (`$f8` for floating arithmetic) and stored back to the home.
- **`-O1`:** a register given a physical register is used in place; only
  spilled registers go through scratch.
- **An immediate operand of 0** is `$zero`. Any other immediate is `li`
  into the scratch register, unless the instruction has an immediate form
  that fits (section 5.2).

### 5.1 Summary table

| IR | MIPS | notes / tests |
|---|---|---|
| `.L:` | `fsym.L:` | labels are per function (section 6) |
| `%d = %a` (int) | `move` (or nothing, if allocation made them equal) | |
| `%d = %a` (float / double) | `mov.s` / `mov.d`, or `lwc1`/`swc1`, `ldc1`/`sdc1` through `$f4` | |
| `%d = imm` | `li` (`move d,$zero` for 0) | |
| `%d = %a op %b` (int) | section 5.2 | 01, 48, 62 |
| `%d = %a / %b`, `%` | section 5.3 | 62, 74 |
| `%d = %a op.s/.d %b` | `add/sub/mul/div.s/.d` | 24–27, 71 |
| float compare | section 5.4 | 24, 71 |
| `%d = -%a` / `!%a` / `~%a` | `subu d,$zero,a` / `sltiu d,a,1` / `nor d,a,$zero` | 01, 48 |
| `%d = -.s/-.d %a` | `neg.s` / `neg.d` | 71 |
| `%d = sext.b %a` | `sll d,a,24` ; `sra d,d,24` | 18, 53 |
| `cvt.*` / `trunc.*` | section 5.5 | 71 |
| `%d = addr slot` | `addiu d,$fp,off` (via `$t7` if large) | 08, 63 |
| `%d = addr @g` | `la d, gv_g` / `d.strN` | 06, 73 |
| `%d = faddr @f` | `la d, fn_f` | 30, 61 |
| `%d = load.w/.b/.s/.d %a` | `lw` / `lb` (signed char) / `lwc1` / `ldc1` `0(a)` | 08, 51 |
| `store.w/.b/.s/.d %a, %v` | `sw` / `sb` / `swc1` / `sdc1` `0(a)` | 08, 51 |
| `blkcopy %d, %s, size N align A` | section 5.8 | 28, 29, 60 |
| `memzero %d, N` | section 5.8 | 06, 36, 46 |
| `goto .L` | `b fsym.L` | 16, 65 |
| `if %c goto .L` / `ifFalse %c goto .L` | `bne c,$zero,…` / `beq c,$zero,…`; with a constant condition: `b` or nothing | 03, 66 |
| `param %v : tag` | store into the outgoing area (section 4.1) | 59 |
| `%d = call @f, n` / `call %r, n` | load `$a0`–`$a3`; `jal fn_f` / `jalr $t9`; result from `$v0` / `$f0` | 12, 30 |
| `return %v` / `return` | value to `$v0` / `$f0`; `b fsym.ret` unless last | 12 |

### 5.2 Integer arithmetic, bitwise operators and comparisons

All integer arithmetic is 32-bit two's complement and **wraps**. `addu`,
`subu` and `mul` never trap on overflow, which matches gcc's
`-m32` code for the overflow cases the tests exercise (test 62).

| op | immediate right operand that fits | otherwise |
|---|---|---|
| `+` | `addiu d,a,imm` (signed 16) | `addu` |
| `-` | `addiu d,a,-imm` (if `-imm` fits) | `subu` |
| `*` | – | `mul d,a,b` (low 32 bits) |
| `&` `\|` `^` | `andi` / `ori` / `xori` (unsigned 16) | `and` / `or` / `xor` |
| `<<` `>>` | `sll` / `sra d,a,imm&31` | `sllv` / `srav` |
| `<` | `slti` | `slt` |
| `>=` | `slti` then `xori d,d,1` | `slt` then `xori d,d,1` |
| `>` | – | `slt d,b,a` |
| `<=` | – | `slt d,b,a` then `xori d,d,1` |
| `==` | `xori d,a,imm` then `sltiu d,d,1` | `xor` then `sltiu d,d,1` |
| `!=` | `xori d,a,imm` then `sltu d,$zero,d` | `xor` then `sltu d,$zero,d` |

- **Comparisons produce exactly 0 or 1**, as the IR requires.
- **`>>` is arithmetic** (`sra`), because the language has only signed
  integers.
- **Shift counts use their low 5 bits.** That is what `sllv` / `srav` do,
  and what x86 does for a count computed at run time. A constant count is
  masked the same way, so the two forms agree (test 74). C leaves counts
  outside 0..31 undefined.
- **`char` is signed.** `load.b` is `lb`, and `sext.b` is `sll` / `sra`
  by 24 (test 62: `char` 200 is -56).

### 5.3 Division and remainder

C semantics: the quotient truncates toward zero and the remainder has the
sign of the dividend. That is exactly what MIPS `div` leaves in `lo` / `hi`
(test 62 checks every sign combination). Two cases need care.

**A zero divisor.**

- *What MIPS does:* `div` by 0 does not trap on MIPS, and leaves
  unpredictable values.
- *What this compiler does:* the same as irsim, the reference for C's
  undefined behaviour here. The program writes
  `runtime error: division by zero` to stderr and exits with status 70.
  Output already printed is kept, because output is unbuffered
  (section 8.4).
- *Lowering:* `bne b,$zero,ok` ; `jal __rt_divzero`. A constant divisor of
  0 calls `__rt_divzero` directly.

**`INT_MIN / -1`.**

- *What MIPS does:* the result overflows, and the hardware result is
  unpredictable.
- *What this compiler does:* defines the quotient as `INT_MIN` (wrapping
  negation) and `INT_MIN % -1` as `0`, the mathematically right remainder.
- *Lowering:* a divisor of `-1` is tested for and handled with
  `subu d,$zero,a` / `move d,$zero`, without `div`. A constant divisor of
  `-1` emits only that.

```
        bne     $t1, $zero, fn_q.c0
        jal     __rt_divzero
fn_q.c0:
        li      $t2, -1
        bne     $t1, $t2, fn_q.c1
        subu    $t0, $zero, $t0        # (move $t0, $zero for %)
        b       fn_q.c2
fn_q.c1:
        div     $t0, $t1               # the real instruction, not spim's checking macro
        mflo    $t0                    # (mfhi for %)
fn_q.c2:
```

`div rs,rt` with two operands is the machine instruction. spim's
three-operand `div` pseudo-instruction would insert its own checks, and
those are not used. Test 74 (`@no-gcc`, since C leaves both cases
undefined) checks both behaviours against irsim.

### 5.4 Floating-point arithmetic and comparisons

- `+ - * /` on `.s` / `.d` are `add.s` … `div.d`, with IEEE default
  rounding, as with gcc's `-mfpmath=sse`. Single precision stays single:
  a `float` expression is not computed in double (test 71).
- A comparison sets the FPU condition flag and turns it into 0 or 1:

| IR | compare | branch for "true" |
|---|---|---|
| `a == b` | `c.eq.fmt a,b` | `bc1t` |
| `a != b` | `c.eq.fmt a,b` | `bc1f` |
| `a < b` | `c.olt.fmt a,b` | `bc1t` |
| `a <= b` | `c.ole.fmt a,b` | `bc1t` |
| `a > b` | `c.olt.fmt b,a` | `bc1t` |
| `a >= b` | `c.ole.fmt b,a` | `bc1t` |

```
        c.olt.d $f4, $f6
        li      $t0, 1
        bc1t    fn_f.c3
        li      $t0, 0
fn_f.c3:
```

- With a NaN operand every comparison is false except `!=`, which is C's
  rule.
- **`c.olt` / `c.ole` rather than `c.lt` / `c.le`:** the "ordered,
  quiet" forms raise no invalid-operation exception on a quiet NaN.
  spim prints `Exception 15 [Floating point] occurred and ignored` on
  **stdout** for `c.lt` / `c.le` with a NaN (section 1.1), which would
  corrupt the program's output. gcc's SSE comparisons do not trap either.
  Test 71 compares NaN, infinities and -0.0.

### 5.5 Conversions

| IR | MIPS |
|---|---|
| `cvt.s.w` / `cvt.d.w` | `mtc1 a,$f4` ; `cvt.s.w / cvt.d.w d,$f4` |
| `cvt.d.s` / `cvt.s.d` | `cvt.d.s` / `cvt.s.d d,a` (round to nearest) |
| `trunc.w.s` / `trunc.w.d` | `trunc.w.s / trunc.w.d $f6,a` ; `mfc1 d,$f6` |

- `trunc` rounds **toward zero**, which is C's float-to-int conversion,
  regardless of the FPU rounding mode.
- An out-of-range conversion is undefined in C. The tests do not depend
  on it.
- Test 71 checks negatives, the int limits and `char` sign extension
  after a conversion.

### 5.6 Addresses, loads and stores

- `addr slot` gives `$fp` plus the slot's offset (section 3.1).
- `addr @g` and `faddr @f` give `la`, which spim expands to `lui` / `ori`.
- Loads and stores use displacement `0` off the address register. The IR
  has already folded member and index arithmetic into the address.
- `load.b` is `lb` and `store.b` is `sb` (the low byte).
- Floating loads and stores use `lwc1` / `ldc1` / `swc1` / `sdc1` with an
  integer address register and a floating value register, the IR's
  documented mixed form (IR-DESIGN.md section 15, invariant 9).

### 5.7 Control flow

- `goto` is `b`.
- `if` / `ifFalse` compare the condition with `$zero`. When the IR's
  condition is an immediate (from a constant condition such as
  `while (1)`), the branch is resolved at compile time: an unconditional
  `b`, or nothing.
- `switch` arrives from the IR as compare-and-branch chains (test 65).
- There are no delay slots to fill (section 1.1).

### 5.8 `blkcopy` and `memzero`

`blkcopy %d, %s, size N align A` must have **memmove semantics**
(IR-DESIGN.md section 8.12): source and destination may overlap. The
operands are first brought into `$t0` (destination) and `$t1` (source).

| case | lowering |
|---|---|
| `A >= 4`, `N` a multiple of 4, `N <= 16` | `lw $t3..$t6` from source (all loads), then `sw $t3..$t6` to destination |
| `N <= 4` (any alignment) | `lb $t3..$t6` (all loads), then `sb` |
| otherwise | `move $a0,$t0` ; `move $a1,$t1` ; `li $a2,N` ; `jal __rt_memmove` |

- **Small copies cannot be hurt by overlap**, because every byte is read
  before any is written.
- **`__rt_memmove`** (`rt_core.s`) copies forwards when `dst <= src` and
  backwards otherwise, a word at a time when both pointers and `N` are
  word-aligned. It uses only `$a*`, `$t0`–`$t2` and `$v0`, and no stack.
- **The outgoing area is safe.** A `blkcopy` between two `param`s cannot
  happen (section 4.1). A struct copy inside the prologue happens before
  any argument is set up.

`memzero %d, N` (zero-filling a local before a partial initializer) is
`sb $zero` for each byte when `N <= 16`, and otherwise
`jal __rt_bzero`, which clears a word at a time when aligned.

Tests 28, 29 and 60 copy structs of many sizes, both inline and through
`__rt_memmove`. Tests 06, 36 and 46 zero-fill local arrays and structs
with partial initializers.

### 5.9 `param`, `call` and `return`

These are described in section 4.

- **A call result** is stored from `$v0` (or `$f0`) to the destination's
  home, or moved to its physical register. `$v0` / `$f0` are not used for
  anything else in between.
- **A call with no `%d =`** (result unused) simply ignores `$v0`.
- **`return %v` in an sret function** returns the sret pointer in `$v0`
  (IR-DESIGN.md section 9.2).
- **`return` with an immediate** uses `li $v0,…`. Floating immediates
  never occur, because the IR loads floating constants from the pool.

---

## 6. Naming and labels

Assembly names are prefixed, so no user identifier can collide with a
mnemonic, a register name, a directive, a runtime routine or a label of
the exception handler:

| what | assembly name | example |
|---|---|---|
| user function `f` | `fn_f` | `fn_main`, `fn_avg` |
| user global `g` | `gv_g` | `gv_counter` |
| string literal / float constant (IR `@.strN`, `@.fcN`) | `d.strN`, `d.fcN` | `d.str0` |
| IR label `.Ln` in function `f` | `fn_f.Ln` | `fn_avg.L4` |
| internal label (division, float compare) | `fn_f.cN` | `fn_q.c0` |
| epilogue | `fn_f.ret` | |
| main's address-constant flag (section 7.4) | `fn_main.fixed`, `fn_main.fixdone` | |
| runtime function `x` | `__rt_x` | `__rt_printf`, `__rt_malloc` |
| runtime global `x` / string | `__rtg_x` / `__rtd.strN` | `__rtg_rt_files` |
| entry stub | `main` (the only unprefixed name) | |

- **Labels are unique** because IR labels are unique within a function and
  are prefixed by the function's (unique) name, and internal labels use a
  per-function counter.
- **The C identifier character set is `[A-Za-z_0-9]`, a subset of what
  spim accepts in a label.**
- **User names cannot be confused with runtime names.** Names starting
  with `__rt` cannot arise from user code: user names are always
  `fn_` / `gv_`. A builtin such as `printf` is not defined by the user
  program, so a call to it becomes `__rt_printf`.
- **Test 69** uses identifiers spelled like mnemonics (`add`, `lw`, `jal`,
  `syscall`, `move`, `mul`), registers (`t0`, `sp`, `ra`, `f12`),
  directives (`data`, `text`, `word`, `asciiz`, `globl`), a runtime name
  (`__rt_printf`) and the prefixes themselves (`fn_main`, `gv_add`). They
  appear as globals, functions, parameters, locals, struct members and
  goto labels.

---

## 7. Data

### 7.1 Layout

Every IR data object is emitted as follows:

```
        .data
        .align  lg2(align)
gv_g:           # C type, size
        <pieces>
```

- The `.align` comes from the IR's `align`, so an `int` is 4-aligned and a
  `double` (or a struct containing one) is 8-aligned. This matches the
  IR's model (IR-DESIGN.md section 2): `char` 1, `int` 4, pointer 4,
  `float` 4, `double` 8 with alignment 8.
- Every `init.*` piece maps one-to-one:

| IR | MIPS |
|---|---|
| `init.word V` | `.word V` |
| `init.byte V` | `.byte V` |
| `init.zero N` | `.space N` (spim zero-fills) |
| `init.addr @g` | `.word gv_g` |
| `init.faddr @f` | `.word fn_f` |
| `init.float V` | `.float %.9e` (section 7.3) |
| `init.double V` | `.double %.17e` (section 7.3) |
| `init.addr @g+N` | `.word 0` plus a startup store (section 7.4) |

The pieces' widths sum to the object's size (IR invariant 7), so the next
object's `.align` is the only padding.

### 7.2 Strings

A string literal is written with `.asciiz "…"` only when every byte is
printable ASCII (32–126) other than backslash, or is `\n` or `\t`; `"` is
escaped as `\"`. Any other string is written as a `.byte` list, ending in
its NUL.

*Why:* spim's `.asciiz` turns `\\` into two backslashes and rejects octal
escapes (section 1.1). A string with a backslash, a control character, a
byte above 126 or an embedded NUL therefore cannot be expressed with it
reliably.

Test 73 has every escape (simple, octal, hex, `\0` inside a string,
`\377`) and strings containing assembler syntax (`"# not a comment"`,
`"label:"`, `".word"`, quotes and backslashes).

### 7.3 Floating constants

- A finite `float` or `double` other than `-0.0` is written as
  `.float %.9e` / `.double %.17e`. That is enough digits to identify the
  value, and spim's reader (strtod) returns the identical bits. This was
  checked for normal, subnormal and extreme values. The bit pattern is
  repeated in a comment.
- An infinity, a NaN or `-0.0` is written as its bit pattern:
  `.word 0x7ff00000`, or for a double `.word lo, hi` (low word first,
  little-endian). spim's `.double` cannot express these.

### 7.4 Address constants with an offset

An initializer such as `int *p = &a[2];` gives `init.addr @a+8`
(IR-DESIGN.md section 16). spim's `.word` accepts only a bare symbol, so
such a word is assembled as `.word 0` with a comment naming its value.
`fn_main` then stores the real address at startup:

```
        .data
fn_main.fixed:  .word 0         # address constants stored yet?
        .text
        .globl fn_main
fn_main:
        # store the address constants with an offset (data words above)
        la      $t0, fn_main.fixed
        lw      $t1, 0($t0)
        bne     $t1, $zero, fn_main.fixdone
        li      $t1, 1
        sw      $t1, 0($t0)
        la      $t0, gv_a
        addiu   $t0, $t0, 8
        la      $t1, gv_p
        sw      $t0, 0($t1)
fn_main.fixdone:
        sw      $ra, -4($sp)    # the normal prologue follows
```

- The stores run **before** main's prologue, so they cannot disturb its
  frame.
- They use only `$t0`, `$t1` and `$t7`, so argc and argv in `$a0` / `$a1`
  are intact.
- The flag makes a recursive call of `main` skip them.
- No code runs before `fn_main` that could read such a word.
- Test 73 has `&a[2]`, `&a[1][1]` and `&s.m[1]` initializers alongside
  plain `&g` and a bare array name.

---

## 8. Runtime

The runtime is the C library subset of the language (IR-DESIGN.md
section 13): `printf scanf sprintf sscanf puts putchar getchar malloc
calloc realloc free exit abs atoi strlen strcpy strncpy strcat strcmp
strncmp strchr memset memcpy fopen fclose fprintf fscanf fgets fputs fgetc
fputc feof rewind remove`.

It is written into the same `.s` file as the program, after it. A program
gets **only the routines it uses**.

### 8.1 Construction and linking

- **`src/runtime/rt_core.s`** is hand-written assembly:
  - the entry stub `main`
  - the syscall wrappers
  - `exit`
  - `__rt_divzero`
  - `__rt_memmove` and `__rt_bzero`
  - the six variadic entry points (section 4.2)
- **`src/runtime/rt_lib.c`** is everything else, written in **the
  compiler's own source language** and compiled by the compiler itself.
  - The makefile builds a first compiler (`build/stage0`) with an empty
    runtime.
  - It runs `stage0 --runtime -O1 src/runtime/rt_lib.c` to get
    `build/rt_lib.s`.
  - It embeds both assembly files as string literals in
    `build/rt_table.cpp`, and links the final `build/mipscc` with them.

  The runtime is thus itself a large test of the compiler. In runtime
  mode every function becomes `__rt_name` and every global `__rtg_name`,
  so `printf` in the user program and in the library are the same symbol.
- **Both files are cut into units** at `# @unit NAME` lines: one per
  function, per global and per string in `rt_lib.s`, and one per routine
  in `rt_core.s`. Each unit states its own `.text` / `.data`.
- **Linking** (`linkRuntime` in `src/mips.cpp`):
  1. Start from every name the program mentions outside comments, plus
     `main`.
  2. Add, transitively, every unit whose name an included unit mentions.
     A unit's references to labels it defines itself (such as
     `__rt_divzero_msg`) are local.
  3. Write the included units in their original order.

  A reference to an `__rt_` name that no unit defines is a compiler error,
  never an assembler error at run time. The "hello world" of the README
  pulls in the printf units only; a program without file I/O contains no
  file code and no `rt_files` table.

**The entry stub:**

```
main:   li      $t0, -8
        and     $sp, $sp, $t0          # spim enters with $sp only 4-aligned
        addiu   $sp, $sp, -16          # home area for fn_main's $a0-$a3
        jal     fn_main                # argc, argv still in $a0, $a1
        move    $a0, $v0
        li      $v0, 17                # exit2: status = main's result & 0xff
        syscall
```

`exit(n)` is syscall 17 with `n`. `main`'s `argc` / `argv` are spim's
(section 1.1).

### 8.2 Agreement with irsim

The behaviour of every routine is that of `tools/irsim.cpp` (the Stage 3
IR interpreter). irsim in turn was made to match glibc as seen by
`gcc -m32`. The listed divergences in irsim were fixed in this stage's
copy (see the report).

`tools/difftest.sh` runs every test under:

- gcc
- irsim
- spim at `-O0`
- spim at `-O1`

and requires byte-identical standard output and the same exit status.

### 8.3 printf

Supported: flags `- + space # 0`; field width and precision (literal or
`*`, a negative `*` width meaning `-`); length modifiers `h hh l ll L z j
t` (accepted, and ignored except that `h` / `hh` narrow the value as
glibc does); conversions
`d i u o x X c s p f F e E g G a A %`.

- `%u %o %x` treat the 32-bit word as unsigned. This is done with masks,
  because the source language has no unsigned type.
- `%p` prints `0x` followed by the address in hex, as irsim does. Flags
  and width are ignored, and a null pointer prints `0x0` where glibc
  prints `(nil)`. Addresses differ between gcc and spim anyway, so no test
  prints one.
- **Floating conversions are exact.**
  - `fd_decode` takes the double apart into sign, exponent and 53-bit
    mantissa, and expands it into a big decimal number with
    multiply-and-add over 32-bit limbs (`fd_mul`, `fd_add`).
  - `fd_round` rounds the decimal digits at the requested position, with
    ties going to even exactly as glibc does (the value is exact, so a tie
    is a true tie).
  - `%f %e %g` (with `#`, and `%g`'s trailing-zero removal) and `%a`
    (hex, glibc's normalisation) are then formatted from those digits.
  - The output is glibc's for every double, including subnormals, `1e300`
    in `%f`, `-0.0`, `inf` / `nan` (with sign, `INF` / `NAN` in upper
    case), and rounding ties such as `%.0f` of 0.5, 1.5 and 2.5.
- Output is collected in a 256-byte buffer and written with one `write`
  syscall per call (or per 256 bytes). `sprintf` writes into the caller's
  buffer.

Test 67 covers the edge cases. Every printf call in the suite agrees byte
for byte with glibc.

### 8.4 scanf, standard input and output

- `scanf` / `fscanf` / `sscanf` implement irsim's algorithm:
  - whitespace in the format skips any whitespace;
  - other literal characters must match;
  - `%d %i %u %o %x %X` (with `%i` / `%x` prefixes);
  - `%c %s` with widths;
  - `%f %e %g` (and `%lf`, which stores 8 bytes);
  - `%*` suppression;
  - `%%`;
  - the return value is the number of assignments, or `-1` at end of input
    before the first conversion.
- Integer conversions saturate like glibc's `strtol` with a 32-bit long.
- Floating input is converted **correctly rounded** (`dd_value`: exact
  big-number comparison), so `scanf("%lf")` of any decimal gives gcc's
  bits.
- Standard input is fd 0, read through the same 512-byte buffer as a file
  (`rt_stdin`), with one character of push-back. `getchar`, `scanf` and
  `fgetc` / `fgets` on a null `FILE *` share that buffer.
- **Output is unbuffered at the program level.** `putchar`, `puts`,
  `fputc` and `fputs` are one `write` each, and printf writes once per
  call. Nothing is lost at `exit` or at a runtime error, and stdout and
  stderr interleave as written.

Tests 19, 26, 38 and 70 cover this. The limitations are in the README.

### 8.5 Files: the `FILE *` representation

A `FILE *` is the **address of an entry of `struct rtfile rt_files[16]`**:

```c
struct rtfile {
    int  used;          /* 1 while open */
    int  fd;            /* spim/host file descriptor */
    int  flags;         /* open flags without O_TRUNC, for rewind */
    int  eof;           /* end-of-file indicator, sticky as in glibc */
    int  hasback, back; /* one character of push-back (scanf) */
    int  pos, len;      /* read buffer: buf[pos..len) */
    char buf[512];
    char name[256];     /* for rewind; "" if the name did not fit */
};
```

**Opening and closing:**

- At most 16 files are open at once.
- `fopen` takes modes `r w a`, each optionally with `+` (`b` is ignored).
  It returns 0 for an invalid mode, a full table or a failed open.
- `fclose` frees the entry.
- **An invalid `FILE *`** (null, closed, or not from `fopen`) is detected
  by `file_of`. `fgetc` and `fgets` read standard input, `fscanf` returns -1,
  output goes to stdout, `feof` returns 1, and `fclose` returns -1. This is
  irsim's behaviour. The language has no `stdin` / `stdout` names, so this
  is the only way to reach them through a `FILE *`.

**Writes are unbuffered**, one `write` syscall each. **Reads go through
the 512-byte buffer.** Test 68 writes lines longer than the buffer and
every byte value 0–255, and reads them back.

**What spim cannot do, and the workarounds:**

- **No `lseek`.** `rewind` closes the file and reopens it by name with its
  original flags minus `O_TRUNC`.
- **No `unlink`.** `remove(name)` truncates the file to 0 bytes and records
  the name (up to 8 names). A later `fopen(name, "r")` fails as if the
  file were gone, and `fopen(name, "w")` or `"a"` forgets the record. The
  program therefore behaves as if the file was removed, but **an empty
  file remains on disk** (README, limitations).

### 8.6 The heap

`malloc`, `calloc`, `realloc` and `free` are irsim's allocator, on top of
spim's `sbrk`:

- **Sizes are rounded up to 8.** `malloc(0)` is `malloc(1)`. A negative
  size or `sbrk` failure gives `runtime error: out of memory`, exit 70.
- **Each block has an 8-byte header `{size, tag}` in front of it.** Blocks
  are therefore 8-aligned, since sbrk returns 8-aligned memory and every
  request is a multiple of 8.
- **The tag is the block's address XOR a constant**, one constant for a
  used block and another for a free one. `free` and `realloc` reject a
  pointer that is not the start of a block: they print
  `runtime error: free() of a bad pointer` (or `realloc()`), or
  `runtime error: double free`, and exit 70.
- **Allocation is first fit by lowest address over the free list**, which
  is kept in address order. A block is reused whole, without splitting.
  When no free block fits, new memory comes from `sbrk`. Freed memory is
  never returned to the system.
- **`realloc`** keeps the block if it is already big enough; otherwise it
  allocates, copies the old block's contents and frees the old block.
  `calloc` zeroes the block with `__rt_bzero`.

Because the policy is irsim's, the same program gets the **same addresses
relative to the heap start** on both. Tests 64 and 75 check reuse order,
and test 75 also checks the error exits.

### 8.7 String and memory helpers

These are straightforward C in `rt_lib.c`, with glibc's results:

- `strcmp` / `strncmp` compare bytes as unsigned and return the
  difference, whose sign matches glibc's.
- `strncpy` NUL-pads and does not terminate a source that is too long.
- `memcpy` is `memmove`.

They are covered by tests 17 and 72.

---

## 9. `-O1`: register allocation

`-O1` changes **only where IR registers live**. The instruction selection
of section 5 is the same, so a program's output at `-O1` is identical to
`-O0`. `run.sh` and `difftest.sh` check this for every test.

1. **Liveness.** The IR of a function is split into basic blocks. The
   leaders are the first instruction, every label, and the instruction
   after a `goto`, `if`, `ifFalse` or `return`. Live-in and live-out sets
   are solved by the usual backward iteration to a fixed point.
2. **Intervals.** Each IR register gets one interval, from the first to
   the last instruction position where it is live, defined or used.
   Register parameters are live from position 0, where the prologue
   defines them.
3. **Linear scan** (Poletto & Sarkar), separately for the two classes:
   - integer registers into `$s0`–`$s7`;
   - float and double registers into `$f20`, `$f22`, …, `$f30` (an even
     register holds a double as a pair).

   When the pool is empty, the active interval that ends last is spilled
   if it ends after the current one. A spilled register keeps a stack home
   and is accessed through scratch, as in `-O0`.
4. **Only callee-saved registers are used**, so a value survives calls
   without caller-side saving. The prologue saves (and the epilogue
   restores) exactly the ones the function uses (section 3.1).

In the README's `avg` example, the loop shrinks from 58 instructions at
`-O0` to 23 at `-O1`.
`tools/check_asm.py` verifies on every `-O1` file that each callee-saved
register is saved before it is written and restored before `jr $ra`.

---

## 10. Verification

| check | what it does | where |
|---|---|---|
| `run.sh` | Compiles every `test/*.c` at `-O0` and `-O1`, runs it on spim with its args and stdin, and compares stdout and exit status with `test/expected/`. Every `test/errors/*.c` must give exactly Stage 3's diagnostics, exit 1, and leave no `.s` behind. | README |
| `tools/difftest.sh` | gcc `-m32 -msse2 -mfpmath=sse -malign-double` vs irsim vs spim `-O0` vs spim `-O1` vs the recorded output | section 8.2 |
| `tools/check_asm.py` | A static checker over every generated `.s` file (see below). | |
| `tools/check_comments.py` | Every function over 30 lines has a comment directly above it. | |
| `tools/memcheck.sh` (`make memcheck`) | The compiler built with AddressSanitizer and UBSan (`make asan`), and the normal build under valgrind, each run over every test, every rejected program, the runtime, and generated malformed inputs (random bytes, unterminated tokens, nesting at and beyond the 10000-level limit, truncated programs). | README §7 |

`tools/check_asm.py` checks the following:

- the header lines are present (section 1.2);
- each label is defined once, and every branch, `jal`, `la` and `.word`
  target is defined;
- every immediate is in range (section 3.4);
- for each function, a linear walk tracks `$sp` and the callee-saved
  registers. It checks that:
  - `$sp` is 8-aligned and leaves at least 16 bytes at every call
    (section 3.5);
  - `$sp` is back to its entry value at `jr $ra`;
  - every callee-saved register is saved before it is written and
    restored before `jr $ra`;
  - branches agree on the stack depth at each label;
  - no function falls through its end.

Each of these checks was shown to fire by mutating generated files.
