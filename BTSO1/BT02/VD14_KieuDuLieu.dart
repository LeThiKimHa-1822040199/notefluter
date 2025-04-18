
void main (){
  //int là kiểu số nguyên
  int x =100;
  //  double là kiểu số thực
  double y =100.5;
  //num có thể chứa số nguyên hoặc chứa số thực
  num z =10;
  num t= 10.16;

  // Chuyển chuỗi sang số nguyên
  var one= int.parse('1');
  print(one==1? 'Đúng':'Sai');

  // Chuyển chuỗi sang số thực

  var onePointOne= double.parse('1.1');
  print(onePointOne==1.1);

  //Số nguyên => Chuỗi
  String oneAsString= 1.toString();
  print(oneAsString);
  //Số thực => Chuổi
String piAsString = 3.1459.toStringAsFixed(3);
print(piAsString);
}