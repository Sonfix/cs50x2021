#include <ctype.h>
#include <cs50.h>
#include <stdio.h>
#include <string.h>
#include <math.h>

int count_letters(string s);
int count_words(string s);
int count_sentences(string s);


int main(void)
{
    string text = get_string("Text: ");

    // counting letters in text
    float letters = count_letters(text);

    //counting words in text
    float words = count_words(text);

    //counting sentences
    float sen = count_sentences(text);

    //calculating average number of letters per 100 words
    float L = (letters / words) * 100;
    //calculating average number of sentences per 100 words
    float S = (sen / words) * 100;
    //calculating index via Coleman-Liau index
    float index = 0.0588 * L - 0.296 * S - 15.8;

    //presenting the result
    if (index > 16)
    {
        printf("Grade 16+\n");
    }
    else if (index < 1)
    {
        printf("Before Grade 1\n");
    }
    else
    {
        printf("Grade %i\n", (int)round(index));
    }

}

//counts the alphabetical letters
int count_letters(string s)
{
    int res = 0;
    for (int i = 0; i < strlen(s); i++)
    {
        if (isalnum(s[i]))
        {
            res++;
        }
    }
    return res;
}

// counts the words in a given string, word can be ended by [" ", "\t", "\n", "\0"]
// pre increment the result to get even the last word
int count_words(string s)
{
    int res = 0;
    for (int i = 0; i < strlen(s); i++)
    {
        if (s[i] == ' ' || s[i] == '\t' || s[i] == '\n' || s[i] == '\0')
        {
            res++;
        }
    }
    return ++res;
}

// counts the sentences in the given text
int count_sentences(string s)
{
    int res = 0;
    for (int i = 0; i < strlen(s); i++)
    {
        if (s[i] == '.' || s[i] == '!' || s[i] == '?')
        {
            if (s[i] == '.' && i + 1 < strlen(s) && s[i + 1] == '.')
            {
                continue;
            }
            res++;
        }
    }
    return res;
}