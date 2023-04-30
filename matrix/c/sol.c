#include<stdio.h>
#include<stdbool.h>
#include<string.h>
#include<stdlib.h>

#define MATRIX_ROWS 3
#define MATRIX_COLS 5

// utility functions
bool checkHorizontal(char matrix[MATRIX_ROWS][MATRIX_COLS], char* target, int row) {
    char *right;
    char *left;
    sprintf(right, "%s%s", matrix[row], matrix[row]);
    sprintf(left, "%s%s", strrev(matrix[row]), strev(matrix[row]));
    return strstr(right, target) || strstr(left, target);
}

bool checkVertical(char matrix[MATRIX_ROWS][MATRIX_COLS], char* target, int col) {
    char *up;
    char *down;
    char *col_s = "";
    getColumn(col_s, matrix, col);
    sprintf(down, "%s%s", col_s, col_s);
    sprintf(up, "%s%s", strrev(col_s), strev(col_s));
    return strstr(up, target) || strstr(down, target);
}

void getColumn(char* s, char matrix[MATRIX_ROWS][MATRIX_COLS], int col) {
    for (int i = 0; i < MATRIX_ROWS; i++) {
        strcat(s, matrix[i][col + 1]);
    }
}


int main(int argc, char const *argv[])
{
    char *target_word = "alpha";
    char matrix[MATRIX_ROWS][MATRIX_COLS] = {"haalp", "bitcl", "ubsup"};

    // solution

    for (int i = 0; i < MATRIX_ROWS; i++) {
        if(checkHorizontal(matrix, target_word, i)) {
            printf("row %d\n", i + 1);
            exit(0);
        }
    }

    for (int i = 0; i < MATRIX_COLS; i++) {
        if(checkVertical(matrix, target_word, i)) {
            printf("col %d\n", i + 1);
            exit(0);
        }
    }
    printf("none\n");
    return 0;
}

