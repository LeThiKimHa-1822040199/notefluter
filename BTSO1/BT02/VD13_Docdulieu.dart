import 'dart:io';
void main()
//Nhập tên người dùng
{
  stdout.write('Nhập tên vào :');
String name= stdin.readLineSync()!;

 // Nhập tuổi ng dùng
    stdout.write('Nhập tuổi vào :');
int age= int.parse(stdin.readLineSync()!);

print("hello: $name ,Your age :$age");

}