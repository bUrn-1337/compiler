/* break and continue outside a loop; continue inside a switch */
int main(void) {
    int i;
    break;                  /* not in a loop or switch */
    continue;               /* not in a loop */

    switch (1) {
        case 1:
            break;          /* legal: break belongs to the switch */
        case 2:
            continue;       /* a switch is not a loop */
    }

    for (i = 0; i < 2; i = i + 1) { break; continue; }   /* both legal here */
    return 0;
}
