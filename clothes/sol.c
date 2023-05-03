#include<stdio.h>
#include<stdlib.h>
#include<math.h>

float min(float x, float y) {
    if(x > y) return y;
        else return x;
}

int main() {
    int nb_items, nb_pairs;
    scanf("%d %d", &nb_items, &nb_pairs);
    float prices[nb_items];
    int matching_pairs[nb_pairs][2];
    int i = 0;

    for (i = 0; i < nb_items; i++)
        scanf("%f", &(prices[i]));

    for (int i = 0; i < nb_pairs; i++)
        scanf("%d %d", &matching_pairs[i][0], &matching_pairs[i][1]);

    if (nb_items < 3 || nb_pairs < 3) {
        printf("-1\n");
        exit(0);
    }

    float matching_costs[3][3] = {INFINITY}; 

    for (int i = 0; i < nb_pairs; i++) {
        int j = matching_pairs[i][0] - 1, k = matching_pairs[i][1] - 1;
        matching_costs[j][k] = min(prices[j], prices[k]);
        matching_costs[k][j] = min(prices[k], prices[j]);
    }

    float min_cost = INFINITY;

    for (int i = 0; i < nb_items; i++) {
        for (int j = i + 1; j < nb_items; j++) {
            if (matching_costs[i][j] == INFINITY) continue;
            for (int k = j + 1; k < nb_items; k++) {
                if (matching_costs[i][j] != INFINITY && matching_costs[j][k] != INFINITY) {
                    min_cost = min(min_cost, prices[i] + prices[j] + prices[k]);
                }
            }
        }
    }
    if (min_cost == INFINITY) {
        printf("-1\n");
    } else {
        printf("%.15g\n", min_cost);
    }
    return 0;
}