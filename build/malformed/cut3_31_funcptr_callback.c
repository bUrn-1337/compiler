/* 31 -- function pointers at work: a function whose return type is a function
   pointer written out longhand, callbacks, a qsort-like routine driven by a
   comparator, and a cast between function-pointer types. */
int  add(int a, int b) { return a + b; }
int  sub(int a, int b) { return a - b; }
int  ascending(int a, int b)  { return a - b; }
int  descending(int a, int b) { return b - a; }

/* a function returning a function pointer, written out longhand */
int (*choose(int which))(int, int) { return which ? sub : add; }

/* a qsort-like routine driven by a comparator the caller supplies */
void my