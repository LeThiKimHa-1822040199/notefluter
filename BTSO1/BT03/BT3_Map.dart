void main() {
  // Khai báo Map
  Map<String, dynamic> user = {
    'name': 'Duy',
    'age': 20,
    'isStudent': true
  };

  // 1. Thêm email: 'duy@gmail.com'
  user['email'] = 'duy@gmail.com';

  // 2. Cập nhật age thành 21
  user['age'] = 21;

  // 3. Xóa trường isStudent
  user.remove('isStudent');

  // 4. Kiểm tra xem Map có chứa key 'phone' không
  bool hasPhone = user.containsKey('phone');

  // In ra kết quả
  print('User  Map: $user'); // In ra nội dung của Map
  print('Có chứa key "phone": $hasPhone'); // In ra kết quả kiểm tra
  /*So sánh hai cách truy cập giá trị trong Map:
 
  dartCopyuser['phone']
user['phone'] ?? 'Không có số điện thoại'*/
var user1 = {
  'name': 'Nam',
  'age': 20,
};

var phone = user1['phone']; // phone sẽ là null vì không có key 'phone'
print(phone); // Kết quả: null
  /*
Viết một hàm nhận vào một Map và in ra tất cả các cặp key-value, mỗi cặp trên một dòng.
   */
  void printMap(Map<String, dynamic> map) {
  map.forEach((key, value) {
    print('$key: $value');
  });
}

void main() {
  // Ví dụ về một Map
  Map<String, dynamic> user2 = {
    'name': 'Nam',
    'age': 20,
    'email': 'nam@gmail.com',
    'isStudent': true
  };

  // Gọi hàm để in ra các cặp key-value
  printMap(user2);
}
}