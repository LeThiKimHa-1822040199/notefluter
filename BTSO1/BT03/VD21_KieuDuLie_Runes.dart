void main(){
  //Định nghĩa:
  //- Runes là tập hợp các điểm mã unicode của một chuỗi
  //- Dùng để xử lý các ký tự unicode đặc bieetk như emoji
  //- Được biểu diễn bằng số nguyên

  String str='Caonima';
  Runes runes1= str.runes;
  Runes runes2= Runes('\u2665');// trái tim
  print(runes2);
  Runes runes3= Runes('\u{1F600}');// mặt cười😭
  print(runes3);
}