/* using a type name before its typedef, and outside the scope it was
   declared in */
Integer early;              /* Integer is not a type name yet */

typedef int Integer;

int main(void) {
    Integer ok;             /* legal from here on */
    ok = 1;
    {
        typedef char Byte;
        Byte inner;
        inner = 'x';
    }
    Byte outer;             /* Byte's typedef was local to the block above */
    return ok;
}
