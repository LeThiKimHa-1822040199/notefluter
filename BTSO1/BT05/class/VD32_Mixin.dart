/*
Mixin là một lớp có chứa các phương thức và thuộc tính dùng để gộp vào một lớp
khác. Mixin không thể được sử dụng để tạo đối tượng trực tiếp. Để sử dụng mixin, sử
dụng từ khóa with.
*/

mixin M {
  void showSomething() {
    print('Print message ...');
  }
}

class A {
  String name = 'Class A';
  void displayInformation() {
    print('Information from A kimha');
  }
}

class B extends A with M {
  @override
  void displayInformation() {
    showSomething();
  }
}

void main() {
  var b = B();
  b.displayInformation(); // Kết quả: Print message ...
}
