#include <stdio.h>

int main()
{
    // read capacity
    int max_capacity;
    scanf("%d", &max_capacity);

    // read input into array
    int arr[32];
    int last_free_index = 0;
    int num;
    char c;

    fflush(stdin);
    for (int i = 0; i < 32; i++)
    {
        int flag = scanf("%d%c", &arr[i], &c);
        if (c == '\n' || flag == EOF) {
            last_free_index = i + 1;
            break;
        };
    }

    // solution
    int current_capacity = 0;
    int oldest_item_index = 0;
    for (int i = 0; i < last_free_index; i++)
    {
        while (current_capacity + arr[i] > max_capacity)
        {
            current_capacity = current_capacity - arr[oldest_item_index];
            oldest_item_index++;
        }

        current_capacity += arr[i];
    }

    printf("%d\n", current_capacity);
    printf("%d\n", oldest_item_index);
    return 0;
}