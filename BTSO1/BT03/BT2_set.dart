/*
Tính duy nhất của phần tử:

Set: Là một tập hợp các phần tử không trùng lặp. Nếu bạn cố gắng thêm một phần tử đã tồn tại, nó sẽ không được thêm vào.
List: Cho phép các phần tử trùng lặp. Bạn có thể có nhiều phần tử giống nhau trong một danh sách.
Thứ tự của phần tử:

Set: Không duy trì thứ tự của các phần tử. Khi bạn lặp qua một Set, thứ tự có thể không giống như khi bạn thêm các phần tử.
List: Duy trì thứ tự của các phần tử. Bạn có thể truy cập các phần tử theo chỉ số và thứ tự sẽ luôn được giữ nguyên.
Truy cập phần tử:

Set: Không hỗ trợ truy cập theo chỉ số. Bạn không thể lấy phần tử từ một Set bằng cách sử dụng chỉ số.
List: Hỗ trợ truy cập theo chỉ số. Bạn có thể lấy phần tử tại một vị trí cụ thể bằng cách sử dụng chỉ số.
*/
void main() {
  var set1 = {1, 2, 3};
  var set2 = {3, 4, 5};

  // Union (hợp)
  var union = set1.union(set2);
  print('Union: $union'); // Kết quả: {1, 2, 3, 4, 5}

  // Intersection (giao)
  var intersection = set1.intersection(set2);
  print('Intersection: $intersection'); // Kết quả: {3}

  // Difference (hiệu) của set1 với set2
  var difference = set1.difference(set2);
  print('Difference (set1 - set2): $difference'); // Kết quả: {1, 2}
}
/*
Đoạn code sau sẽ cho kết quả gì?
 
dartCopyvar mySet = Set.from([1, 2, 2, 3, 3, 4]);
print(mySet.length);
Khi chuyển đổi danh sách này thành Set, các phần tử trùng lặp sẽ bị loại bỏ.
Kết quả cuối cùng của mySet sẽ là: {1, 2, 3, 4}.
Kết quả in ra là  4
 */