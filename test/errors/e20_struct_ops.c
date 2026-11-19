/* Operators that do not apply to a whole struct or union, and mixing a struct
   with a scalar.  Struct assignment itself is legal and is tested in
   test/19_struct_value.c. */
struct P { int x; int y; };
struct Q { int x; int y; };
union  U { int i; float f; };

int main(void) {
    struct P a;
    struct P b;
    struct Q q;
    union U u;
    int i;

    a.x = 1; a.y = 2; b = a; q.x = 0; q.y = 0; u.i = 0; i = 0;

    if (a == b) i = 1;      /* 1. '==' on two structs */
    if (a != b) i = 2;      /* 2. '!=' on two structs */
    i = a + b;              /* 3. '+' on two structs */
    i = a * 2;              /* 4. '*' with a struct operand */
    i = -a;                 /* 5. unary '-' on a struct */
    if (!a) i = 3;          /* 6. '!' on a struct */
    if (u == u) i = 4;      /* 7. '==' on two unions */
    a = q;                  /* 8. assignment between different struct types */
    i = a;                  /* 9. a struct where a scalar is expected */
    a = i;                  /* 10. a scalar where a struct is expected */
    return i;
}
