#include<stdio.h>
/*
example input :
1000
100 200 300 400 500
output :
900
3
*/
int main()
{
    // read target
    int max_capacity;
    scanf("%d", &max_capacity);

    // read input into array
    int arr[32];
    int last_free_index = 0;
    int num;
    while (scanf("%d", &num) == 1) {
        arr[last_free_index] = num;
        last_free_index++;
    }

    // solution
    int current_capacity = 0;
    int oldest_item_index = 0;
    for (int i=0; i < last_free_index; i++) {
        while(current_capacity + arr[i] > max_capacity) {
            current_capacity = current_capacity - arr[oldest_item_index];
            oldest_item_index++;
        }

        current_capacity += arr[i];
    }
    
    printf("%d\n", current_capacity);
    printf("%d\n", oldest_item_index);
    return 0;
}