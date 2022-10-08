
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

void set_num(Value *value, int num) {
  value->tag = INT;
  value->value.num = num;
}

void set_three(Value *value, Three *three) {
  value->tag = THREE;
  value->value.three = three;
}

void set_str(Value *value, char *str) {
  value->tag = STRING;
  value->value.str = str;
}

int main(void) {
  Value x = { INT, { 0 } };

  set_num(&x, 42);

  Three t = { 1, 2, 3 };
  set_three(&x, &t);

  set_str(&x, "hogehoge");
}
