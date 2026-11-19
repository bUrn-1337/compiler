/* 57 -- declarator forms, named and nameless.  Every form in this file was a
   SYNTAX ERROR until the declarator grammar was unified; each one is valid C99
   that gcc -m32 accepts, so each one was a program this compiler wrongly
   rejected.  tools/declfuzz.py found them by enumerating declarator shapes and
   asking gcc which are legal; this test is the permanent record of the ones
   that failed.

   The three causes, all of them one defect -- a hand-written abstract
   declarator sub-grammar that had drifted away from the concrete one:

     1. a parameter list accepted no abstract declarator beyond bare stars, so
        an unnamed parameter could only be `T', `T *' or `T **';
     2. a parenthesized abstract group had to be followed by '(' or '[', so a
        group that ENDED the declarator, `int *(*)', failed;
     3. that group had to start with a '*', so `int ([3])' failed.

   Nothing here is only parsed: every declared thing is called, indexed or
   measured, so the IR is exercised and the printed numbers are compared
   against gcc.  @requires-m32 -- the sizes of the pointer types are the
   target's pointer size.

   @requires-m32 */

struct S { int a; char b; };
union  U { int i; char c[4]; };
enum   E { E0, E1 };
typedef char Byte;
typedef int  Row[3];
typedef int  (*Cmp)(int, int);

/* ---- 1. prototypes whose parameters have no names, in every shape ---- */
int p_plain(int);                  /* the one shape that always worked */
int p_ptr(int *);
int p_ptr2(char **);
int p_array(int [3]);              /* adjusted to int *            */
int p_unsized(int []);             /* adjusted to int *            */
int p_ptrarray(int (*)[3]);        /* pointer to array: not int ** */
int p_arrayptr(int *[2]);          /* array of pointers            */
int p_fnptr(int (*)(int, int));
int p_fnptrarr(int (*[2])(int));   /* array of pointers to function */
int p_fntype(int (int));           /* nameless FUNCTION type: adjusted to a
                                      pointer to function, e