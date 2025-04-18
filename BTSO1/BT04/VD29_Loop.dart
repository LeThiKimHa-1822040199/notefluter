void main(){
// Vòng lặp for
for(var i=1; i<=5;i++){
  print(i);
}
// Interable : List Set
//for-in
var names= ["Duong","Thanh","Ngan"];
for(var name in names){
  print(name);
}

// While
var i =24;
while(i<=2005){
  print(i);
  i++;
}

//Do-While
var x=13;
do{print(x);
x++;

}while(x<=2005);

//break/ continue
var c=13;
do{print(c);
x++;
if(c==2005) break;

}while(c<=2005);


var d=13;
do{print(d);
x++;
if(d==2005) continue;

}while(d<=2005);
}