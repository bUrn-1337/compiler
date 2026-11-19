/* duplicate and undefined goto labels */
int main(void) {
    int i;
    i = 0;
top:
    i = i + 1;
    if (i < 2) goto top;
top:                        /* defined twice in the same function */
    i = i + 1;
    goto nowhere;           /* never defined */
    goto alsoMissing;       /* never defined either */
    return i;
}

int other(void) {
    goto top;               /* labels are function-scoped: top is not visible */
    return 0;
}
