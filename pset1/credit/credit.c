#include <cs50.h>
#include <stdio.h>
#include <math.h>
#include <string.h>
#include <stdlib.h>

string determineCompany(long number);
int validateNumber(long number);

int main(void)
{
    long number;
    string res = "";
    //getting the creditcard number
    number = get_long("Number: ");

    //first check if length is ok
    if (number > pow(10, 12))
    {
        //check for company
        res = determineCompany(number);
        if (!strcmp(res, "INVALID"))
        {
            printf("%s\n", res);
            return 0;
        }

    }
    else
    {
        printf("INVALID\n");
        return 0;
    }

    //calculating checksum
    int checksum = validateNumber(number);
    if (checksum)
    {
        res = "INVALID";
    }

    //printing the result
    printf("%s\n", res);
}

//determines the company given from ots starting
string determineCompany(long number)
{
    long tmp = number;
    string res = "INVALID";
    while (tmp >= 100)
    {
        tmp /= 10;
    }
    if (tmp > 30)
    {
        switch (tmp)
        {
            case 34:
            case 37:
                res = "AMEX";
                break;
            case 51:
            case 52:
            case 53:
            case 54:
            case 55:
                res = "MASTERCARD";
                break;
            default:
            {
                tmp /= 10;
                if (tmp == 4)
                {
                    res = "VISA";
                }
            }
            break;
        }
    }
    return res;
}

int validateNumber(long number)
{
    //length calculation from: https://stackoverflow.com/questions/3068397/finding-the-length-of-an-integer-in-c
    int length = (int)floor(log10(labs(number)));

    //creating char array for iterating
    char tmp[length];
    sprintf(tmp, "%ld", number);

    int other = 0, even = 0;
    bool switcher = false;

    //iterating from last to first
    for (int idx = length; idx >= 0; idx--)
    {
        //check which case we need to process
        if (switcher)
        {
            //getting int of char, times 2
            int i = ((int)tmp[idx] - 48) * 2;
            if (i > 9)
            {
                //if we got a 10 or higher we need to sum up ech digit
                int buff_len = (int)floor(log10(labs(i))) + 1;
                //creating new string for iterating
                char buff[buff_len];
                sprintf(buff, "%i", i);

                //summing those up
                for (int idy = 0; idy < buff_len; idy++)
                {
                    other += ((int)buff[idy] - 48);
                }
            }
            else
            {
                //summing up
                other += i;
            }
        }
        else
        {
            //summing up
            even += ((int)tmp[idx] - 48);
        }

        //siwtch mode
        switcher = !switcher;

    }
    return (other + even) % 10;
}