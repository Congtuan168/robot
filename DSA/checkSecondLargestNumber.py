#Write a Python function that takes an array of integers as input and returns the second largest number in the array.

#Cách 1: Dùng hàm sort => sort array đảo ngược theo DESC => lấy ra phần tử thứ 2
def checkSecondLargestNumber():
    #Input nhập vào 1 array
    #cách 1: Dùng split để phân tách phần tử, dùng map để đổi từng phần tử thành số
    arr = list(map(int, input(f'Enter array of numbers:').split()))
    print(f'Array nhập vào là: ', arr)
    arr = list(set(arr))
    arr.sort(reverse=True)
    result = arr[1]
    print(f'Second largest number is: {result}')



if __name__ == '__main__':
    checkSecondLargestNumber()