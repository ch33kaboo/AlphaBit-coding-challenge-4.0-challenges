#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <stdlib.h>
#include <ctype.h>

int main()
{
    // read input into array
    char arr[32][32];
    int arr_length = 0;
    char c;

    // modify scanf format to include width limit to avoid buffer overflow
    while (scanf("%31s%c", arr[arr_length], &c) == 2)
    {
        arr_length++;
        if (c == '\n')
            break;
    }

    // solution
    for (int i = 0; i < arr_length; i++)
    {
        // init
        char* s = arr[i];
        long x = atol(s); // use atol() to convert string to long
        char second_to_last = toupper(s[strlen(s) - 2]);

        bool isBit = s[strlen(s) - 1] == 'b'; // check if bit

        // verify second-to-last char
        if (!(second_to_last >= '0' && second_to_last <= '9'))
        {
            switch (second_to_last)
            {
                case 'K':
                    x = x * 1024;
                    break;
                case 'M':
                    x = x * 1024 * 1024;
                    break;
                case 'G':
                    x = x * 1024 * 1024 * 1024;
                    break;
                case 'T':
                    x = x * 1024 * 1024 * 1024 * 1024;
                    break;
            }
        }

        // print the results with correct formatting
        if (i != arr_length - 1)
        {
            if (isBit)
                printf("%.15g ", (double)x / 8.0);
            else
                printf("%.15g ", (double)x);
        }
        else
        {
            if (isBit)
                printf("%.15g\n", (double)x / 8.0);
            else
                printf("%.15g\n", (double)x);
        }
    }

    return 0;
}
