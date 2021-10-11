// Implements a dictionary's functionality

#include <stdbool.h>

#include "dictionary.h"
#include <stdio.h>
#include <ctype.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>

// Represents a node in a hash table
typedef struct node
{
    char word[LENGTH + 1];
    struct node *next;
}
node;

// no. of buckets in hash table - thansk to https://youtu.be/HsnjdbHMZO8?t=944
const unsigned int N = LENGTH * ('z' + 1);

// initialise positive hash value using unsigned int
unsigned int hash_value;

// initialise (positive) hash table word count - init to zero
unsigned int word_count = 0;

// hash table
node *table[N];

// Returns true if word is in dictionary, else false
bool check(const char *word)
{
    //hash the word to get hash value
    hash_value = hash(word);
    //access the linked list
    node *cursor = table[hash_value];

    //go through the linked list
    while (cursor != NULL)
    {
        //check if the word matches
        if (strcasecmp(word, cursor->word) == 0)
        {
            return true;
        }
        //move cursor to next node
        cursor = cursor->next;
    }

    return false;
}

// Hashes word to a number
// thansk to https://youtu.be/HsnjdbHMZO8?t=944
// this function could reduce time from 1.38 to 0.04
// former hash function was related to djb2 algorithm
unsigned int hash(const char *word)
{
    // This hash function adds the ASCII values of all characters in the word together
    long sum = 0;
    for (int i = 0; i < strlen(word); i++)
    {
        sum += tolower(word[i]);
    }

    return sum % N;
}

// Loads dictionary into memory, returning true if successful, else false
bool load(const char *dictionary)
{
    // Open dict
    FILE *file = fopen(dictionary, "r");
    // If file is not opened, return false
    if (file == NULL)
    {
        return false;
    }

    // storage space for word
    char word[LENGTH + 1];

    // Scan dict for strings that are not the end of the file
    while (fscanf(file, "%s", word) != EOF)
    {
        // Allocate memory for new node
        node *n = malloc(sizeof(node));

        // If malloc returns NULL, return false
        if (n == NULL)
        {
            return false;
        }

        // Pointer to next node and word itself
        strcpy(n->word, word);

        // Hash the word to get hash value
        hash_value = hash(word);

        // Set new pointer
        n->next = table[hash_value];

        // Set head to new pointer
        table[hash_value] = n;

        // Increment word count
        word_count++;
    }
    // Close file
    fclose(file);

    // If dict is loaded, return true
    return true;
}

// Returns number of words in dictionary if loaded, else 0 if not yet loaded
unsigned int size(void)
{
    return word_count;
}

// Unloads dictionary from memory, returning true if successful, else false
bool unload(void)
{
    // Iterate through buckets
    for (int i = 0; i < N; i++)
    {
        // Set cursor to this each bucket location
        node *cursor = table[i];

        // If cursor is not NULL, free
        while (cursor)
        {
            // Create temp
            node *tmp = cursor;
            // Move cursor to next node
            cursor = cursor->next;
            // Free up temp
            free(tmp);
        }

        // If cursor is NULL
        if (i == N - 1 && cursor == NULL)
        {
            return true;
        }
    }
    return false;
}
