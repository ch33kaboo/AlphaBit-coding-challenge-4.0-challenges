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
    int last_free_index = 0;
    int num;
    while (scanf("%d", &num) == 1) {
        arr[last_free_index] = num;
        last_free_index++;
    }

    // solution
    for (int i=0; i < last_free_index - 1; i++) {
        if (arr[i] > target) continue;
        
        for (int j=i+1; j < last_free_index; j++) {
            if (arr[i] + arr[j] == target) printf("%d %d\n", i, j);
        }
    }

    return 0;
}