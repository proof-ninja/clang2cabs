
struct S1 {
  int x, y;
};

typedef struct {
  int a, b;
} S2;

struct S3;

struct X {
  unsigned int n : 16;
  unsigned int m : (99 - 42) ? 16 : 32;
  unsigned int a : 8, b : 8, : 8, c : 8;
};

int main(void)
{
  struct S1 s11;
  s11.x = 42;
  s11.y = 99;
  struct S1 s12 = { 1, 2 };

  S2 s21;
  s21.a = 42;
  s21.b = 99;
  S2 s22 = { 1, 2 };

  struct X x1;
  x1.n = 0;
  x1.m = 1;

  struct X x2 = { 0, 0, 0, 0, 0 };
}
