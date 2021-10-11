
def count_letters(s) -> int:
    '''counts the alphanum letters in given string'''
    cnt = 0
    for c in s:
        if c.isalnum():
            cnt += 1
    return cnt


def count_words(s) -> int:
    '''counts the words in given str'''
    cnt = 0
    for c in s:
        if c == " " or c == "\t" or c == "\n" or c == "\0":
            cnt += 1
    return cnt + 1


def count_sentences(s) -> int:
    '''counts the sentences in given string'''
    cnt = 0
    for i in range(len(s)):
        c = s[i]
        if c == "." or c == "!" or c == "?":
            if c == "." and i + 1 < len(s) and s[i + 1] == ".":
                continue
            cnt += 1
    return cnt


def main():
    print("Text: ")
    text = input()
    # getting all key values
    letters = float(count_letters(text))
    words = float(count_words(text))
    sentences = float(count_sentences(text))

    # calculating L and S
    L = (letters / words) * 100
    S = (sentences / words) * 100
    # calculating the index
    index = 0.0588 * L - 0.296 * S - 15.8

    if index > 16:
        print("Grade 16+")
    elif index < 1:
        print("Before Grade 1")
    else:
        print(f"Grade: {round(index)}")


# checking input function
if __name__ == "__main__":
    main()
