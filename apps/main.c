#include "modern.h"
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static char random_text[] = "The scarlet dragonfly is a species of dragonfly in the family "
                            "Libellulidae";

int main(int argc, char *argv[])
{
    if (argc > 1)
    {
        fprintf(stderr, "%s doesn't accept arguments\n", argv[0]);
        return 1;
    }

    printf("%s\n", random_text);
    char *token = strtok(random_text, " ");
    while (token)
    {
        printf("%s ", modern_reverseinplace(token));
        token = strtok(NULL, " ");
    }
    printf("\n");
    return 0;
}
