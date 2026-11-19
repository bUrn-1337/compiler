/* 32 -- Newton's method for the square root, in double precision: a loop over
   floating values with a convergence test, and a few helpers written by hand
   because the language has no math library. */
double dabs(double v) { return v < 0.0 ? -v : v; }

/* sqrt(a) by Newton iteration: x <- (x + a/x) / 2 */
double mysqrt(double a, int *iters) {
    double x;
    int n = 0;
    if (a < 0.0) { *iters = 0; return -1.0; }
    if (a == 0.0) { *iters = 0; return 0.0; }
    x = a > 1.0 ? a : 1.0;
    while (n < 60) {
