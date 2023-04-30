#include<stdio.h>

int main(int argc, char const *argv[])
{
    int max_capacity = 1000;
    int weights[] = {100, 200, 400, 300, 250, 200};
    int uses[] = {0, 1, 2, 0, 0, 1, 3, 4, 3, 3, 5};

    // solution
    // init
    int current_capacity = 0;
    int frequencyMap[] = {0, 0, 0, 0, 0, 0};

    for (int i = 0; i < sizeof(uses) / sizeof(uses[0]); i++) {
        if (frequencyMap[uses[i]] == 0) {
            while (current_capacity + weights[uses[i]] > max_capacity) {
                int min_item_index = min_arr_non_zero(frequencyMap, sizeof(frequencyMap) / sizeof(frequencyMap[0]));
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


int min_arr_non_zero(int *arr, int size) {
    int min_index = 0;
    for (int i = 1; i < size; i++) {
        if (arr[i] != 0 && arr[i] < arr[min_index]) min_index = i;
    }

    return min_index;
}