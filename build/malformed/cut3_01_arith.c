/* 01 -- every arithmetic, bitwise and shift operator, compound assignment,
   and pre/post increment and decrement. */
int main(void) {
    int a;
    int b;
    int c;
    int i;
    int arr[4];

    a = 17; b = 5;
    printf("%d %d %d %d %d\n", a + b, a - b, a * b, a / b, a % b);
    printf("%d %d %d %d %d\n", -a, +b, ~a, !a, !0);
    printf("%d %d %d %d %d\n", a & b, a | b, a ^ b, a << 2, a >> 2);
    printf("%d %d %d %d %d %d\n", a < b, a <= b, a > b, a >= b, a == b, a != b);

    c = 10;
    c += 5;  printf("%d ", c);
    c -= 3;  printf("%d ", c);
  