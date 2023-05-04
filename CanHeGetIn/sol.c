#include<stdio.h>

int main(int argc, char const *argv[])
{
    // input
    int max_seats, first_station, last_station;
    scanf("%d", &max_seats);
    scanf("%d %d", &first_station, &last_station);

    int seats[32];
    int seats_length = 0;
    char c;
    while(scanf("%d%c", &seats[seats_length], &c) == 1) {
        seats_length++;
        if (c == '\n') break;
    }

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
