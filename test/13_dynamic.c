/* 13 -- dynamic memory: malloc, calloc, realloc and free, used to build a
   linked list and a growable array. */
struct Node {
    int           value;
    struct Node  *next;
};

struct Node *push(struct Node *head, int v) {
    struct Node *n;
    n = (struct Node *)malloc(sizeof(struct Node));
    n->value = v;
    n->next = head;
    return n;
}

void printList(struct Node *head) {
    struct Node *p;
    p = head;
    while (p != 0) { printf("%d ", p->value); p = p->next; }
    printf("\n");
}

int lengthOf(struct Node *head) {
    int n;
    n = 0;
    until (head == 0) { n = n + 1; head = head->next; }
    return n;
}

void freeList(struct Node *head) {
    struct Node *next;
    while (head != 0) { next = head->next; free(head); head = next; }
}

int main(void) {
    struct Node  *list;
    int          *v;
    int          *grown;
    char         *text;
    int           i;
    int           cap;
    int           sum;

    list = 0;
    for (i = 1; i <= 5; i = i + 1) list = push(list, i * i);
    printList(list);
    printf("len=%d\n", lengthOf(list));
    freeList(list);

    /* malloc'd array */
    v = (int *)malloc(4 * sizeof(int));
    for (i = 0; i < 4; i = i + 1) v[i] = i + 1;
    sum = 0;
    for (i = 0; i < 4; i = i + 1) sum = sum + v[i];
    printf("malloc sum=%d\n", sum);
    free(v);

    /* calloc zero-fills */
    v = (int *)calloc(5, sizeof(int));
    sum = 0;
    for (i = 0; i < 5; i = i + 1) sum = sum + v[i];
    printf("calloc sum=%d\n", sum);

    /* realloc preserves the existing contents */
    for (i = 0; i < 5; i = i + 1) v[i] = i + 10;
    cap = 10;
    grown = (int *)realloc(v, cap * sizeof(int));
    for (i = 5; i < cap; i = i + 1) grown[i] = i + 10;
    for (i = 0; i < cap; i = i + 1) printf("%d ", grown[i]);
    printf("\n");
    free(grown);

    /* a dynamically allocated string */
    text = (char *)malloc(16);
    strcpy(text, "dynamic");
    printf("%s %d\n", text, (int)strlen(text));
    free(text);

    /* sizeof(int) is the same on the target and on the host.  sizeof(struct
       Node) is NOT printed: it holds a pointer, so it is 8 on this 64-bit host
       and 8 (int 4 + pointer 4) on the 32-bit target model, and the gcc
       reference would disagree with the interpreter for that reason alone. */
    printf("%d\n", (int)sizeof(int));
    return 0;
}
