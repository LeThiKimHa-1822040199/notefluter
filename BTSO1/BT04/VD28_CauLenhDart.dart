import 'dart:ffi';

void main(){

  int x=100;
  if(x is! Int8){
    print("Đây là một con số");
  }else if(x%2==0){
    print("Đây là số chẵn");

  }else{
    print("Đây là số lẻ");
  }

  int thang =5;
switch(thang){
case 2:
print("Tháng $thang có 28 ngày");
  case 1:
  case 3:
  case 5:
  case 7:
case  8:
case 10:
case 12:
print ("Tháng $thang có 31 ngày");
  break;
  case 4:
  case 6:
  case 9:
  case 11:
print ("Tháng $thang có 30 ngày");
break;
  default:
  print("Tháng $thang ko xác định");
}


}