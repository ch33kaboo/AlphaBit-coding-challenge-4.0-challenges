#include<stdio.h>

int min_arr_non_zero(int *arr, int size) {
    int min_index = -1;
    for (int i = 0; i < size; i++) {
        if (arr[i] != 0 && (min_index == -1 || arr[i] < arr[min_index])) min_index = i;
    }

    return min_index;
}

int main(int argc, char const *argv[])
{
    int max_capacity;
    scanf("%d", &max_capacity);
    int weights[32];
    int uses[32];
    int weights_length = 0;
    int uses_length = 0;
    char c;

    for (int i = 0; i < 32; i++)
    {
        int flag = scanf("%d%c", &weights[i], &c);
        if (c == '\n' || flag == EOF) {
            weights_length = i + 1;
            break;
        };
    }

    for (int i = 0; i < 32; i++)
    {
        int flag = scanf("%d%c", &uses[i], &c);
        if (c == '\n' || flag == EOF) {
            uses_length = i + 1;
            break;
        };
    }

    // solution
    // init
    int current_capacity = 0;
    int frequencyMap[weights_length];
    for (int i = 0; i< weights_length; i++)
        frequencyMap[i] = 0;

    for (int i = 0; i < uses_length; i++) {
        if (frequencyMap[uses[i]] == 0) {
            while (current_capacity + weights[uses[i]] > max_capacity) {
                int min_item_index = min_arr_non_zero(frequencyMap, weights_length);
                frequencyMap[min_item_index] = 0;
                current_capacity -= weights[min_item_index];
            }
            current_capacity += weights[uses[i]];
        }

        frequencyMap[uses[i]]++;
    }

    printf("%d\n", current_capacity);
    return 0;
}