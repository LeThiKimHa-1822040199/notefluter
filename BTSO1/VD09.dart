void main(){
  Object obj ="win";
  //Kiểm tra obj có phải là string
  if(obj is String){
    print('obj là một string ');
  }
  //Kiểm tra không phải kiểu int
  if(obj is! int)
  {
    print('obj ko phải là số nguyên ');
  }
  //ép kiểu
  String str=obj as String;
  print(str.toUpperCase());
}