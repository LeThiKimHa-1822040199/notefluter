//  calculateSum
int calculateSum(int a, int b) {
  return a + b; // Trả về tổng của hai tham số
}

void main() {
  // Khai báo hai biến số nguyên
  int num1 = 24;
  int num2 = 13;

  // Gọi hàm calculateSum và lưu kết quả vào biến sum
  int sum = calculateSum(num1, num2);

  // In kết quả ra màn hình
  print("Tổng của $num1 và $num2 là: $sum");
}