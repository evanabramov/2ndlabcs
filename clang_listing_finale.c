/* 0xDEADBEEF ->
0xDBAF3FAF */

#include <stdio.h>

void the_action_itself(unsigned int);
void base_2(int number);
int number = 0xd5ad6abf;

int main() {
    printf("%x\n", number);
    base_2(number);

    for (int i = 6; i < 32; i += 9) {
       the_action_itself(i);
    }

    printf("%x\n", number);
    base_2(number);

    return 0;
}

void the_action_itself (unsigned int i) {
    unsigned int x = ((number >> i) ^ (number >> i + 2)) & 1;
    number = number ^ ((x << i) | (x << i + 2));
}

void base_2(int n) {
    int k = 0;
    for (int c = 31; c >= 0; c--) {
        k = n >> c;
        if (k & 1)
            printf("1");
        else
            printf("0");
    }
    printf("\n");
}
