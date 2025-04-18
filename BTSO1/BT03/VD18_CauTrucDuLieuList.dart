void main(){
  //Định nghĩa:
  //- List là tập hợp các phần tử có thứ tự và có thể trùng lập
  //- Các phần tử đc truy cập bằng index
  // Kích thước thay dổi được
  List<String> list1=['K','I','M','H','A'];//trực tiếp
  var list2 =[1,3,0,9,0,5];//sử dụng var để tự nhận biết kiểu dữ liệu
  List<String> list3=[];//List rỗng
  var list4 = List<int>.filled(3,0);// List có tích thước cố định và chứa [0 0 0]
  print(list2);
//1. Thêm phần tử
list1.add('D');//Thêm một phần tử
list1.addAll(['u','y']);//Thêm nhiều phần tử
list1.insert(7, 'Z');//Chèn 1 phần tử
list1.insertAll(1,['1','0']);//Chèn nhiều phần tử
print(list1);

//2. Xoá phần tử bên trong list
list1.remove('Z');// Xoá phần tử có giá trị Z nếu có 2 nó chỉ xoá 1
list1.removeAt(0);// Xoá một phần tử tại vị trí nào đó trong list
list1.removeLast;// Xoá phần tử tại vị trí cuối
list1.removeWhere((e)=>e=='B');// Xoá theo điều kiện
list1.clear();
print(list1);

//3. Truy cập phần tử:
print(list2[0]);// Lấy phần tử tại vị trí 0
print(list2.first);// Lấy phần tử đầu tiên
print(list2.last);// Lấy phần tử cuối cùng
print(list2.length);//Độ dài list

//4. Kiểm tra
print(list2.isEmpty);// List này có bị rỗng ko
print('List 3:${list3.isNotEmpty?' Khổng rỗng':'Rỗng'}');
print(list4.contains(1));
print(list4.contains(0));
print(list4.indexOf(0));
print(list4.lastIndexOf(0));

//5. Biến đổi
 list4=[2,4,1,2,0,4];
 list4.sort();// Sắp xếp tăng dần
 print(list4);
 list4.reversed;// Đảo ngược lại
 print(list4.reversed);
 list4= list4.reversed.toList();
 print (list4);
 
 // Cắt và nối
 var subList= list4.sublist(1,3);// cắt một sublist từ 1 đến < 3
 print(subList);
var str_joined= list4.join(",");
print(str_joined);

//8. Duyệt các phần tử bên trong list
list4.forEach((element){
  print(element);
});



}