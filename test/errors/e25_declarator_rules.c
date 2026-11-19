/* The declarator forms that are NOT valid C but that this compiler accepted
   before the declarator grammar was unified, plus the two mistakes the unified
   grammar newly makes reachable.  tools/declfuzz.py found the first group by
   enumerating declarator shapes and keeping the ones gcc -m32 rejects while we
   accepted them; an accepted-but-invalid declarator is as much a bug as a
   rejected valid one, because it would be given a meaning and lowered to IR.

   Every diagnostic here is semantic, deliberately: a single syntax error
   anywhere in a file stops the semantic pass, so a negative test that mixes
   the two can only ever show the syntax error. */

typedef int F(int);        /* a function type, by name */
typedef int A[3];          /* an array type, by name   */

/* 1. A function cannot RETURN a function.  Reachable only through a typedef or
      through the declarator on line 21, since the return type is written to
      the left and a function type cannot be written there directly. */
F   retfn(void);
int retfn2(void)(int);

/* 2. A function cannot return an array, for the same reason: no size. */
A   retarr(void);
int retarr2(void)[3];

/* 3. An array of functions: the elements would have no size either. */
F   arrfn[3];

/* 4. A declarator with no name at all.  Valid as a type name, never as a
      declaration -- these declare nothing. */
int [3];
int (*);
int (*)(int);

/* 5. A function definition with no name. */
int (*) { return 1; }

int main(void) {
    int n;
    /* 6. The reverse of 4: a TYPE name may not declare an identifier. */
    n = (int)sizeof(int bad);
    n = n + (int)sizeof(int (*badp)[2]);
    n = (int)(int cv)n;
    return n;
}
