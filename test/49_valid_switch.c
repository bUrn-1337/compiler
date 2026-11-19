/* 49 -- switch statements: fallthrough, a default in the middle, cases that
   share a body, nested switches, char and enum labels, a switch on a function
   result, a switch with no matching label, and break inside a loop inside a
   switch. */
enum Kind { K_ZERO, K_ONE, K_TWO, K_MANY };

int classify(int n) {
    switch (n) {
        case 0:  return K_ZERO;
        case 1:  return K_ONE;
        case 2:  return K_TWO;
        default: return K_MANY;
    }
}

int steps(int n) {
    int count = 0;
    switch (n) {
        case 3: count++;          /* fallthrough */
        case 2: count++;          /* fallthrough */
        case 1: count++;
                break;
        case 0: count = 100;
                break;
        default:
                count = -1;
    }
    return count;
}

int middle(int n) {
    int r = 0;
    switch (n) {
        case 1:  r = 1; break;
        default: r = 9; break;    /* a default that is not last */
        case 2:  r = 2; break;
        case 3:
        case 4:  r = 34; break;   /* two labels, one body */
    }
    return r;
}

char *name(enum Kind k) {
    switch (k) {
        case K_ZERO: return "zero";
        case K_ONE:  return "one";
        case K_TWO:  return "two";
        case K_MANY: return "many";
    }
    return "?";
}

int nested(int a, int b) {
    int out = 0;
    switch (a) {
        case 1:
            switch (b) {
                case 1: out = 11; break;
                case 2: out = 12; break;
                default: out = 10; break;
            }
            break;
        case 2:
            out = 20;
            switch (b) { case 1: out = 21; break; }
            break;
        default:
            out = -1;
    }
    return out;
}

int vowels(char *s) {
    int n = 0;
    int i;
    for (i = 0; s[i]; i++) {
        switch (s[i]) {
            case 'a': case 'e': case 'i': case 'o': case 'u':
                n++;
                break;
            case ' ':
                break;
            default:
                if (s[i] >= '0' && s[i] <= '9') n += 10;
        }
    }
    return n;
}

int loopInSwitch(int n) {
    int total = 0;
    int i;
    switch (n) {
        case 1:
            for (i = 0; i < 10; i++) {
                if (i == 4) break;       /* leaves the for, not the switch */
                total += i;
            }
            total += 1000;
            break;
        default:
            i = 0;
            while (1) { total++; if (total > 2) break; }
    }
    return total;
}

int main(void) {
    int i;
    enum Kind k;

    for (i = 0; i < 5; i++)
        printf("%d: classify=%d steps=%d middle=%d\n",
               i, classify(i), steps(i), middle(i));

    for (k = K_ZERO; k <= K_MANY; k++) printf("%s ", name(k));
    printf("\n");

    for (i = 1; i <= 3; i++) printf("%d %d %d\n", nested(i, 1), nested(i, 2), nested(i, 3));
    printf("%d %d\n", vowels("hello there"), vowels("a1e2"));
    printf("%d %d\n", loopInSwitch(1), loopInSwitch(7));

    /* a switch on a function result, and one that matches nothing */
    switch (classify(2)) {
        case K_TWO: printf("two it is\n"); break;
        default:    printf("not two\n");
    }
    switch (42) {
        case 1: printf("one\n"); break;
        case 2: printf("two\n"); break;
    }
    printf("fell through\n");

    /* a switch whose body is a single statement, and an empty one */
    switch (1) case 1: printf("single\n");
    switch (3) { }
    printf("done\n");
    return 0;
}
