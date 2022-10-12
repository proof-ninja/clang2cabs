typedef struct {
  enum {
    INT,
    THREE,
    STRING
  } tag;

  union {
    int i;
    struct {
      int a : 12, b : 12, c : 12;
    };
    char *str;
  };
} X;

int main(void) {
  X x = { INT, 0 };

  x.tag = THREE;
  x.a = 1;
  x.b = 2;
  x.c = 3;

  x.tag = STRING;
  x.str = "hogehoge";

  X y = { .tag = STRING, .str = "fugafuga" };
}
