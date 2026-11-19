/* 75 -- @no-gcc: the heap checks of the runtime (the same as irsim's):
   blocks are reused first-fit after free, realloc keeps the contents,
   free(NULL) is a no-op, and a double free stops the program with a
   message on stderr and exit status 70. */
