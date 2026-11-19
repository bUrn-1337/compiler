/* 03 -- if/else chains and the dangling else (which binds to the nearest if). */
int classify(int n) {
    if (n < 0)        return -1;
    else if (n == 0)  return 0;
    else if (n < 10)  return 1;
    else if (n < 100) return 2;
    else              return 3;
}

int main(void) {
    int i;
    int a;
    int b;

    for (i = 0; i < 5; i = i + 1)
        printf("%d ", classify(i * i * i - 1));
    printf("\n")