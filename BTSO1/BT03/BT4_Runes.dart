
/*
 Runes là một khái niệm trong Dart dùng để đại diện cho các giá trị Unicode, cho phép bạn làm việc với các ký tự không nằm trong bảng mã ASCII, chẳng hạn như emoji và các ký tự từ các ngôn ngữ khác. Dưới đây là một số thông tin chi tiết về Runes và cách tạo và thao tác với chúng, đặc biệt là với emoji.
 */
void main() {
  var runes = Runes('\u{1F60A}'); // Tạo Runes từ giá trị Unicode
  print(String.fromCharCodes(runes)); // Kết quả: 😀



   var text = 'Hello \u{1F60A}'; // Chuỗi có emoji
  for (var rune in text.runes) {
    print(rune); // In ra từng giá trị Unicode scalar
  }


  // Tạo một chuỗi có chứa emoji
  var emoji = '👨‍👩‍👧‍👦'; // Gia đình emoji

  // In ra các giá trị Runes
  print('Runes của emoji: ${emoji.runes.toList()}'); // In ra danh sách các giá trị Unicode

  // Lặp qua từng Runes
  for (var rune in emoji.runes) {
    print('Ký tự: ${String.fromCharCode(rune)}'); // In ra ký tự tương ứng
  }
}