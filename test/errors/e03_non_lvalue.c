/* Assignment to, and modification of, a non-lvalue.
   Part D.1: `3 = a;', `3++', `++3' and `&3' are SEMANTIC errors here, not
   syntax errors.  The grammar allows a full conditional expression on the left
   of an assignment, so each of these forms parses and is then rejected by the
   semantic pass with a message that names the real problem and points at the
   operator -- at the same line and column as gcc does. */
int f(void) { return 1; }
int arr[3];
int other[3];

int main(void) {
    int a;
    int b;
    a = 1;
    b = 2;
    3 = a;                  /* a constant is not assignable */
    3++;                    /* nor can a constant be incremented ... */
    ++3;                    /* ... in either form */
    &3;                     /* nor does a constant have an address */
    (a + b) = 4;            /* the result of + is not assignable */
    f() = 5;                /* nor is a function's return value */
    &a = 0;                 /* nor is an address */
    a++ = 6;                /* nor is the value of a post-increment */
    (a > b) = 1;            /* nor is the result of a comparison */
    arr = other;            /* an array is not assignable as a whole */
    (a + b) += 1;           /* the same rule applies to compound assignment */
    a ? a : b = 2;          /* parses as (a ? a : b) = 2, exactly as gcc does */
    return a;
}
