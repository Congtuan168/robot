#write function to calculate the factorial of a number (input from user)

def calculateFactorial(number):
    #ý tưởng: Dùng 1 vòng for chạy từ 1 tới number
    if number == 0:
        print('The factorial is 1')
        return 1

    elif number == 1:
        print('The factorial is 1')
        return 1
    elif number > 1:
        start = 1
        for i in range(1, number + 1):
            start = start * i
            print(f'result: {i} ! =  {start}')

        return start


if __name__ == '__main__':
    number = int(input('Enter a number: '))
    calculateFactorial(number)