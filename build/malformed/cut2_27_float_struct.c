/* 27 -- float and double members, parameters and return values: structs
   holding floating members, functions taking and returning them, and
   conversions at the argument and return boundary.
   The sizes and offsets of a struct holding a double are deliberately not
   printed: our target aligns double to 8, 32-bit x86 to 4 (docs/REPORT.md). */
struct P { double x; double y; float w; int n; };
struct Stat { int count; double total; };

struct P gp = { 1.5, 2.5, 0.5f, 3 };

double scale(double v, float k) { return v * k; }
float  half(float v)            { return v / 2.0f; }
double dot(struct P *p, struct P *q) { return p->x * q->x + p->y * q->y; }
double avg(struct Stat *s)      { return s->count ? s->total / s->count : 0.0; }

/* a double parameter receiving an int, and an int return from a double */
double thirds(int n) { return n / 3.0; }
int    rounded(double v) { return (int)(v + 0.5); }

void add(struct Stat