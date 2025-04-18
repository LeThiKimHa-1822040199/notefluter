void  main(){
  //Khai báo list
var list1 = ['A', 'B', 'C'];
print(list1);
//Thêm Phần tử D vào cuối list
list1.add('D');
print(list1);
//Chèn phần tử X vào vị trí thứ 1
list1.insert(1, 'X');
print(list1);
//Xoá phần tử B
list1.remove('B');
//In độ dài List
print('Độ dài list:${list1.length}');
/*Đoạn code sau sẽ cho kết quả gì?

dartCopyvar list = [1, 2, 3, 4, 5];
list.removeWhere((e) => e % 2 == 0);
print(list);

remove where ở trên được hiểu là số chẳn chia hết cho 2
1%2= false
2%2= true
3%2=false
4%2=true
5%2=false

các số còn lại sau khi in  ra là 1 3 5
*/
list1.remove('Z');// Xoá phần tử có giá trị Z nếu có 2 nó chỉ xoá 1
list1.removeAt(0);// Xoá một phần tử tại vị trí nào đó trong list
list1.add('D');//Thêm một phần tử
list1.addAll(['u','y']);//Thêm nhiều phần tử
list1.insert(7, 'Z');//Chèn 1 phần tử
list1.insertAll(1,['1','0']);//Chèn nhiều phần tử
}