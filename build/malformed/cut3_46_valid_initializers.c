/* 46 -- initializers: a braced list around a scalar, partial lists that leave
   the rest zero, nested braces, a string for a char array, arrays of structs,
   a union initialized through its first member, trailing commas, and the same
   forms at file scope and inside a block. */
int    gscalar = {5};                     /* braces around a scalar */
int    gpart[5] = {1, 2};                 /* the tail is zero */
int    gmat[2][3] = { {1, 2, 3}, {4, 5} };
char   gtext[8] = "hi";
char   gexact[3] = "ab";
double gd[3] = {1, 2.5};                  /* 1 converts to 1.0 */
struct Pair { int a; int b; };
struct Pair gpair = {7, 8};
struct Pair gpairs[3] = { {1, 2}, {3, 4} };
struct Nest { struct Pair p; int t[2]; char c; };
struct Nest gnest = { {9, 10}, {11, 12}, 'N' };
union  Mix { int i; char b[4]; };
union  Mix gmix = {258};
int    gtrail[3] = {1, 2, 3,};
char  *gwords[3] = { "alpha", "beta" };
int   *gptr = &gscalar;

int main(void) {
    int    scalar = {42};
    int    part[5] = {9, 8};
    int    mat[2][3] = { {1, 2, 3}, {4} };
    cha