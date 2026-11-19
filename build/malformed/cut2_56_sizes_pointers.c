/* 56 -- the sizes, offsets and pointer differences that only became checkable
   once the reference build became 32-bit (gcc -m32 -msse2 -mfpmath=sse).  The
   target model is char=1, int=4, enum=4, float=4, pointer=4, double=8, and
   -m32 agrees with every one of those, so pointer sizes and pointer arithmetic
   can now be printed and compared against gcc byte for byte.

   @requires-m32 -- the numbers this test prints ARE the target's pointer size,
   so only the 32-bit reference can agree with them; ./verify.sh skips the test
   under REF=native rather than reporting a difference between two ABIs.

   What is deliberately NOT printed here: the size of, or the offset of a
   member of, any struct or union containing a `double'.  The i386 ABI aligns a
   double to 4 bytes inside a struct, while this compiler's MIPS model aligns
   it to 8, so those two layouts legitimately differ; comparing them would be
   comparing two ABIs rather than testing anything.  Tests 27 and 36 exercise
   double members by computing with them instead. */

struct Pt   { int x; int y; };                   /* 8 */
struct Pack { char a; int b; char c; };          /* 12, b at 4 */
struct Nest { struct Pt p; char tag; };          /* 12 */
struct Ptrs { int *p; char **q; struct Pt *r; }; /* 12, three 4-byte pointers */
struct Flt  { float a; float b; int n; };        /* 12; float is 4-aligned */
union  Mix  { int i; char b[7]; int *p; };       /* 8 */

typedef int   Row[4];
typedef int   (*Cmp)(int, int);
typedef char *Str;
typedef int   (*PA6)[6];

int gi;
int *gip = &gi;

int cmpAsc(int a, int b) { return a - b; }

int main(void) {
    int    i;
    int    a[10];
    char   c;
    char   s[14];
    int   *ip;
    char **cpp;
    int  ***ippp;
    void  *vp;
    Cmp    fp;
    Row    r;
    struct Pt   pts[5];
    struct Ptrs pr;
    int    d;

    /* ---- the size of a pointer, in every spelling ---- */
    printf("%d %d %d %d\n", (int)sizeof(int *), (int)sizeof(char **),
                            (int)sizeof(int ***), (int)sizeof(void *));
    printf("%d %d %d %d\n", (int)sizeof(struct Pt *), (int)sizeof(Str),
                            (int)sizeof(Cmp), (int)sizeof(PA6));
    printf("%d %d %d\n", (int)sizeof ip, (int)sizeof cpp, (int)sizeof ippp);
    printf("%d %d %d\n", (int)sizeof vp, (int)sizeof fp, (int)sizeof gip);
    /* a pointer to a pointer is the same size as a pointer to anything */
    printf("%d %d\n", sizeof(char *) == sizeof(char **),
                      sizeof(int *) == sizeof(struct Ptrs *));

    /* ---- nameless pointer declarators: to a function, and to an array ---- */
    printf("%d %d %d\n", (int)sizeof(int (*)(int, int)),
                         (int)sizeof(int (*)[6]), (int)sizeof(int (*)[2][3]));
    printf("%d %d\n", (int)sizeof(int (**)[6]), (int)sizeof(int (*[3])(int)));

    /* ---- arrays of pointers, and the arrays a pointer points at ---- */
    printf("%d %d\n", (int)sizeof(int *[6]), (int)sizeof(char *[2][5]));
    printf("%d %d\n", (int)sizeof(Cmp[3]), (int)sizeof(int (*[4])[6]));

    /* ---- structs and unions WITHOUT a double ---- */
    printf("%d %d %d\n", (int)sizeof(struct Pt), (int)sizeof(struct Pack),
                         (int)sizeof(struct Nest));
    printf("%d %d %d\n", (int)sizeof(struct Ptrs), (int)sizeof(struct Flt),
                         (int)sizeof(union Mix));
    printf("%d %d %d\n", (int)sizeof pts, (int)sizeof r, (int)sizeof pr);
    printf("%d\n", (i