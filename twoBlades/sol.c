#include<stdio.h>
/*
example input :
20
12 7 15 25 19 2 5
output :
2 6
*/
int main()
{
    // read target
    int target;
    scanf("%d", &target);

    // read input into array
    int arr[32];
    int arr_length = 0;
    char c;
    while (scanf("%d%c", &arr[arr_length], &c) == 2) {
        arr_length++;
        if (c == '\n') break;
    }

    // solution
    for (int i = 0; i < arr_length; i++) {
        if (arr[i] > target) continue;
        
        for (int j=i+1; j < arr_length; j++) {
            if (arr[i] + arr[j] == target) printf("%d %d\n", i, j);
        }
    }

    return 0;
}