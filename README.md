# mipscc: a C-subset compiler for MIPS (SPIM)

`mipscc` compiles programs written in the course's C-like language into one
self-contained MIPS32 assembly file for the **SPIM** simulator. It does the
whole job in one run: it parses, does semantic analysis, generates three-address
IR (the Stage 3 front end, copied into `src/`), and generates MIPS code. The
`.s` file contains only the runtime routines the program uses: `printf`,
`scanf`, `malloc`, file I/O, string functions and so on. No other files or
libraries are needed when the program runs.

```
make
./build/mipscc prog.c            # writes prog.s
spim -file prog.s arg1 arg2 < input.txt
```

Design documents:
- [docs/MIPS-DESIGN.md](docs/MIPS-DESIGN.md): registers, frame layout, calling
  convention, how every IR operation is lowered, data layout, runtime.
- [docs/IR-DESIGN.md](docs/IR-DESIGN.md): the Stage 3 IR. Section 16 lists the
  changes made in this stage.

---

## 1. Simulator

| | |
|---|---|
| **Required simulator** | **SPIM** (command-line `spim`), **Version 8.0 of January 8, 2010**, Debian/Ubuntu package `spim 8.0+dfsg-7` |
| Install | `sudo apt-get install -y spim` |
| Run | `spim -file prog.s [arguments...] < input` |
| Standard input | the program's `stdin` is spim's stdin (redirect with `<`) |
| Arguments | words after `-file prog.s` become `argv[1..]`; `argv[0]` is the `.s` path |
| Exit status | `main`'s return value (or `exit`'s argument) `& 0xff`, through syscall 17 |
| Deep recursion | spim's default stack is about 256 KB; use `spim -lstack 4000000 -file prog.s` |

spim's default settings are assumed: pseudo-instructions on, no branch delay
slots, the default exception handler (its `__start` calls `main` with argc in
`$a0` and argv in `$a1`), and little-endian memory on an x86 host. Every
generated `.s` starts with a comment giving this information: the simulator
and version, the run command, and the assumptions.

**spim always prints a 5-line banner on stdout** before the program's output,
and `-quiet` does not remove it:

```
SPIM Version 8.0 of January 8, 2010
Copyright 1990-2010, James R. Larus.
All Rights Reserved.
See the file README for a full copyright notice.
Loaded: /usr/lib/spim/exceptions.s
```

`run.sh` strips these 5 lines before it compares output.

### QtSpim

QtSpim uses the same simulator core as spim, and the generated code relies only
on behaviour the two share: the default exception handler, standard syscalls
1–17, and no delay slots. To run a program in QtSpim:

1. In *Simulator → Settings*, keep the defaults: *Enable delayed branches* off,
   *Load exception handler* on, *Accept pseudo instructions* on.
2. Load the `.s` file with *File → Reinitialize and Load File*.
3. Put the command-line arguments, if any, in *Simulator → Run Parameters*.
4. Click *Run*. Program input is typed into the Console window.

**This was not tested**, because only command-line spim was available on the
development machine. Everything in this README was verified with command-line
spim 8.0.

---

## 2. Building

You need g++ (C++17), flex, bison, make and python3. Run spim (above) to execute
the output. You only need gcc with `-m32` (`sudo apt-get install -y
gcc-multilib`) for the optional gcc comparison in `tools/difftest.sh`.

```
make            # builds build/mipscc
make test       # ./run.sh: every test on spim
make check      # comment checker + static .s checker
make asan       # build/mipscc-asan with AddressSanitizer + UBSan
make memcheck   # tools/memcheck.sh: ASan/UBSan + valgrind over every input
make tools      # build/irsim, the IR interpreter
make clean      # removes build/
```

All generated files go in `build/`, and nothing is written into `src/`. The
build uses `-Wall -Wextra` with no warnings, and runs bison with
`-Wall -Werror`, so there are no grammar conflicts. The runtime library is
written in the source language itself
([src/runtime/rt_lib.c](src/runtime/rt_lib.c)), so the build has three steps:

1. Build `build/stage0/mipscc` with an empty runtime.
2. That compiler turns `rt_lib.c` into `build/rt_lib.s`.
3. `rt_lib.s` and [src/runtime/rt_core.s](src/runtime/rt_core.s) are embedded
   into the final `build/mipscc`.

