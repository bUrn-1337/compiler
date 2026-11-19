#!/bin/sh
# run.sh -- compile every test program with mipscc and run it on spim.
#
#   ./run.sh [COMPILER] [WORD...]
#
#   COMPILER  the compiler executable to test (default: ./build/mipscc, built
#             with `make' if missing).  Taken as the compiler when it is an
#             executable file; otherwise it is the first filter word.
#   WORD...   run only the tests whose name contains one of the words.
#
# Environment:
#   SPIM      the simulator command (default: spim)
#   OPTS      optimisation levels to test (default: "-O0 -O1")
#   TIMEOUT   seconds allowed per compile and per spim run (default: 120)
#   KEEP_RUNS how many earlier output directories to keep (default: 10)
#
# Output directory: every run gets its own fresh directory,
#   build/run/<date>-<time>-XXXXXX/      (made with mktemp -d, so unique)
# and build/run/latest is pointed at the most recent one.  Several run.sh
# can therefore run at the same time in the same checkout without touching
# each other's files.  The directory is printed at the start and at the end.
# A run is about 37 MB, so older directories are pruned: only the newest
# $KEEP_RUNS are kept, and a directory modified within the last hour is never
# removed (it may belong to a run still in progress).  `make clean' removes
# them all.  Inside a run's directory, per test and level:
#   NAME-O0.s     the assembly          NAME-O0.clog  compiler messages
#   NAME-O0.raw   spim's whole stdout   NAME-O0.out   stdout without banner
#   NAME-O0.err   spim's stderr         NAME-O0.diff  diff when stdout differs
#   work/NAME-O0/ the program's working directory (files it creates)
# and for each rejected program NAME.log (compiler output), NAME.diags (the
# normalised diagnostics) and NAME.diff.
#
# Positive tests: every test/*.c.  Each is compiled at each level of $OPTS and
# run as   spim -file prog.s ARGS < INPUT   in its own empty working
# directory, where ARGS is the contents of test/args/<name>.args (if present)
# and INPUT is test/input/<name>.in (else /dev/null).  spim's 5-line banner
# (up to the "Loaded: ..." line) is removed; the rest of stdout must equal
# test/expected/<name>.out byte for byte and the exit status must equal
# test/expected/<name>.rc.  An assembler/simulator error message from spim
# (parser error, undefined symbol, exception) is a failure too.  A failure
# says what went wrong -- compiler error, compiler crash, no assembly
# written, timeout, spim killed, missing output, wrong output, wrong exit
# status -- with the exit status and an excerpt of the relevant log.
#
# Negative tests: every test/errors/*.c must be rejected with exit status 1,
# no .s file left behind, and EXACTLY the diagnostics of
# test/errors/<name>.expected (normalised to "line:col: Kind: message" as in
# Stage 3).
#
# Exit status: 0 if every test passed, 1 otherwise (also for a setup error).
# No gcc is needed: the expected outputs are stored in test/.  (They were
# produced by gcc -m32 and cross-checked with the IR interpreter; see
# tools/difftest.sh.)

set -u

