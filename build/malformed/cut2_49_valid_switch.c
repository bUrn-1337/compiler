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

int vowels(char *