## 3. Usage

```
usage: ./build/mipscc <source.c> [-o output.s] [--emit-ir[=file.ir]] [-O0|-O1]
  -o FILE         write the assembly to FILE (default: the source path
                  with its extension replaced by '.s')
  --emit-ir[=F]   also write the Stage 3 IR text (default: '.ir' next to
                  the assembly output)
  -O0             simple code: every IR register lives in a stack slot
                  (the default)
  -O1             allocate IR registers to $s0-$s7 / $f20-$f30
```

- **Default output name:** `dir/prog.c` → `dir/prog.s`. A name with no
  extension gets `.s` appended.
- **`-O0`** (the default) keeps every IR register in its own stack slot.
  **`-O1`** runs liveness analysis and a linear-scan register allocator over the
  same IR. Both levels produce the same program output on every test.
- **Exit status:** 0 on success; 1 on compile errors; 2 on a usage error or an
  unreadable input file.
- **Errors:** every error is reported, in the same format and with the same line
  and column as Stage 3. The compiler then exits with status 1 and writes no
  `.s` file; a stale output file from an earlier run is deleted. For example,
  [test/errors/e17_many_errors.c](test/errors/e17_many_errors.c):

  ```
  $ ./build/mipscc test/errors/e17_many_errors.c
  Semantic Error [Line 4, Col 6]: conflicting types for 'g' (previous declaration on line 3)
  ...
  16 errors found in 'test/errors/e17_many_errors.c'; no assembly written.
  $ echo $?
  1
  ```

---

## 4. Supported features and their tests

All tests are in [test/](test/). Each one runs at `-O0` and at `-O1`. The
expected stdout and exit code are stored in `test/expected/`. They were
recorded from `gcc -m32 -msse2 -mfpmath=sse`, checked against the IR
interpreter, and match spim output byte for byte.

| Feature | Tests |
|---|---|
| Integer arithmetic, `/` `%` (C truncation), shifts, bitwise ops, `INT_MIN` edge cases | 01, 48, 62 |
| Division by zero / `INT_MIN / -1`: defined, irsim-compatible behaviour (exit 70) | 74 |
| `&&` `\|\|` `!` with short-circuit evaluation, comparisons, `?:` | 02, 45, 66 |
| `if`/`else`, `while`, `do`, `for`, `break`/`continue`, `goto` | 03, 04, 16, 50 |
| `switch`: dense, sparse, fall-through, many cases | 05, 49, 65 |
| Arrays: 1-D, multi-D, initializers, large frames (offsets > 32767) | 06, 07, 21, 46, 63 |
| Pointers, pointer arithmetic, `sizeof`, casts, conversions | 08, 18, 44, 51, 53, 56 |
| Structs, unions, enums, typedefs, tags, nested declarators | 09, 10, 11, 41, 43, 47, 54, 57, 60 |
| Struct assignment, struct parameters and returns by value (sret), memmove-safe copies | 27, 28, 29, 36, 39 |
| Functions, recursion, more than 4 arguments, mixed int/double arguments | 12, 52, 58, 59 |
| Function pointers, indirect calls (`jalr`), callback tables | 30, 31, 40, 61 |
| `float`/`double`: FPU arithmetic, comparisons, conversions, arrays, math loops | 24, 25, 32, 33, 34, 35, 37, 71 |
| `malloc`/`calloc`/`realloc`/`free`, linked structures, heap misuse | 13, 20, 64, 75 |
| `argc`/`argv` | 14 |
| `fopen`/`fclose`/`fprintf`/`fscanf`/`fgetc`/`fputc`/`fgets`/`fputs`/`feof`/`rewind`/`remove` | 15, 68 |
| `scanf` (ints, chars, strings, doubles, EOF handling) | 19, 26, 38, 70 |
| `printf` edge cases: flags, width, precision, `*`, `%e`/`%g`/`%a` rounding | 67 |
| String library (`strlen`, `strcpy`, `strcmp`, `strcat`, `memcpy`, `memset`, ...), text processing | 17, 23, 72 |
| String-literal escapes, global initializers including `&g[i]` addresses | 73 |
| User names that clash with MIPS mnemonics or runtime names (`add`, `j`, `main.ret`, ...) | 69 |
| Sorting, mixed programs | 22, 40, 55 |
| Rejected programs: same diagnostics as Stage 3, exit 1, no `.s` | test/errors/e01–e25 |
| Nesting limit: more than 10000 levels gives a syntax error instead of a crash | test/errors/e26 |

