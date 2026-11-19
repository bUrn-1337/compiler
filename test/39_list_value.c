/* 39 -- a linked list whose payload is a struct copied by value: the payload
   is passed in by value, stored by assignment, read back by value, and the
   whole list is duplicated node by node. */
struct Item { int id; double score; char tag[8]; };
struct Node { struct Item it; struct Node *next; };

struct Item mkItem(int id, double score, char *tag) {
    struct Item x;
    x.id = id;
    x.score = score;
    strcpy(x.tag, tag);
    return x;
}

/* the payload arrives by value and is stored by a struct assignment */
struct Node *push(struct Node *head, struct Item it) {
    struct Node *n = (struct Node *)malloc(sizeof(struct Node));
    n->it = it;
    it.id = -1;                      /* the caller's copy must be untouched */
    n->next = head;
    return n;
}

/* append at the tail, so the printed order is the insertion order */
struct Node *append(struct Node *head, struct Item it) {
    struct Node *n = (struct Node *)malloc(sizeof(struct Node));
    struct Node *w;
    n->it = it;
    n->next = 0;
    if (!head) return n;
    w = head;
    while (w->next) w = w->next;
    w->next = n;
    return head;
}

/* a copy of the payload, returned by value */
struct Item at(struct Node *head, int k) {
    while (head && k > 0) { head = head->next; k--; }
    return head ? head->it : mkItem(-1, 0.0, "none");
}

struct Node *clone(struct Node *head) {
    struct Node *out = 0;
    while (head) { out = append(out, head->it); head = head->next; }
    return out;
}

double total(struct Node *head) {
    double s = 0.0;
    while (head) { s += head->it.score; head = head->next; }
    return s;
}

void show(char *tag, struct Node *head) {
    printf("%s:", tag);
    while (head) {
        printf(" [%d %s %.2f]", head->it.id, head->it.tag, head->it.score);
        head = head->next;
    }
    printf("\n");
}

void release(struct Node *head) {
    while (head) { struct Node *n = head->next; free(head); head = n; }
}

int main(void) {
    struct Node *list = 0;
    struct Node *copy;
    struct Item probe = mkItem(7, 7.75, "seven");
    struct Item got;
    struct Node spare;
    int i;

    list = append(list, mkItem(1, 1.5, "one"));
    list = append(list, mkItem(2, 2.25, "two"));
    list = append(list, probe);
    show("list", list);
    printf("probe survived: %d %s %.2f\n", probe.id, probe.tag, probe.score);

    list = push(list, mkItem(0, 0.5, "zero"));
    show("pushed", list);

    got = at(list, 2);
    printf("at(2) = %d %s %.2f\n", got.id, got.tag, got.score);
    got.id = 99;                     /* a copy: the list does not change */
    show("after", list);
    printf("missing = %d %s\n", at(list, 9).id, at(list, 9).tag);

    copy = clone(list);
    copy->it.score = 100.0;          /* the clone is independent */
    show("clone", copy);
    show("list", list);
    printf("totals: %.2f %.2f\n", total(list), total(copy));

    /* a whole node copied by value, payload and link together */
    spare = *list;
    spare.it.id = 42;
    printf("spare = %d %s, list head = %d, same tail = %d\n",
           spare.it.id, spare.it.tag, list->it.id, spare.next == list->next);

    /* an array of payloads, each a struct copy */
    {
        struct Item arr[4];
        for (i = 0; i < 4; i++) arr[i] = at(list, i);
        arr[0] = arr[3];
        for (i = 0; i < 4; i++) printf("arr[%d]=%d %s\n", i, arr[i].id, arr[i].tag);
    }

    release(list);
    release(copy);
    printf("done\n");
    return 0;
}
