/*
dart là ngôn ngữ thuần hướng đối tượng, vì vậy ngay cả các hàm cũng là đối tượng và có kiểu function
Nghĩa là các hàm có thể được gán cho các biến hoặc truyền làm tham số 
Ta cũng có thể g ọi một thể hiện intance của một lớp dart là một hàm

*/

/*
Hàm là một khối lệnh thực hiện một tác vụ j đó , khối lệnh này được dùng nhiều
lần nên gom chúng lại thành một hàm

 */

//Viết đầy đủ

double tinhtong( var a, double b, double c){
  return a+b+c;
}

//Sử dụng cú pháp rút gọn"=>"
double tinhtong1(var a, double b, double c)=> a+b+c;


// Hàm với tên của tham số
//Khi gọi 1 hàm function ta có thể truyền giá trị thông qua tên biến paramName: value.
String createFullNam({String ho=" ", String chulot=" ", String ten=""}){
  return ho+" "+chulot+" "+ten;
}

//Tham số tuỳ chọn( có hay ko cũng được)
/*
Các tham số tuỳ chọn trong hàm cho phép ta gọi hàm mà ko cần cung cấp đầy đủ tất cả các tham số.
Khi các tham  số tuỳ chọn ko được cung caapos , chúng sẽ nhận giá trị nulll theo mặc định.
để khai báo = []

 */
double sum(double a,[double? b, double? c, double? d]){
  var result= a;
  result +=(b!=null)?b:0;
   result +=(c!=null)?c:0;
    result +=(d!=null)?d:0;
    return result;
}


//Hàm ẩn danh
/*

Hàm  Lambda hoặc closure
ko cần sử dụng tên hàm
ko có kiểu dữ liệu trả về

*/
//(var a , var b){
//  return a+b;
//}


//Hàm main(): Khởi đầu ứng dụng
void main(){
print('Chú khỉ Buồn ');
var x = tinhtong(24, 12, 04);
print(x);

var y = tinhtong1(13, 09, 05);
print(y);

var fn=createFullNam(ho:"Chú",chulot: "Khỉ",ten: "Buồn");
print(fn);

var fn2=createFullNam(chulot: "Khỉ",ten: "Buồn",ho:"Chú");
print(fn2);

print(sum(24));
print(sum(24, 12));
print(sum(24, 12,0,4));
print(sum(13, 09,0,5));

var ham=(var a ,var b)
{
  return a+b;
};
var ham1=(var a ,var b)=> a+b;

print(ham(2,4));

}
