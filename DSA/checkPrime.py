# Write a Python function that takes an integer as input and checks whether it is a prime number or not.
# Ý tưởng: Dùng 1 vòng loop kiểm tra từ 3 => căn bậc 2 của inputNumber. Nếu tồn tại 1 số %2 == 0, thì inputNumber không phải Prime number; else thì số đó là prime 
import math


def checkPrime():
    print(f'Enter a number')
    inputNumber = int(input())

    # check nho hon 2
    if inputNumber < 2:
        print(f"This is not a prime number")
        return False
        
    # dùng for
    # vì for chạy từ 2 đến 4 (bỏ mất 5) nên phải +1 vào
    # else:
    #     for i in range(2, int((math.sqrt(inputNumber) +1)) ):
    #         if inputNumber % i == 0:
    #             print(f"This is not a prime number")
    #             return False

    # dùng while (while chạy từ 2 đến 5 nên ko cần + 1

    else:
        index = 2
        while index <= int(math.sqrt(inputNumber)):
            if inputNumber % index == 0:
                print(f' {inputNumber} is not a prime number')
                return False
            index += 1

    print(f"This is a prime number")
    return True


if __name__ == "__main__":
    checkPrime()
