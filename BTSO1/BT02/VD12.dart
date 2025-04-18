/*
expr1? expr2: expr3;
nếu expr1 đúng, trả về expr2; ngược lại , trả về expr 3

expr1 ?? expr2 ;
nếu expr1 ko null . trả về  giá trị của nó;
ngược lại trả về giá trị expr2;


*/
void main (){
  var KiemTra = (100 %2==0)?"100 là số chẵn ":"Ngược lại là số lẻ";
  print(KiemTra);

  var x =100;
  var y= x ?? 50;
  print (y);
  int ? z;
  y = z ?? 30;
  print (y);
}