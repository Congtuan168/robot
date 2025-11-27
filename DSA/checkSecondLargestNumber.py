#Write a Python function that takes an array of integers as input and returns the second largest number in the array.

#Cách 1: Dùng hàm sort => reverse array đảo ngược theo DESC => Dùng set(array) để lọc những phần tử bị duplicate => lấy ra phần tử thứ 2 (số lớn nhất thứ 2). 
def checkSecondLargestNumber():
    #Input nhập vào 1 array
    #cách 1: Dùng split để phân tách phần tử, dùng map để đổi từng phần tử thành số
    arr = list(map(int, input(f'Enter array of numbers:').split()))
    print(f'Array nhập vào là: ', arr)
    arr = list(set(arr))
    arr.sort(reverse=True)
    result = arr[1]
    print(f'Second largest number is: {result}')


    #Cách 2: Chọn index ở phần tử đầu tiên là số lớn nhất. So sánh số đó với phần tử tiếp theo, nếu phần tử thứ 2 lớn hơn, swap index max_number = phần tử thứ 2, gán second_max_number = số thứ 1. 
    #Làm tương tự đến hết array sẽ tìm được max và second_max
    


if __name__ == '__main__':
    checkSecondLargestNumber()
