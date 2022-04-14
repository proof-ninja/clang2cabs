
struct S1 {
  int x, y;
};

typedef struct {
  int a, b;
} S2;

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
}