EXE=./build/mipscc
if [ $# -gt 0 ] && [ -f "$1" ] && [ -x "$1" ]; then
    EXE=$1
    shift
fi
SPIM=${SPIM:-spim}
OPTS=${OPTS:-"-O0 -O1"}
TIMEOUT=${TIMEOUT:-120}
KEEP_RUNS=${KEEP_RUNS:-10}

for tool in timeout mktemp awk diff cmp; do
    command -v "$tool" >/dev/null 2>&1 ||
        { echo "run.sh: required command '$tool' not found"; exit 1; }
done

ROOT=$(pwd)
mkdir -p "$ROOT/build/run" || { echo "run.sh: cannot create build/run"; exit 1; }

# Build the default compiler if it is missing.  Two runs started together
# would both run make, so the build is serialised with a lock when flock(1)
# is available; the second waits and then finds the compiler built.
if [ "$EXE" = ./build/mipscc ] && [ ! -x "$EXE" ]; then
    echo "building $EXE first..."
    if command -v flock >/dev/null 2>&1; then
        flock "$ROOT/build/.run-make.lock" sh -c '[ -x ./build/mipscc ] || make >/dev/null'
    else
        make >/dev/null
    fi || { echo "run.sh: build failed (run make to see why)"; exit 1; }
fi
[ -f "$EXE" ] && [ -x "$EXE" ] || { echo "run.sh: compiler '$EXE' not found or not executable"; exit 1; }
case $EXE in /*) ;; ./*) EXE=$ROOT/${EXE#./} ;; *) EXE=$ROOT/$EXE ;; esac
if ! command -v "$SPIM" >/dev/null 2>&1; then
    echo "run.sh: simulator '$SPIM' not found (sudo apt-get install -y spim, or set SPIM=...)"
    exit 1
fi

# This run's own output directory, and build/run/latest pointing at it (the
# link is replaced by an atomic rename, so concurrent runs cannot break it).
OUT=$(mktemp -d "$ROOT/build/run/$(date +%Y%m%d-%H%M%S)-XXXXXX") ||
    { echo "run.sh: cannot create an output directory under build/run"; exit 1; }
chmod 755 "$OUT"
mkdir -p "$OUT/work"
ln -s "$(basename "$OUT")" "$OUT.latest" 2>/dev/null &&
    { mv -T "$OUT.latest" "$ROOT/build/run/latest" 2>/dev/null || rm -f "$OUT.latest"; }
echo "outputs: $OUT/"

# Prune old run directories (names sort by time; see the header).
case $KEEP_RUNS in ''|*[!0-9]*) KEEP_RUNS=10 ;; esac
ls -d "$ROOT"/build/run/[0-9]*-[0-9]*-*/ 2>/dev/null | sort -r | tail -n +$((KEEP_RUNS + 2)) |
while read -r old; do
    old=${old%/}
    [ "$old" = "$OUT" ] && continue
    [ -n "$(find "$old" -maxdepth 0 -mmin +60 2>/dev/null)" ] && rm -rf "$old"
done

pass=0
fail=0
failed=''

matches() {
    [ $# -eq 1 ] && return 0
    m_name=$1; shift
    for m_word in "$@"; do
        case "$m_name" in *"$m_word"*) return 0;; esac
    done
    return 1
}

# Stage 3's normal form of the diagnostics in a compiler log.
diags_of() {
    sed -n -e 's/^\(Lexical\|Syntax\|Semantic\) Error \[Line \([0-9]*\), Col \([0-9]*\)\]: \(.*\)$/\2:\3: \1: \4/p' \
           -e 's/^\(Lexical\|Syntax\|Semantic\) Error \[Line \([0-9]*\)\]: \(.*\)$/\2:-: \1: \3/p' \
           -e 's/^\(Lexical\|Syntax\|Semantic\) Error: \(.*\)$/-:-: \1: \2/p' "$1"
}

# Program output without spim's banner (everything after "Loaded: ...").
strip_banner() {
    awk 'done { print; next } /^Loaded: / { done = 1 }' "$1"
}

# Describes the compiler's exit status, which is 0, 1 or 2 when it ends
# normally; anything else is timeout(1)'s 124 or a signal (128 + N).
compiler_status() {
    if [ "$1" -eq 124 ] && grep -q '^timeout: sending signal' "$2"; then
        echo "timed out after ${TIMEOUT}s"
    elif [ "$1" -gt 128 ]; then echo "crashed: killed by signal $(($1 - 128)) (exit status $1)"
    else echo "exit status $1"
    fi
}

# Describes spim's exit status.  The program's own exit status can be
# anything from 0 to 255 (test 62 exits with 253), so a value above 128 is
# only *possibly* a signal; a timeout is recognised by timeout(1)'s message.
spim_status() {
    if [ "$1" -gt 128 ]; then
        echo "exit status $1 (signal $(($1 - 128)) if spim itself was killed)"
    else echo "exit status $1"
    fi
}

# Prints an indented excerpt (12 lines) of each existing, non-empty FILE,
# each under the given heading:  excerpt HEADING FILE [HEADING FILE...]
excerpt() {
    while [ $# -ge 2 ]; do
        if [ -s "$2" ]; then
            printf '        %s (%s):\n' "$1" "$2"
            head -n 12 "$2" | sed 's/^/        | /'
        fi
        shift 2
    done
}

# Records a failure: report_fail NAME REASON [HEADING FILE...]
report_fail() {
    printf 'FAIL  %-30s %s\n' "$1" "$2"
    f_name=$1; shift 2
    excerpt "$@"
    fail=$((fail + 1))
    failed="$failed $f_name"
}

# Compiles, runs and checks one positive test at one level:
#   run_one NAME SRC OPT EXPECTED_OUT EXPECTED_RC ARGS INPUT
# (sh has no local variables, so this function's all start with r_.)
run_one() {
    r_name=$1; r_src=$2; r_opt=$3; r_exp=$4; r_exprc=$5; r_args=$6; r_input=$7
    r_label="$r_name ($r_opt)"
    r_base="$OUT/$r_name$r_opt"
    r_work="$OUT/work/$r_name$r_opt"

    timeout --verbose "$TIMEOUT" "$EXE" "$r_src" -o "$r_base.s" "$r_opt" >"$r_base.clog" 2>&1
    r_crc=$?
    if [ $r_crc -eq 1 ]; then
        report_fail "$r_label" "does not compile (compiler exit status 1)" \
            "compiler output" "$r_base.clog"
        return
    elif [ $r_crc -ne 0 ]; then
        report_fail "$r_label" "compiler failed: $(compiler_status $r_crc "$r_base.clog")" \
            "compiler output" "$r_base.clog"
        return
    fi
    if [ ! -s "$r_base.s" ]; then
        report_fail "$r_label" "compiler exited 0 but wrote no assembly ($r_base.s)" \
            "compiler output" "$r_base.clog"
        return
    fi

    mkdir -p "$r_work"
    # shellcheck disable=SC2086  # the args are words
    (cd "$r_work" && timeout --verbose "$TIMEOUT" "$SPIM" -file "$r_base.s" $r_args \
         <"$r_input" >"$r_base.raw" 2>"$r_base.err")
    r_rc=$?
    if [ ! -f "$r_base.raw" ] || [ ! -f "$r_base.err" ]; then
        report_fail "$r_label" "spim produced no output files ($(spim_status $r_rc))"
        return
    fi
    if [ $r_rc -eq 124 ] && grep -q '^timeout: sending signal' "$r_base.err"; then
        report_fail "$r_label" "spim timed out after ${TIMEOUT}s" \
            "spim stderr" "$r_base.err" "spim stdout" "$r_base.raw"
        return
    fi
    if ! grep -q '^Loaded: ' "$r_base.raw"; then
        report_fail "$r_label" "spim did not load the program ($(spim_status $r_rc); no 'Loaded:' banner line)" \
            "spim stderr" "$r_base.err" "spim stdout" "$r_base.raw"
        return
    fi
    strip_banner "$r_base.raw" >"$r_base.out"
    if grep -qE '^spim: |Exception occurred|exception [0-9]|symbols are undefined|Instruction references undefined' \
            "$r_base.err" "$r_base.raw"; then
        report_fail "$r_label" "spim reported an error ($(spim_status $r_rc))" \
            "spim stderr" "$r_base.err" "program stdout" "$r_base.out"
    elif ! cmp -s "$r_exp" "$r_base.out"; then
        diff "$r_exp" "$r_base.out" >"$r_base.diff" 2>&1
        report_fail "$r_label" "stdout differs from $r_exp ($(spim_status $r_rc); < expected, > got)" \
            "diff" "$r_base.diff" "spim stderr" "$r_base.err"
    elif [ "$r_rc" != "$r_exprc" ]; then
        report_fail "$r_label" "$(spim_status $r_rc), expected exit status $r_exprc" \
            "spim stderr" "$r_base.err"
    else
        printf 'PASS  %-30s %s lines, exit %s\n' "$r_label" "$(wc -l <"$r_base.out")" "$r_rc"
        pass=$((pass + 1))
    fi
}

printf '%s\n' "================ positive tests (spim) ================"
for src in test/*.c; do
    [ -f "$src" ] || continue
    name=$(basename "$src" .c)
    matches "$name" "$@" || continue
    exp="$ROOT/test/expected/$name.out"
    rcfile="$ROOT/test/expected/$name.rc"
    if [ ! -f "$exp" ]; then
        report_fail "$name" "no expected output (missing $exp)"
        continue
    fi
    if [ ! -f "$rcfile" ]; then
        report_fail "$name" "no expected exit status (missing $rcfile)"
        continue
    fi
    exprc=$(tr -d ' \n' <"$rcfile")
    case $exprc in
        ''|*[!0-9]*) report_fail "$name" "bad expected exit status '$exprc' in $rcfile"; continue ;;
    esac
    args=''
    [ -f "test/args/$name.args" ] && args=$(cat "test/args/$name.args")
    input=/dev/null
    [ -f "test/input/$name.in" ] && input=$ROOT/test/input/$name.in
    for opt in $OPTS; do
        run_one "$name" "$ROOT/$src" "$opt" "$exp" "$exprc" "$args" "$input"
    done
done

printf '\n%s\n' "============ negative tests (must be rejected) ============"
for src in test/errors/*.c; do
    [ -f "$src" ] || continue
    name=$(basename "$src" .c)
    matches "$name" "$@" || continue
    exp="test/errors/$name.expected"
    asm="$OUT/$name.s"
    log="$OUT/$name.log"
    got="$OUT/$name.diags"
    if [ ! -f "$exp" ]; then
        report_fail "$name" "no expected-diagnostics file (missing $exp)"
        continue
    fi
    timeout --verbose "$TIMEOUT" "$EXE" "$src" -o "$asm" >"$log" 2>&1
    rc=$?
    : >>"$log"
    nerr=$(grep -cE '^(Lexical|Syntax|Semantic) Error' "$log")
    diags_of "$log" >"$got"
    ngot=$(wc -l <"$got")
    if [ $rc -ne 1 ]; then
        report_fail "$name" "compiler $(compiler_status $rc "$log"), expected exit status 1" "compiler output" "$log"
    elif [ -e "$asm" ]; then
        report_fail "$name" "rejected, but an assembly file was left behind ($asm)" "compiler output" "$log"
    elif [ "$nerr" -lt 1 ]; then
        report_fail "$name" "exit status 1 but no diagnostics printed" "compiler output" "$log"
    elif [ "$ngot" -ne "$nerr" ]; then
        report_fail "$name" "printed $nerr diagnostic(s) but $ngot could be parsed" "compiler output" "$log"
    elif ! diff -u "$exp" "$got" >"$OUT/$name.diff" 2>&1; then
        report_fail "$name" "diagnostics differ from $exp" "diff" "$OUT/$name.diff"
    else
        printf 'PASS  %-30s rejected with %s diagnostic(s), all as expected\n' "$name" "$nerr"
        pass=$((pass + 1))
    fi
done

printf '\n%s\n' "================ summary ================"
printf 'compiler:  %s\nsimulator: %s\nlevels:    %s\n' "$EXE" "$SPIM" "$OPTS"
printf 'passed: %s\nfailed: %s\n' "$pass" "$fail"
[ $fail -eq 0 ] || printf 'failing:%s\n' "$failed"
printf 'outputs are in %s/\n' "$OUT"
[ $fail -eq 0 ]
