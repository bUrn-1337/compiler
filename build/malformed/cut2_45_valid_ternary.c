/* 45 -- the conditional operator: chains (it associates to the right), nested
   conditions, mixed arithmetic arms, pointer arms, struct arms, calls and
   side effects in the arms, and a conditional choosing a function pointer. */
int add(int a, int b) { return a + b; }
int sub(int a, int b) { return a - b; }
typedef int (*Op)(int, int);

struct Pt { int x; int y; };
struct Pt mkpt(int x, int y) { struct Pt p; p.x = x; p.y = y; return p; }

char *grade(int score) {
    return score >= 90 ? "A" : score >= 80 ? "B" : score >= 70 ? "C"
         : score >= 60 ? "D" : "F";
}

int side(int *counter, int v) { *counter = *counter + 1; return v; }

int main(void) {
    int  i = 5;
    int  j = -3;
    double d = 2.5;
    char c = 'x';
    int  arr[3];
    int *p;
    int *q;
    Op   op;
    struct Pt a;
    int  calls = 0;
    int  k;

    arr[0] = 10; arr[1] = 20; arr[2] = 30;

    /* a chain, evaluated right to left */
    printf("%s %s %s %s %s\n", grade(95), grade(85), grade(75), grade(65), grade(10));
    printf("%d %d\n", i > 0 ? 1 : i < 0 ? -1 : 0, j > 0 ? 1 : j < 0 ? -1 : 0);

    /* nested in the condition and in both arms */
    printf("%d\n", (i > j ? i : j) > 4 ? (i < j ? i : j) : 0);
    printf("%d %d\n", i ? j ? 1 : 2 : 3, 0 ? 1 : 0 ? 2 : 3);

    /* the arms decide the type: int and double give a double */
    printf("