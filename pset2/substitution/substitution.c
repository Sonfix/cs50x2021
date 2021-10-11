#include <ctype.h>
#include <cs50.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

bool validateKey(string s);
bool createChiperText(string plain, string key, char *result);

int main(int argc, char *argv[])
{
    //if there is not argument given return with usage hint
    if (argc < 2 || argc > 2)
    {
        printf("Usage: ./substitution key\n");
        return 1;
    }

    string Key = argv[1];
    if (!validateKey(Key))
    {
        printf("Key must contain 26 unique characters.\n");
        return 1;
    }
    string plain = get_string("plaintext: ");
    string chiper = "";
    //create chiper text
    if (createChiperText(plain, Key, chiper))
    {
        return 0;
    }
    else
    {
        return 1;
    }

}

//validates the key, checks length and occurance of letters
bool validateKey(string s)
{
    if (strlen(s) < 26 || strlen(s) > 26)
    {
        return false;
    }
    //creating buffer to count the chars, also set all elements to 0
    int arr[26] = {0};

    //check every char in string
    for (int idx = 0; idx < strlen(s); idx++)
    {
        //if not a valid alphanumeric char return false
        if (!isalpha(s[idx]))
        {
            return false;
        }
        else
        {
            int index = 0;
            //calculating index of letter
            if (islower(s[idx]))
            {
                index = ((int)s[idx]) - 97;
            }
            else
            {
                index = ((int)s[idx]) - 65;
            }

            //check if the index fits to the array
            if (index >= 0 && index < 26)
            {
                //index already existent?
                arr[index]++;
                if (arr[index] > 1)
                {
                    return false;
                }
            }
            else
            {
                return false;
            }
        }
    }
    return true;
}

//create the chiper text
bool createChiperText(string plain, string key, char *result)
{
    int length = strlen(plain);
    //creating buffer and allocating memory
    char *buff = 0;
    buff = malloc(sizeof(buff) * length);

    //iterate through every plain char
    for (int idx = 0; idx < strlen(plain); idx++)
    {
        int index = 0;
        bool lowerd = false;
        //calculating index of letter
        if (islower(plain[idx]))
        {
            index = ((int)plain[idx]) - 97;
            lowerd = true;
        }
        else
        {
            index = ((int)plain[idx]) - 65;
        }
        //check if the index fits to the array
        if (index >= 0 && index < 26)
        {
            char chipher_char = key[index];
            //check if we need to convert to upper or lower
            if (islower(chipher_char) && !lowerd)
            {
                chipher_char = toupper(chipher_char);
            }
            else if (!islower(chipher_char) && lowerd)
            {
                chipher_char = tolower(chipher_char);
            }

            //if we got a char, add to buffer
            if (chipher_char)
            {
                strncat(buff, &chipher_char, 1);
            }

        }
        else //adding chars which do not fit to our key
        {
            strncat(buff, &plain[idx], 1);
        }
    }
    if (!sizeof(buff)) // if we could not create a chipher text return false
    {
        return false;
    }
    //all good. printing and return true
    printf("ciphertext: %s\n", buff);
    return true;
}