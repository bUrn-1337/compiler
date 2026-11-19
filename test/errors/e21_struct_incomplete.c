/* A struct that cannot be passed, returned or stored by value: one that
   contains itself, and one whose tag was never defined. */
struct Self {
    int n;
    struct Self me;         /* 1. a struct containing itself by value */
};

struct Node {
    int n;
    struct Node *next;      /* legal: a pointer to an incomplete type */
};

struct Hidden;              /* declared, never defined */

void takeHidden(struct Hidden h) { (void)h; }       /* 2. incomplete parameter */

struct Hidden makeHidden(void) {                    /* 3. incomplete return type */
    struct Hidden *p = 0;
    return *p;
}

/* 4. declared, called below, and never defined: there is no linker after this
   stage, so the IR generator needs the body of every function it calls. */
struct Hidden callHidden(void);

struct P { int x; };
struct Q { int x; };
void takeP(struct P p) { (void)p; }
struct P giveP(void) { struct P p; p.x = 1; return p; }
struct Q giveQ(void) { struct Q q; q.x = 1; return q; }

int main(void) {
    struct Hidden h;        /* 5. an object of incomplete type */
    struct P p;

    callHidden();           /* 6. a call whose result has no layout */
    takeP(giveQ());         /* 7. wrong struct type as an argument */
    p = giveQ();            /* 8. wrong struct type from a call */
    takeP(1);               /* 9. a scalar where a struct is expected */
    (void)h;
    return giveP().x;
}
