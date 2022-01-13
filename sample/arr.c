void f(void) {
    int a[3];
    a[0] = 42;

    int i = 1;
    a[i] = 99;

    return;
}

int b[2][3];

int g(int i, int j) {
    int x = b[i][j];
    return x;
}
