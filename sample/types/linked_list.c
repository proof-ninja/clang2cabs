
typedef struct list {
  int value;
  struct list *next;
} List;

int main(void) {
  List l1 = { 42 }, l2 = { 99 };
  l1.next = &l2;
}
