/* 05 -- switch: fall-through, `default` in the middle, break inside a loop
   inside a switch, and a switch whose controlling expression has a side effect
   (which must be evaluated exactly once). */
int probes;

int probe(int v) { probes = probes + 1; return v; }

void describe(int n) {
    switch (n) {
        case 1:
            printf("one ");
            /* falls through */
        case 2:
            printf("two ");
            break;
        case 3:
            printf("three ");
        default:
            printf("other ");
            break;
        case 4:
        case 5:
            printf("four-or-five ");
            break;
    }
    printf("\n");
}

int main(void) {
    int i;
    int sum;
    char c;

    for (i = 0; i < 7; i = i + 1) { printf("%d: ", i); describe(i); }

    /* the controlling expression is evaluated exactly once */
    probes = 0;
    switch (probe(3)) {
        case 3: printf("hit\n"); break;
        default: printf("miss\n"); break;
    }
    printf("probes=%d\n", probes);

    /* a switch with no match