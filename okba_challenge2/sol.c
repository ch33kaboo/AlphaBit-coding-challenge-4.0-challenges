#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <stdlib.h>

/*
input :
1500Kb 49b 48MB
output :
192000 6.125 50331648 
*/
int main()
{
    // read input into array
    char arr[32][32];
    int arr_length = 0;
    char c;
    while (scanf("%s%c", arr[arr_length], &c) == 2)
    {
        arr_length++;
        if (c == '\n') break;
    }

    // solution
    for (int i = 0; i < arr_length; i++)
    {
        // init
        char *s = arr[i];
        long x = atoi(s);
        char second_to_last = s[strlen(s) - 2];

        bool isBit = s[strlen(s) - 1] == 'b'; // check if bit

            // verify second before last char
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
                    x = x *  1024 * 1024 * 1024 * 1024;
                    break;
                }
            }
        if (i != arr_length -1)
            printf("%.15g ", isBit ? (double) x / 8 : x);
        else 
            printf("%.15g\n", isBit ? (double) x / 8 : x);
    }

    return 0;
}