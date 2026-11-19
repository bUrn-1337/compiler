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
    