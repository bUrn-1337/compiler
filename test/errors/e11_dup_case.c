/* duplicate case values, and two defaults */
enum E { ONE = 1, ALSO_ONE = 1 };

int main(void) {
    int x;
    x = 2;
    switch (x) {
        case 1:  x = 10; break;
        case 2:  x = 20; break;
        case 1:  x = 30; break;        /* duplicate of the first */
        case ONE: x = 40; break;       /* ONE is also 1 */
        case 1 + 1: x = 50; break;     /* a constant expression equal to 2 */
        default: x = 60; break;
        default: x = 70; break;        /* a second default */
    }
    return x;
}
