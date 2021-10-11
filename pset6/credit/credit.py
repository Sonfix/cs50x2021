

def determineCompany(number):
    '''determine the company accroding the number'''
    first = number[0:2]
    if first == "34" or first == "37":
        return "AMEX"
    elif first == "51" or first == "52" or first == "53" or first == "54" or first == "55":
        return "MASTERCARD"
    elif number[0] == "4":
        return "VISA"
    else:
        return "INVALID"


def validateNumber(number):
    '''validate the credit card number'''
    switcher = False
    other = 0
    even = 0
    for c in reversed(number):
        if switcher:
            i = int(c) * 2
            # if its greater split and add up
            if i > 9:
                other += int(str(i)[0])
                other += int(str(i)[1])
            else:
                other += i
        else:
            even += int(c)
        switcher = not switcher

    # return modulo to check if last is 0
    return (other + even) % 10


def main():
    print("Number: ")
    number = input()

    # number great enough?
    if int(number) > pow(10, 12):
        # get the company
        res = determineCompany(number)
        if res == "INVALID":
            print(res)
            return

    # number correct?
    if validateNumber(number):
        res = "INVALID"

    print(res)


# checking input function
if __name__ == "__main__":
    main()
