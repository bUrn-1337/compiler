/* 74 -- @no-gcc: the defined behaviour this compiler gives to integer
   operations C leaves undefined (README, "Integer semantics"):
   INT_MIN / -1 is INT_MIN and INT_MIN % -1 is 0 (no trap), shifts use
   the low 5 bits of the count, and a division by zero stops the program
   with "runtime error: division by zero" on stderr and exit status 70,
   after the output so far has been written. */
int quot(int a, int