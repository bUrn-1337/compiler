/* Operators that require integer operands, applied to floating-point ones.
   Every one of these is a hard error in C, not a conversion. */
int main(void) {
    float f = 1.5f;
    double d = 2.5;
    int i = 3;

    i = f % 2;              /* 1. '%' on a float */
    i = 7 % d;              /* 2. '%' with a double on the right */
    i = f << 1;             /* 3. '<<' on a float */
    i = 8 >> d;             /* 4. '>>' with a double on the right */
    i = f & 1;              /* 5. '&' on a float */
    i = f | 1;              /* 6. '|' on a float */
    i = f ^ 1;              /* 7. '^' on a float */
    i = ~d;                 /* 8. '~' on a double */
    f %= 2;                 /* 9. compound '%=' on a float */
    d <<= 1;                /* 10. compound '<<=' on a double */
    return i;
}
