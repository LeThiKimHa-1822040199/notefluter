/**
 *Typedefs trong dart là một cách ngắn gọn để tạo các alias 
 * Làm việc với các loại dữ liệu  phức tạp
 * Rõ ràng dễ đọc và gần gũi
 * 
 * 
 */
typedef IntList=List<int>;
typedef ListMapper<X>=Map<X, List<X>>;


void main(){

IntList l1 =[2,4,1,2,0,4];
print(l1);
IntList l2 =[1,3,0,9,0,5];
print(l2);

Map<String, List<String>> m1={};// Khá dài
ListMapper<String>m2={};// m1 và m2 cùng 1 kiểu


}