### printf compatibility with gcc/glibc

The following printf features give **output identical to gcc/glibc**, and
`test/67_printf_edges.c` checks them (the full list of probes is in
MIPS-DESIGN §8.3):

- conversions `%d %i %u %o %x %X %c %s %f %F %e %E %g %G %a %A %%`
- flags `-` `+` space `#` `0`, in any combination
- field width and precision, given literally or with `*`, including a negative
  `*` width (left-justify) and a negative `*` precision (ignored)
- correct decimal rounding of `%f`/`%e`/`%g` for every double: values are
  converted exactly, and ties round to even as glibc does; `inf`, `nan`, `-0`
- the `h` and `hh` length modifiers narrow the value as in C
- `l`, `z`, `j` and `t` are accepted and ignored, because every integer is 32
  bits, so `%ld` behaves like `%d`
- unknown conversions such as `%y` and `%5%` are printed literally, as glibc
  does

The following are **not identical**:

| Format | mipscc | gcc/glibc |
|---|---|---|
| `%p` | `0x` + hex digits; flags and width ignored; null prints `0x0` | `(nil)` for null; honours width. Addresses differ anyway |
| `%n` | printed literally, stores nothing | stores the count |
| `%m` | printed literally | `strerror(errno)` |
| `%2$d` (positional) | printed literally | supported |
| `'` and `I` flags, `%C %S %lc %ls` | not supported | locale/wide-char features |
| `%lld %Lf` | treated as `%d`/`%f` | the language has no 64-bit or `long double` types, so these do not apply |
| `%q` | printed literally | a glibc synonym for `%ll` |

---

## 5. Limitations

- **Language:** what Stage 3 accepts and no more. There are no unsigned or
  64-bit integer types, and no `long double`. A global initializer of the form
  `a + 1` (pointer arithmetic on an array name) is rejected with Stage 3's
  diagnostic, while `&a[1]` works (test 73).
- **scanf:** supports `%d %i %u %o %x %X %c %s %f %e %E %g %G` (and `%lf` etc.)
  and `%%`, with widths and `*` assignment suppression. It does not support
  `%[...]`, `%n`, `%p` or `%a`, and stops at the first conversion it does not
  support. Field widths are ignored for floating conversions. `%hd`/`%hhd`
  store a full `int`.
- **Files:** at most 16 open files. spim has no `lseek` or `unlink` syscall,
  so:
  - `rewind` reopens the file by name;
  - `remove` truncates the file to zero length rather than deleting it. The
    runtime remembers the name, so a later `fopen(name, "r")` in the same run
    fails as it would after a real delete, but an empty file is left on disk;
  - `rewind` does not work on a file whose name is 255 characters or longer.

  Output is not buffered across calls: each output call (`printf`, `fprintf`,
  `fputs`, `fputc`, ...) finishes its `write` syscalls before it returns.
  Nothing is lost if the program exits without calling `fclose`.
- **Nesting:** expressions and statements may nest at most 10000 levels deep,
  for example a sum of 10000 terms. Deeper programs are rejected with a syntax
  error (test e26). Bison's parser stack has the same 10000 limit for
  parentheses and braces, and reports it as "memory exhausted".
- **Stack:** spim's default stack is about 256 KB. Deep recursion or very large
  local arrays need `-lstack`.
- **Heap:** first-fit allocation that reuses a free block whole, without
  splitting it, the same as the IR interpreter, so heavy churn can use more memory than glibc
  would. Heap misuse that is detected, such as freeing an invalid pointer or
  freeing twice, prints a message and exits with status 70, as irsim does
  (test 75).
