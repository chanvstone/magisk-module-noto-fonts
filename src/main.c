#include "font.h"
int main(int argv, char **args)
{
    if (argv < 3)
    {
        return 1;
    }
    FILE *src = fopen(args[1], "r");
    if (src == NULL)
    {
        return 1;
    }
    FILE *dest = fopen(args[2], "w");
    if (dest == NULL)
    {
        return 1;
    }
    mod(dest, src);
    return 0;
}