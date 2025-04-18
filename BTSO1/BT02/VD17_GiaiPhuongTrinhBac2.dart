
/*
ax^2+bx+c=0;

*/
import 'dart:math';
import 'dart:io';

void main(){
double a = 0,b=0,c=0;
  do{
    stdout.write("Nhập cho đúng hệ số a vào cho tao(a khác 0):");
    String? input= stdin.readLineSync();
    if(input!=null){
      a= double.tryParse(input)?? 0;// try parse là có bắt lỗi
    }
  }while(a==0);

stdout.write("Nhập b:");
String? inputB= stdin.readLineSync();
if(inputB!=null){
      b= double.tryParse(inputB)?? 0;// try parse là có bắt lỗi
    }

stdout.write("Nhập c:");
String? inputC= stdin.readLineSync();
if(inputC!=null){
      c= double.tryParse(inputC)?? 0;// try parse là có bắt lỗi
    }

    //Tính Delta
    double Delta= b*b -4*a*c;
    //Hiện Thị phương trình ra
    print('Phương trình: ${a}x^2+${b}x+$c=0');
    //GPT
    if(Delta<0){
      print('Phương trình vô nghiệm !');

    }else if(Delta==0){
      double x = -b/(2*a);
      print("Phương trình có nghiệm kếp x1=x2=${x.toStringAsFixed(2)}");
    }else{
      double x1 =(-b-sqrt(Delta))/(2*a);
       double x2 =(-b+sqrt(Delta))/(2*a);
       print(("Phương trình có 2 nghiệm phân biệt :"));
       print('x1 =${x1.toStringAsFixed(2)}');
            print('x2 =${x2.toStringAsFixed(2)}');
    }
}