/* 62 -- integer corner cases: division and remainder truncate toward zero
   for every sign combination, arithmetic right shift of negatives, shifts
   by 0 and 31, 32-bit wraparound, char is signed (char c = 200 is -56),
   char arithmetic promotes to int, and conversions to char truncate. */
int main(void) {
    int a[4];
    int b[3];
    int i, j, x, big;
    char c, d;
    a[0] = 7; a[1] = -7; a[2] = 100; a[3] = -100;
    b[0] = 2; b[1] = -2; b[2] = 3;
    for (i = 0; i < 4; i++)
        for (j = 0; j < 3; j++)
            printf("%4d / %2d = %3d   %4d %% %2d = %3d\n", a[i], b[j], a[i] / b[j], a[i], b[j], a[i] % b[j]);
    x = -17;
    printf("shifts %d %d %d %d %d\n", x >> 1, x >> 4, x >> 31, x << 3, x >> 0);
    printf("shifts %d %d %d\n", 1 << 31, (1 << 31) >> 31, 0x40000000 << 1);
    x = 1;
    for (i = 0; i < 32; i++) x = x * 3;
    printf("3^32 wrapped = %d\n", x);
    big = 2147483647;
    printf("max+1 = %d, min-1 = %d, -min = %d\n", big + 1, (-big - 1) - 1, -(-big - 1));
    printf("mul wrap = 