- **Floating point:** float printing is exact. Calls between functions pass
  doubles in integer registers or on the stack, not in `$f12`/`$f14` (see
  "Calling convention" below). Comparisons involving NaN give C's results:
  they use the ordered `c.olt`/`c.ole`, because spim's signalling `c.lt`
  prints "Exception 15" for a NaN operand.
- **Execution speed:** spim is slow. The whole test suite takes about 30 s.

### Calling convention

The calling convention is close to o32 but not identical:
- arguments are packed like a struct: 4-byte words, with doubles aligned to 8;
- the first 16 bytes go in `$a0`–`$a3` and the rest on the stack at `16($sp)`;
- no FP argument registers are used;
- a struct argument is passed as the address of the caller's object, and the
  callee copies it;
- a returned struct is written through a hidden first argument (sret);
- results come back in `$v0` or `$f0`;
- `$fp` is the frame base.

The full details and the reasons are in MIPS-DESIGN §4. Only code produced
by mipscc can call code produced by mipscc.

---

## 6. Directory layout

```
makefile            build rules (all output in build/)
run.sh              test driver: ./run.sh [COMPILER] [WORD...]
README.md           this file
src/                the compiler
  lexer.l parser.y    Stage 3 lexer and grammar
  ast.* sema.*        AST and semantic analysis (Stage 3 diagnostics)
  ir.* irgen.*        three-address IR and its generator (Stage 3, with the fixes in IR-DESIGN §16)
  mips.* main.cpp     MIPS back end, -O1 register allocator, runtime linker, driver
  runtime/rt_core.s   hand-written runtime: entry stub, syscalls, variadic stubs, memmove/bzero
  runtime/rt_lib.c    runtime in the source language: printf, scanf, heap, FILE, strings
test/               75 programs + test/errors/ (26 rejected programs)
  expected/           <name>.out, <name>.rc
  input/  args/       stdin and command-line arguments for some tests
  prelude.h           declarations prepended for the gcc reference build
tools/              verification tools (not part of the compiler)
docs/               MIPS-DESIGN.md, IR-DESIGN.md, example/avg.c
build/              everything generated (make clean removes it)
```

## 7. Scripts and tools

| Command | What it does |
|---|---|
| `./run.sh [COMPILER] [WORD...]` | Compiles every `test/*.c` at `-O0` and `-O1`, runs each on spim with its args and input, and compares stdout and exit code with `test/expected/`. Checks that every `test/errors/*.c` is rejected with exactly the expected diagnostics, exit 1, and no `.s`. Prints `PASS`/`FAIL` per test and the passed/failed counts. A failure gives the reason: compiler error, compiler crash (with the signal), no assembly written, timeout, spim error, wrong stdout (with a diff), or wrong exit status. It includes an excerpt of the relevant log. Each run writes to its own new directory `build/run/<date>-<time>-XXXXXX/`, so several runs can go at once; the directory is printed at the start and end, and `build/run/latest` links to the newest. The newest 10 runs are kept (`KEEP_RUNS`). Environment variables: `SPIM`, `OPTS`, `TIMEOUT`, `KEEP_RUNS`. |
| `tools/difftest.sh [--record] [WORD...]` | Three-way differential test: gcc `-m32 -msse2 -mfpmath=sse` vs irsim (IR interpreter) vs spim at `-O0` and `-O1`. Needs gcc-multilib and `make tools`. |
| `tools/check_asm.py [FILE.s...]` | Static checker for the generated `.s`: header comment, unique and defined labels, 16-bit immediate ranges, `$sp` balance and 8-byte alignment at every call, frame accesses inside the frame, data alignment. |
| `tools/memcheck.sh [asan\|valgrind\|all]` | Compiles every test, every rejected program, the runtime, and about 160 generated malformed inputs at `-O0` and `-O1`, both with `build/mipscc-asan` (AddressSanitizer + UBSan) and under valgrind (memory errors and leaks). The malformed inputs are random bytes, unterminated tokens, deep nesting, and truncated programs. Fails on any report or on a crash. Last result: 1056 runs, 0 failures. Takes about 6 minutes with 8 jobs. |
| `tools/check_comments.py` | Reports every function longer than 30 lines that has no comment directly above it (currently 0). |
| `tools/ircheck.py FILE.ir` | Structural and type checker for IR text. |
| `build/irsim FILE.ir [args]` | The Stage 3 IR interpreter, used as the reference in difftest. |

