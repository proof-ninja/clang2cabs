
union U1 {
    int x;
    long y;
};

typedef union {
    int x;
    long y;
} U2;

union U3;

union U4 {
    unsigned int x : 8;
    unsigned int y : 12;
};

int main(void)
{
    union U1 u11, u12;
    u11.x = 42;
    u12.y = 99;
    union U1 u13 = { 1 };

    U2 u21, u22;
    u21.x = 42;
    u22.y = 99;
    U2 u23 = { .y = 1 };

    union U4 u4;
    u4.x = 0;
    u4.y = 1;

    union U5 {
        int x;
        float y;
    };
    union U5 u51, u52, u53 = { 1 };
    u51.x = 42;
    u52.y = 3.14;

    union {
        int n;
        float r;
    } u6;
    u6.n = 7;
    u6.r = 1.41;
}
