
#include <stdio.h>
#include <string.h>


char* generate_numbers(int n) {
    int i, len;
    len = snprintf(NULL, 0, "%d", n); // determine length of largest number
    char* str = malloc(n*len+1); // allocate memory for array
    for (i = 1; i <= n; i++) {
        snprintf(&str[(i-1)*len], len+1, "%d", i); // convert integer to string and store in array
    }
    return str;
}
void swap(char* x, char* y)
{
	char temp;
	temp = *x;
	*x = *y;
	*y = temp;
}


void permute(char* a, int l, int r)
{
	int i;
	if (l == r)
		printf("%s\n", a);
	else {
		for (i = l; i <= r; i++) {
			swap((a + l), (a + i));
			permute(a, l + 1, r);
			swap((a + l), (a + i)); // backtrack
		}
	}
}


int main()
{
    int n ;
    scanf("%d", &n);
    char* str = generate_numbers(n);
    permute(str, 0, n - 1);
    free(str); 
    return 0;
}