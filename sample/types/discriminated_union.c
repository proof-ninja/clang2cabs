
typedef enum {
  INT,
  THREE,
  STRING
} Tag;

typedef struct {
  int a, b, c;
} Three;

typedef struct {
  Tag tag;
  union {
    int num;
    Three *three;
    char *str;
  } value;
} Value;

int main(void) {
  Value x = { INT, { 0 } };

  x.tag = THREE;
  Three t = { 1, 2, 3 };
  x.value.three = &t;

  x.tag = STRING;
  x.value.str = "hogehoge";
}
