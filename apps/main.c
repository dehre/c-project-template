#include "modern.h"
#include <stdio.h>

int main(void)
{
    char str[] = "world!";
    printf("Hello %s\n", reverse_in_place(str));
    return 0;
}
