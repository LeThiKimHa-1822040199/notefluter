/*

Record là một kiểu dữ liệu tooongrt hợp 
Cho phbeps nhóm nhiều giá trị cóp kiểu dữ liệu khác nhau thành một đơn vị duy nhất
Record là imutalbe - Nghĩa là ko thể thay đổi sau khi được tạo

 */

void main(){
  var r=('first',x:13,09,05);//record

  //Định nghĩa record có 2 giá trị
  var point =(2412,2004);

  //Định nghĩa PerSon
  var person=(name:'Ngan', age:20,5);

//Truy xuất giá trong Record
//Dùng chỉ số
print(point.$1);//2412
print(point.$2);//2004
print(person.$1);

//Dùng tên 
print(person.name);
print(person.age);
}