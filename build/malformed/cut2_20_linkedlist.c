/* 20 -- a realistic mixed program: a sorted singly linked list of records,
   built with malloc, searched, reversed and freed.  Uses structs, pointers to
   structs, typedef, enum, recursion, dynamic memory and printf together. */
typedef struct Item Item;

enum Grade { FAIL, PASS, MERIT, DISTINCTION };

struct Item {
    char   name[16];
    int    score;
    Item  *next;
};

Item *newItem(char *name, int score) {
    Item *it;
    it = (Item *)malloc(sizeof(Item));
    strcpy(it->name, name);
    it->score = score;
    it->next = 0;
    return it;
}

/* insert keeping the list sorted by descending score */
Item *insert(Item *head, Item *it) {
    Item *p;
    if (head == 0 || it->score > head->score) { it->next = head; return head = it; }
    p = head;
    while (p->next != 0 && p->next->score >= it->score) p = p->next;
    it->next = p->next;
    p->next = it;
    return head;
}

enum Grade gradeOf(int score) {
    if (score >= 90) return DISTINCTION;
    if (score >= 75) return MERIT;
    if (score >= 50) return PASS;
    return FAIL;
}

char *gradeName(enum Grade g) {
    switch (g) {
        case DISTINCTION: return "distinction";
        case MERIT:       return "merit";
        case PASS:        return "pass";
        default:          return "fail";
    }
}

void printAll(Item *head) {
    Item *p;
    for (p = head; p != 0; p = p->next)
        printf("  %-8s %3d %s\n", p->name, p->score, gradeName(gradeOf(p->score)));
}

int countRec(Item *head) {                 /* recursive length */
    if (head == 0) return 0;
    return 1 + countRec(head->next);
}

void printBackwards(Item *head) {    