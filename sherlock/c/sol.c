#include <string.h>

#include <stdio.h>

#include <stdbool.h>

bool isValid(char * s, char c, int originIndex) {
    int i = 0;
    int cpt = 0;
    while (i < strlen(s)) {
        if (s[i + 1] == c && i != originIndex) {
            cpt = cpt + 1;
        }
        i = i + 1;
    }

    if (cpt > 1) {
        return false;
    } else {
        return true;
    }
}

int main() {

    char * test_string = "aabcd";
    int i;
    for (i = 0; i < strlen(test_string); i++) {
        bool isvalid = isValid(test_string, test_string[i + 1], i);
        if (!isvalid) {
            break;
        }
    }

    if (i == strlen(test_string)) {
        printf("true\n");
    } else {
        printf("false\n");
    }
    return 0;
}