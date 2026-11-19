/* case and default outside a switch */
int main(void) {
    int i;
    case 1:                 /* no enclosing switch */
        i = 1;
    default:                /* likewise */
        i = 2;
    for (i = 0; i < 2; i = i + 1) {
        case 3:             /* a loop is not a switch */
            i = 3;
    }
    return i;
}
