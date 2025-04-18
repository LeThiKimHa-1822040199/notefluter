/*
Chuổi là một tập hợp ký tự UTF-16.
*/
void main(){
  var s1='kimha';
  var s2="kimha1";
  // Chèn giá trị của một biểu  thức hoặc một biến vào trong chuỗi:${....}
  double diemToan= 10;
  double diemMa=10;
  var s3= ' Nihao ma $s1, bn đã đạt đc tổng điểm là:${diemToan+diemMa}';
  print(s3);
  
  //Tạo ra chuỗi nằm ở nhiều dòng
  var s4 ='''
Dòng 1
Dòng 2
Dòng 3
''';
  var s5 ="""
Dòng 1
Dòng 2
Dòng 3
""";

var s6= " Xin chào các bn nhoá \n Mình sẽ là ng hướng dẫn các bn ";
print(s6);

var s7= r" Xin chào các bn nhoá \n m ngu";// raw
print(s7);

var s8= " Xin chào các bn nhoá \t Mình sẽ là ng hướng dẫn các bn ";// tab
print(s8);

var s9="Chuổi 2"+"Chuỗi 2";
print(s9);

var s10='Chuỗi';
"này"
"là"
"Caonima";
print( s10);
}