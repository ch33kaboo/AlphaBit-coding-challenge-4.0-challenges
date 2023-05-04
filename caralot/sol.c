#include<stdio.h>
#include<stdbool.h>
#include<stdlib.h>

// some utility functions
int exists(int *arr, int nb_arr, int target) {
    for (int i = 0; i < nb_arr; i++)
    {
        if (arr[i] == target) {
            return i;
        }
    }
    
    return -1;
}

void push(int *arr, int* nb_arr, int target) {
    arr[*nb_arr] = target;
    *nb_arr = *nb_arr + 1 ;
}

void remove_item(int* arr, int* nb_arr, int target) {
    int removal_index = exists(arr, *nb_arr, target);


    int i = removal_index;
    while (i < *nb_arr) {
        arr[i] = arr[i+1];
        i++;
    }

    *nb_arr = *nb_arr - 1;
}

// main
int main()
{
    // input
    int nb_events;
    scanf("%d", &nb_events);
    int events[nb_events];
    for (int i = 0; i < nb_events; i++)
        scanf("%d", &events[i]);
    // solution

    if (nb_events % 2 == 1) { // car entered but never left
        printf("-1\n-1\n");
        exit(0);
    }

    // init 
    int stack[nb_events]; int nb_stack = 0;  // people entering and leaving in the current day 
    int day[nb_events]; int nb_day = 0;  // number of people in the office in the current day
    int done[nb_events]; int nb_done = 0;   // people entered and left the current  day 
    int events_per_day[nb_events]; int nb_events_per_day = 0; // save number of days and events

    for (int i = 0; i < nb_events; i++) {
        if (exists(done, nb_done, events[i]) != -1) {
            printf("-1\n-1\n");
            exit(0);
        }

        if(events[i] > 0 && exists(day, nb_day, events[i]) == -1) {
            push(day, &nb_day, events[i]);
            push(stack, &nb_stack, events[i]);
        } else if (events[i] < 0 && exists(day, nb_day, events[i] * -1) != -1) {
            remove_item(day, &nb_day, events[i] * -1);
            push(stack, &nb_stack, events[i]);
            push(done, &nb_done, events[i] * -1);

            if (nb_day == 0) {
                events_per_day[nb_events_per_day] = nb_stack;
                nb_events_per_day++;
                nb_stack = 0;
                nb_day = 0;
                nb_done = 0;
            }
        }


    }

    printf("%d\n", nb_events_per_day);
    for (int i = 0; i < nb_events_per_day -1; i++) {
        printf("%d ", events_per_day[i]);
    }

    printf("%d\n", events_per_day[nb_events_per_day - 1]);

    return 0;
}