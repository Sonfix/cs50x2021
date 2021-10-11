#include <stdio.h>
#include <cs50.h>

int main(void)
{
    //getting input from user
    string name = get_string("What is your name?\n");
    //greetings to the user
    printf("hello, %s\n", name);
}