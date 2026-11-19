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

/* a copy of the payl