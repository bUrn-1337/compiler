#!/bin/sh
# tools/memcheck.sh -- run the compiler under AddressSanitizer/UBSan and under
# valgrind over every input: the test programs, the rejected programs, the
# runtime library, and a set of malformed inputs generated here.
#
#   tools/memcheck.sh [asan|valgrind|all]      (default: all)
#
# Malformed inputs (written to build/malformed/): an empty file, random
# bytes, base64 text, an unterminated string / comment / character constant,
# a NUL byte, 5000 nested parentheses, 3000 and 12000 nested blocks, sums of
# 9990 and 20000 terms (inside and beyond the nesting limit), and every
# test program cut off at 1/3 and at 1/2 of its length.
#
# Each input is compiled at -O0 and -O1 (with --emit-ir).  A run fails if the
# sanitizer or valgrind reports anything (valgrind: any error, or a definite
# or indirect leak) or if the compiler exits with a status other than 0, 1
# or 2 (i.e. a signal).  Prints one line per failure and the counts; exits 1
# if anything failed.  Builds build/mipscc and build/mipscc-asan first (make,
# make asan).  Needs valgrind and python3.  JOBS=N sets the parallelism (8).

set -u
B=build
M=$B/malformed
OUT=$B/memcheck
JOBS=${JOBS:-8}

# one run: $1 = tool (asan|valgrind), $2 = source, $3 = -O level
one() {
    tool=$1; f=$2; o=$3
    id=$(printf '%s' "$tool$f$o" | md5sum | cut -c1-12)
    extra=
    case $f in *rt_lib.c) extra=--runtime ;; esac
    if [ "$tool" = asan ]; then
        ASAN_OPTIONS=detect_leaks=1 UBSAN_OPTIONS=print_stacktrace=1:halt_on_error=1 \
            ./$B/mipscc-asan $extra $o "$f" -o $OUT/$id.s --emit-ir=$OUT/$id.ir \
            >/dev/null 2>$OUT/$id.err
        rc=$?
        pat='AddressSanitizer|LeakSanitizer|runtime error'
    else
        valgrind -q --error-exitcode=99 --leak-check=full \
            --errors-for-leak-kinds=definite,indirect --max-stackframe=4000000 \
            ./$B/mipscc $extra $o "$f" -o $OUT/$id.s --emit-ir=$OUT/$id.ir \
            >/dev/null 2>$OUT/$id.err
        rc=$?
        pat='^==[0-9]+=='
    fi
    if [ $rc -gt 2 ] || grep -q -E "$pat" $OUT/$id.err; then
        echo "FAIL $tool $f $o (exit $rc, log $OUT/$id.err)"
    else
        echo "ok"
    fi
}

if [ "${1:-}" = --one ]; then
    one "$2" "$3" "$4"
    exit 0
fi
MODE=${1:-all}

make >/dev/null || exit 1
if [ "$MODE" != valgrind ]; then
    make asan >/dev/null || exit 1
fi

rm -rf "$M" "$OUT"
mkdir -p "$M" "$OUT"

: > $M/empty.c
head -c 3000 /dev/urandom > $M/random_bytes.c
head -c 600 /dev/urandom | base64 > $M/random_text.c
printf 'int main(void){ char *s = "abc' > $M/unterm_string.c
printf 'int main(void){ /* never closed\n return 0; }' > $M/unterm_comment.c
printf "int main(void){ char c = 'ab; return 0; }" > $M/bad_char.c
printf 'int main(void) { return 0; }\000garbage\n' > $M/nul_byte.c
python3 - "$M" <<'EOF'
import sys
m = sys.argv[1]
def w(name, text):
    open(m + '/' + name, 'w').write(text + '\n')
w('deep_parens.c', 'int main(void){ return ' + '(' * 5000 + '1' + ')' * 5000 + '; }')
w('deep_blocks.c', 'int main(void){ ' + '{' * 3000 + '}' * 3000 + ' return 0; }')
w('deep_blocks_over.c', 'int main(void){ ' + '{' * 12000 + '}' * 12000 + ' return 0; }')
w('long_sum_ok.c', 'int f(void){ return 1' + ' + 1' * 9990 + '; } int main(void){ return f(); }')
w('long_sum_over.c', 'int f(void){ return 1' + ' + 1' * 20000 + '; } int main(void){ return f(); }')
EOF
for f in test/*.c; do
    n=$(basename "$f" .c)
    sz=$(wc -c < "$f")
    head -c $((sz / 3)) "$f" > $M/cut3_$n.c
    head -c $((sz / 2)) "$f" > $M/cut2_$n.c
done

tools=
case $MODE in
    asan) tools=asan ;;
    valgrind) tools=valgrind ;;
    all) tools="asan valgrind" ;;
    *) echo "usage: $0 [asan|valgrind|all]" >&2; exit 2 ;;
esac

# the parallel workers are this script again, with --one TOOL FILE LEVEL
for t in $tools; do
    for f in test/*.c test/errors/*.c $M/*.c src/runtime/rt_lib.c; do
        printf '%s %s -O0\n%s %s -O1\n' "$t" "$f" "$t" "$f"
    done
done | xargs -P "$JOBS" -L 1 "$0" --one > $OUT/results.txt

grep '^FAIL' $OUT/results.txt
total=$(wc -l < $OUT/results.txt)
fails=$(grep -c '^FAIL' $OUT/results.txt)
printf 'memcheck (%s): %s runs, %s failed\n' "$MODE" "$total" "$fails"
[ "$fails" -eq 0 ]
