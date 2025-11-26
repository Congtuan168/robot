#Write a function that count the number of characters in the input appeared in string (input by user)

def countCharacterFromString():
    inputSentence = input("Enter a string: ")

    count_character = {}

    if len(inputSentence) == 0:
        print( "User enters nothing")
        return count_character
    else:

        for char in inputSentence:
            #Đếm ký tự trong câu, nếu ký tự tồn tại => tăng index của ký tự lên 1, nếu không thấy, count = 1
            if char in count_character:
                count_character[char] += 1
                print(f'"{char}" appears {count_character[char]} times')
            else:
                count_character[char] = 1
                print(f'"{char}" appears {count_character[char]} times')

        for char, count in count_character.items():
            print(f"'{char}' appears {count} times")
        return count_character


if __name__ == "__main__":
    countCharacterFromString()
