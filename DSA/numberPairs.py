# #Write a Python function that takes two inputs:
# an array of integers (array_number), a target number (target_number).
# The function should return all number pairs from the array whose sum equals the target_number.
# Return the result as a flat array containing all numbers from the valid pairs.


#ý tưởng: Dùng 2 vòng for. Vòng for đầu tiên chạy từ index [0 - end], vòng for thứ 2 chạy từ [1 - end]. Tại vị trí a[for1] + a[1 - end] => Nếu = targetNumber, append vào array rỗng
def calculateTwoNumber(targetNumber):
    #Nhap vao array bởi user
    array = list(map(int, input(f'Enter an array: ').split()))
    length = len(array)
    resultArray = []

    #check for two number
    for roundFor1 in range (length) :
        for roundFor2 in range (roundFor1 + 1, length):
            print(f' For 1: {roundFor1} là số {array[roundFor1]} + For 2: {roundFor2} là số {array[roundFor2]}')
            if array[roundFor1] + array[roundFor2] == targetNumber :
                print(f' {array[roundFor1]} + {array[roundFor2]} = {targetNumber}')
                resultArray.append([array[roundFor1], array[roundFor2]])

    print(resultArray)
    return resultArray

if __name__ == '__main__':
    askForTargetNumber = int(input(f'Enter your target number: '))
    calculateTwoNumber(askForTargetNumber)
