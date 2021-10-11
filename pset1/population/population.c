#include <cs50.h>
#include <stdio.h>

int main(void)
{
    // TODO: Prompt for start size
    int start_size = 0;

    do
    {
        start_size = get_int("Start size: ");

    }
    while (start_size < 9);

    // TODO: Prompt for end size
    int end_size = 0;
    do
    {
        end_size = get_int("End size: ");

    }
    while (end_size < start_size);

    // TODO: Calculate number of years until we reach threshold
    int years = 0;
    while (start_size < end_size)
    {
        int new_ones = start_size / 3;
        int dying = start_size / 4;
        start_size = start_size + new_ones - dying;
        years++;
    }

    // TODO: Print number of years
    printf("Years: %i\n", years);
}