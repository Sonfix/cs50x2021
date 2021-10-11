#include <ctype.h>
#include <cs50.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

// Points assigned to each letter of the alphabet
int POINTS[] = {1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 1, 1, 1, 4, 4, 8, 4, 10};

int compute_score(string word);
char *toLower(char *str, size_t len);

int main(void)
{
    // Get input words from both players
    string word1 = get_string("Player 1: ");
    string word2 = get_string("Player 2: ");

    // Score both words
    int score1 = compute_score(toLower(word1, strlen(word1)));
    int score2 = compute_score(toLower(word2, strlen(word2)));

    if (score1 > score2)
    {
        printf("Player 1 wins!");
    }
    else if (score2 > score1)
    {
        printf("Player 2 wins!");
    }
    else
    {
        printf("Tie!");
    }
}

int compute_score(string word)
{
    int res = 0;
    for (int idx = 0; idx < strlen(word); idx++)
    {
        //getting value of char in array
        int index = ((int)word[idx]) - 97;
        //check if value is in array range
        if (index >= 0 && index < sizeof(POINTS) / sizeof(POINTS[0]))
        {
            //adding value
            res += POINTS[((int)word[idx]) - 97];
        }
    }
    return res;
}

//function is from: https://www.delftstack.com/howto/c/lower-in-c/
char *toLower(char *str, size_t len)
{
    //creating string buffer
    char *str_l = calloc(len + 1, sizeof(char));

    //lower all chars
    for (size_t i = 0; i < len; ++i)
    {
        str_l[i] = tolower((unsigned char)str[i]);
    }

    return str_l;
}