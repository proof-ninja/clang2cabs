
int test(int i) {
  int *p;
  p = &i;
  i = *p;
  return i;
}
