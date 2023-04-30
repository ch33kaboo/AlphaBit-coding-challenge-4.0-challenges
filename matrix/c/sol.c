#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include <stdlib.h>

#define MATRIX_ROWS 3
#define MATRIX_COLS 5

// utility functions

char *strrev(char *output, char *input)
{
    char *p1, *p2;
    strcpy(output, input);

    if (output && *output)
    for (p1 = output, p2 = output + strlen(output) - 1; p2 > p1; ++p1, --p2)
    {
        *p1 ^= *p2;
        *p2 ^= *p1;
        *p1 ^= *p2;
    }
}

bool checkHorizontal(char matrix[MATRIX_ROWS][MATRIX_COLS+1], char *target, int row)
{
    char right[MATRIX_COLS* 2 + 1] = "";
    char left[MATRIX_COLS * 2 + 1] = "";
    char reversed_str[MATRIX_COLS+1];

    strrev(reversed_str, matrix[row]);

    // make a double copy to emulate "snake" grid behaviour
    strcat(right, matrix[row]);
    strcat(right, matrix[row]);

    strcat(left, reversed_str);
    strcat(left, reversed_str);
    return strstr(right, target) || strstr(left, target);
}

void getColumn(char *s, char matrix[MATRIX_ROWS][MATRIX_COLS+1], int col)
{
    for (int i = 0; i < MATRIX_ROWS; i++)
    {
        strncat(s, &matrix[i][col], 1);
    }
}

bool checkVertical(char matrix[MATRIX_ROWS][MATRIX_COLS+1], char *target, int col)
{
    char up[MATRIX_ROWS*2 + 1] = "";
    char down[MATRIX_ROWS*2 + 1] = "";
    char col_s[MATRIX_ROWS+1] = "";
    getColumn(col_s, matrix, col);
    char reversed_str[MATRIX_ROWS+1];
    strrev(reversed_str, col_s);

    sprintf(down, "%s%s", col_s, col_s);
    sprintf(up, "%s%s", reversed_str, reversed_str);
    return strstr(up, target) || strstr(down, target);
}

int main(int argc, char const *argv[])
{
    char *target_word = "plpplpp";
    char matrix[MATRIX_ROWS][MATRIX_COLS+1] = {"haalp", "bitcl", "ubsup"};

    // solution

    for (int i = 0; i < MATRIX_ROWS; i++)
    {
        if (checkHorizontal(matrix, target_word, i))
        {
            printf("row %d\n", i + 1);
            exit(0);
        }
    }

    for (int i = 0; i < MATRIX_COLS; i++)
    {
        if (checkVertical(matrix, target_word, i))
        {
            printf("col %d\n", i + 1);
            exit(0);
        }
    }
    printf("none\n");
    return 0;
}
