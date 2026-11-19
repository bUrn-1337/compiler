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

void printBackwards(Item *head) {          /* recursion as a reverse walk */
    if (head == 0) return;
    printBackwards(head->next);
    printf("%s ", head->name);
}

Item *reverse(Item *head) {
    Item *prev;
    Item *next;
    prev = 0;
    while (head != 0) { next = head->next; head->next = prev; prev = head; head = next; }
    return prev;
}

Item *find(Item *head, char *name) {
    while (head != 0) { if (strcmp(head->name, name) == 0) return head; head = head->next; }
    return 0;
}

int totalScore(Item *head) {
    int t;
    t = 0;
    until (head == 0) { t = t + head->score; head = head->next; }
    return t;
}

void freeAll(Item *head) {
    Item *next;
    while (head != 0) { next = head->next; free(head); head = next; }
}

int main(void) {
    Item *list;
    Item *hit;
    int   n;

    list = 0;
    list = insert(list, newItem("ada", 91));
    list = insert(list, newItem("bob", 47));
    list = insert(list, newItem("cy", 78));
    list = insert(list, newItem("dee", 63));
    list = insert(list, newItem("eli", 91));

    printf("sorted:\n");
    printAll(list);

    n = countRec(list);
    printf("n=%d total=%d avg=%d\n", n, totalScore(list), totalScore(list) / n);

    printf("backwards: ");
    printBackwards(list);
    printf("\n");

    hit = find(list, "cy");
    printf("found %s=%d\n", hit->name, hit->score);
    printf("missing=%d\n", find(list, "zoe") == 0);

    hit->score = hit->score + 20;
    printf("after bump %s=%d %s\n", hit->name, hit->score, gradeName(gradeOf(hit->score)));

    list = reverse(list);
    printf("reversed:\n");
    printAll(list);

    freeAll(list);
    printf("done\n");
    return 0;
}
