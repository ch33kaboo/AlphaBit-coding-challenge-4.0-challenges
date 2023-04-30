#include<stdio.h>

int main(int argc, char const *argv[])
{
    // input
    int max_seats = 150;
    int seats[] = {130, 89, 150, 73, 78, 100, 122, 0};
    int first_station = 3; int last_station = 6;

    // solution

    for (int i = first_station; i <= last_station; i++) {
        if (seats[i] >= 150) {
            printf("false\n");
            return 0;
        }
    }
    printf("true\n");
    return 0;
}
