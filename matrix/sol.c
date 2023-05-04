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

bool checkHorizontal(int dim_row, int dim_col, char matrix[dim_row][dim_col+1], char *target, int row)
{
    char right[dim_col* 2 + 1];
    char left[dim_col * 2 + 1];
    char reversed_str[dim_col+1];
    strcpy(right, ""); // init value, if this line is omitted this variable will be filled with garbage in line35
    strcpy(left, "");
    strcpy(reversed_str, ""); 
    strrev(reversed_str, matrix[row]);

    // make a double copy to emulate "snake" grid behaviour
    strcat(right, matrix[row]);
    strcat(right, matrix[row]);

    strcat(left, reversed_str);
    strcat(left, reversed_str);
    return strstr(right, target) || strstr(left, target);
}

void getColumn(char *s, int dim_row, int dim_col, char matrix[dim_row][dim_col+1], int col)
{
    for (int i = 0; i < dim_row; i++)
    {
        strncat(s, &matrix[i][col], 1);
    }
}

bool checkVertical(int dim_row, int dim_col, char matrix[dim_row][dim_col], char *target, int col)
{
    char up[dim_col*2 + 1];
    char down[dim_col*2 + 1];
    char col_s[dim_col+1];
    strcpy(down, "");
    strcpy(up, "");
    strcpy(col_s, "");

    getColumn(col_s, dim_row, dim_col, matrix, col);

    char reversed_str[dim_col+1];
    strrev(reversed_str, col_s);

    sprintf(down, "%s%s", col_s, col_s);
    sprintf(up, "%s%s", reversed_str, reversed_str);
    return strstr(up, target) || strstr(down, target);
}

int main(int argc, char const *argv[])
{
    char target_word[100];
    int rows, cols;
    scanf("%s", target_word);
    scanf("%d %d", &rows, &cols);

    char matrix[rows][cols+1];

    for (int i = 0; i < rows; i++)
        scanf("%s", matrix[i]);
    
    // solution
    for (int i = 0; i < rows; i++)
    {
        if (checkHorizontal(rows, cols, matrix, target_word, i))
        {
            printf("row %d\n", i + 1);
            exit(0);
        }
    }

    for (int i = 0; i < MATRIX_COLS; i++)
    {
        if (checkVertical(rows, cols,matrix, target_word, i))
        {
            printf("col %d\n", i + 1);
            exit(0);
        }
    }
    printf("none\n");
    return 0;
}
