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
    printf("%.3f %.3f\n", i > 0 ? d : 0, i > 0 ? 1 : d);
    printf("%d %.3f\n", (int)(i > 0 ? i : d), (double)(c > 'a' ? c : i));

    /* pointer arms, including the null pointer */
    p = arr;
    q = i > 0 ? p : 0;
    printf("%d %d %d\n", *q, q == p, (i < 0 ? p : 0) == 0);
    printf("%d\n", *(i > 0 ? p + 1 : p + 2));
    printf("%d\n", (i > 0 ? arr : arr + 1)[2]);

    /* a conditional on the right of an assignment, and in a compound one */
    k = i > j ? i * 2 : j * 2;
    k += k > 0 ? 1 : -1;
    printf("%d\n", k);

    /* function pointers chosen by a condition, then called */
    op = i > 0 ? add : sub;
    printf("%d %d\n", op(7, 2), (i > 0 ? sub : add)(7, 2));

    /* structs returned by value from the arms */
    a = i > 0 ? mkpt(1, 2) : mkpt(3, 4);
    printf("%d,%d %d\n", a.x, a.y, (i < 0 ? mkpt(5, 6) : mkpt(7, 8)).y);

    /* only one arm is evaluated, so only one side effect happens */
    k = i > 0 ? side(&calls, 100) : side(&calls, 200);
    printf("%d calls=%d\n", k, calls);
    k = i < 0 ? side(&calls, 100) : side(&calls, 200);
    printf("%d calls=%d\n", k, calls);

    /* a conditional inside a condition, and as a loop bound */
    if (i > 0 ? j < 0 : 0) printf("both tested\n");
    for (k = 0; k < (i > 3 ? 3 : 1); k++) printf("k=%d\n", k);
    while (i > 0 ? i > 3 : 0) i--;
    printf("i=%d\n", i);
    return 0;
}
