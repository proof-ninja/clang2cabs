
enum E1 {
    E11,
    E12 = 4,
    E13
};

typedef enum {
    E21,
    E22
} E2;

enum E3;

int main(void) {
    enum E1 e1 = E11;
    e1 = E12;

    int x;
    x = E13;

    E2 e2 = 0;
    e2 = E22;

    enum E4 {
        E41 = 1,
        E42
    };
    enum E4 e4;
    e4 = E41;

    enum {
        YES,
        NO
    } res;
    res = YES;
    res = NO;
}
