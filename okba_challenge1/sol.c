#include<stdio.h>
#include <string.h>
/*
example input :
1@#AAibddwncPhOlaOinoqa5
output :
AAOOddhlP15@#iaioabwncnq
*/
int main()
{
    // read input
    char s[256];
    scanf("%s", &s);

    // solution
    char capitalVowels[256] = "";
    char smallDiv4[256] = "";
    char capitalContstantes[256] = "";
    char capitalDiv4[256] = "";
    char digits[256] = "";
    char symboles[256] = "";
    char smallVowels[256] = "";
    char smallConstantes[256] = "";

    for (int i = 0; i < strlen(s); i++) {
        if (strchr("AEIOUY",s[i]))
                strncat(capitalVowels, &s[i], 1);
            else if (strchr("dhlptx",s[i]))
                strncat(smallDiv4, &s[i], 1);
            else if (strchr("BCDFGHJKLMNOPQRSTVWXZ",s[i]))
                strncat(capitalContstantes, &s[i], 1);
            else if (strchr("DHLPTX",s[i]))
                strncat(capitalDiv4, &s[i], 1);
            else if (strchr("0123456789",s[i]))
                strncat(digits, &s[i], 1);
            else if (strchr("!@#$%^&*()_+/\\][{}\":;`<>?\'",s[i]))
                strncat(symboles, &s[i], 1);
            else if (strchr("aeiouy",s[i]))
                strncat(smallVowels, &s[i], 1);
            else if (strchr("bcdfghjklmnpqrstvwxz",s[i]))
                strncat(smallConstantes, &s[i], 1);

    }

    printf("%s%s%s%s%s%s%s%s", capitalVowels, smallDiv4, capitalContstantes, capitalDiv4, digits, symboles, smallVowels, smallConstantes);
    return 0;
}