---

## 8. Worked example

[docs/example/avg.c](docs/example/avg.c):

```c
/* average of the positive entries of an array */
double avg(int *a, int n) {
    int i, k;
    double s;
    s = 0.0;
    k = 0;
    for (i = 0; i < n; i++)
        if (a[i] > 0) { s = s + a[i]; k++; }
    return k ? s / k : 0.0;
}

int main(void) {
    int v[5] = {4, -2, 7, 0, 10};
    printf("%.3f\n", avg(v, 5));
    return 0;
}
```

```
$ ./build/mipscc docs/example/avg.c -o build/avg.s --emit-ir=build/avg.ir
$ spim -file build/avg.s | tail -n +6
7.000
```

**IR** (`build/avg.ir`, excerpt):

```
func @avg ret double retctype "double" nparams 2 frame 0 regs 26 temps 21    ; line 2
  .param 0 a : type ptr ctype "int *" size 4 align 4 reg %a
  .param 1 n : type int ctype "int" size 4 align 4 reg %n
  ...
begin
  %t5 = addr @.fc0   ; line 5
  %t6 = load.d %t5   ; line 5
  %s = %t6   ; line 5
  %k = 0   ; line 6
  %i = 0   ; line 7
.L1:
  %t7 = %i < %n   ; line 7
  ifFalse %t7 goto .L4   ; line 7
  %t8 = %i * 4   ; line 8
  %t9 = %a + %t8   ; line 8
  %t10 = load.w %t9   ; line 8
```

**MIPS at `-O0`** (`build/avg.s`, excerpt). Every IR register has a home slot
below `$fp`, and each group of instructions follows a comment showing the IR
instruction it implements:

```
	.data
d.str0:		# .str0, 6 bytes
	.asciiz "%.3f\n"

	.data
	.align  3
d.fc0:		# double, 8 bytes
	.double 0.00000000000000000e+00	# 0x0000000000000000

	.text
fn_avg:
	sw      $ra, -4($sp)
	sw      $fp, -8($sp)
	move    $fp, $sp
	addiu   $sp, $sp, -168
	sw      $a0, 0($fp)
	sw      $a1, 4($fp)
	# param a : ptr at 0($fp)
	lw      $t0, 0($fp)
	sw      $t0, -12($fp)
	...
	# %t6 = load.d %t5   ; line 5
	lw      $t0, -36($fp)
	ldc1    $f4, 0($t0)
	sdc1    $f4, -48($fp)
	...
fn_avg.L1:
	# %t7 = %i < %n   ; line 7
	lw      $t0, -20($fp)
	lw      $t1, -16($fp)
	slt     $t0, $t0, $t1
	sw      $t0, -52($fp)
```

**MIPS at `-O1`** (`./build/mipscc -O1 docs/example/avg.c -o build/avg1.s`).
The frame-layout header above each function shows where every value is kept.
Here the loop runs entirely in registers: 23 instructions per iteration,
compared with 58 at `-O0`:

```
# function avg (line 2), returns double
# frame 72 bytes ($fp = $sp at entry):
#   0($fp)	param a (ptr, arrives in $a0)
#   4($fp)	param n (int, arrives in $a1)
#   -4($fp)	$ra
#   -8($fp)	caller's $fp
#   -16($fp)	saved $f20
#   ...
#   $s0	%a : ptr
#   $s1	%n : int
#   $s3	%i : int
#   $s2	%k : int
#   $f22	%s : double
...
fn_avg.L1:
	# %t7 = %i < %n   ; line 7
	slt     $s4, $s3, $s1
	# ifFalse %t7 goto .L4   ; line 7
	beq     $s4, $zero, fn_avg.L4
	...
	# %t15 = cvt.d.w %t14   ; line 8
	mtc1    $s5, $f4
	cvt.d.w $f20, $f4
	# %t16 = %s +.d %t15   ; line 8
	add.d   $f24, $f22, $f20
```

Every generated file follows the program with the runtime routines it uses,
here `__rt_printf` and its helpers. To regenerate these excerpts, run the
commands above.
