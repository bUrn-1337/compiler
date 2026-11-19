#!/bin/sh
# tools/difftest.sh -- three-way differential test: gcc vs irsim vs spim.
#
#   tools/difftest.sh [--record] [WORD...]
#
# For every test/*.c (or those whose name contains one of the WORDs) the
# program is run three ways, each with test/args/<name>.args as arguments and
# test/input/<name>.in (else /dev/null) as standard input, each in its own
# empty directory (so file tests do not see each other's files):
#
#   gcc    test/prelude.h + the program, built with
#          gcc -m32 -msse2 -mfpmath=sse -std=c99 (32-bit pointers, ints and
#          longs; SSE doubles, so no x87 extended precision);
#   irsim  the IR from `mipscc --emit-ir', run by build/irsim (the Stage 3
#          interpreter, with this stage's printf fixes);
#   spim   the assembly from mipscc at -O0 and at -O1, run by spim, with the
#          banner removed.
#
# Standard output must agree byte for byte and the exit status must agree,
# among all four runs and with the recorded test/expected/<name>.out/.rc.
# With --record the gcc result is first written to test/expected/ (used when
# a test is added; the recorded files are what run.sh checks without gcc).
#
# A test whose source contains the marker @no-gcc does something C leaves
# undefined (division by zero, INT_MIN / -1, a double free) to check the
# defined behaviour this compiler gives it; gcc is skipped and irsim is the
# reference instead.
#
# Needs: gcc with 32-bit support (sudo apt-get install -y gcc-multilib),
# python3, spim (SPIM=... to override), and `make tools' (build/irsim).

set -u
RECORD=no
if [ $# -gt 0 ] && [ "$1" = --record ]; then RECORD=yes; shift; fi

EXE=${EXE:-./build/mipscc}
SIM=${SIM:-./build/irsim}
SPIM=${SPIM:-spim}
TIMEOUT=${TIMEOUT:-120}
ROOT=$(pwd)
WORK=$ROOT/build/difftest

make >/dev/null && make tools >/dev/null || { echo "build failed"; exit 1; }
command -v "$SPIM" >/dev/null 2>&1 || { echo "spim not found (set SPIM=...)"; exit 1; }
rm -rf "$WORK"
mkdir -p "$WORK"

printf 'int main(void){return sizeof(void*)==4?0:1;}\n' >"$WORK/probe.c"
if ! gcc -m32 -msse2 -mfpmath=sse -o "$WORK/probe" "$WORK/probe.c" 2>/dev/null || ! "$WORK/probe"; then
    echo "gcc -m32 does not work here: sudo apt-get install -y gcc-multilib"
    exit 1
fi

pass=0
fail=0
failed=''

matches() {
    [ $# -eq 1 ] && return 0
    name=$1; shift
    for w in "$@"; do
        case "$name" in *"$w"*) return 0;; esac
    done
    return 1
}

# run DIR CMD... : runs CMD in a fresh DIR with the test's stdin and args;
# leaves stdout in DIR.out and the exit status in DIR.rc.
run_in() {
    d=$1; shift
    rm -rf "$d"; mkdir -p "$d"
    # shellcheck disable=SC2086
    (cd "$d" && timeout "$TIMEOUT" "$@" $args <"$input" >"$d.raw" 2>"$d.err")
    echo $? >"$d.rc"
}

for src in test/*.c; do
    name=$(basename "$src" .c)
    matches "$name" "$@" || continue
    t=$WORK/$name
    mkdir -p "$t"
    args=''
    [ -f "test/args/$name.args" ] && args=$(cat "test/args/$name.args")
    input=/dev/null
    [ -f "test/input/$name.in" ] && input=$ROOT/test/input/$name.in
    why=''

    ref=gcc
    grep -q '@no-gcc' "$src" && ref=irsim
    cat test/prelude.h "$src" >"$t/prog.c"
    if [ $ref = gcc ] &&
       ! gcc -m32 -msse2 -mfpmath=sse -malign-double -std=c99 -w -o "$t/prog" "$t/prog.c" -lm 2>"$t/gcc.err"; then
        why="gcc rejected it"
    elif ! "$EXE" "$src" -o "$t/O0.s" --emit-ir="$t/prog.ir" -O0 >"$t/cc.err" 2>&1 ||
         ! "$EXE" "$src" -o "$t/O1.s" -O1 >>"$t/cc.err" 2>&1; then
        why="mipscc rejected it"
    else
        if [ $ref = gcc ]; then
            run_in "$t/gcc" "$t/prog"
            cp "$t/gcc.raw" "$t/gcc.out"
        fi
        run_in "$t/irsim" "$ROOT/$SIM" "$t/prog.ir"
        cp "$t/irsim.raw" "$t/irsim.out"
        for o in O0 O1; do
            run_in "$t/$o" "$SPIM" -file "$t/$o.s"
            awk 'done { print; next } /^Loaded: / { done = 1 }' "$t/$o.raw" >"$t/$o.out"
        done
        if [ $RECORD = yes ]; then
            cp "$t/$ref.out" "test/expected/$name.out"
            cp "$t/$ref.rc" "test/expected/$name.rc"
        fi
        cp "test/expected/$name.out" "$t/rec.out" 2>/dev/null || : >"$t/rec.out"
        cp "test/expected/$name.rc" "$t/rec.rc" 2>/dev/null || echo 0 >"$t/rec.rc"
        for r in irsim O0 O1 rec; do
            [ $r = $ref ] && continue
            if ! cmp -s "$t/$ref.out" "$t/$r.out"; then
                why="$why stdout($ref!=$r)"
            elif ! cmp -s "$t/$ref.rc" "$t/$r.rc"; then
                why="$why rc($ref=$(cat "$t/$ref.rc"),$r=$(cat "$t/$r.rc"))"
            fi
        done
    fi
    if [ -z "$why" ] && [ $ref = irsim ]; then
        printf 'PASS  %-28s (no gcc: C leaves it undefined) irsim = spim -O0 = spim -O1 = recorded (exit %s)\n' "$name" "$(cat "$t/irsim.rc")"
        pass=$((pass + 1))
    elif [ -z "$why" ]; then
        printf 'PASS  %-28s gcc = irsim = spim -O0 = spim -O1 = recorded (exit %s)\n' "$name" "$(cat "$t/gcc.rc")"
        pass=$((pass + 1))
    else
        printf 'FAIL  %-28s%s\n' "$name" "$why"
        fail=$((fail + 1))
        failed="$failed $name"
    fi
done

printf '\npassed: %s\nfailed: %s\n' "$pass" "$fail"
[ $fail -eq 0 ] || printf 'failing:%s\n(outputs in %s/<name>/)\n' "$failed" "$WORK"
[ $fail -eq 0 ]
