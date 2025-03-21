main(){
  int n1 = 10;
  int n2 = 20;
  
Sub sub = Sub(n1, n2);
print(sub.addition());
print(sub.substraction());


} // main

class Add{
   // Property
  late int num1; // late를 만나면 일단 멈추고 만들어져야 생성자를 가져온다. 초기 데이터값을 안 준 상태
  late int num2;

   // Consructor
  Add(int num1, int num2)
  : this.num1 = num1, // this가 붙은 변수는 Property로 가는 변수이다.
    this.num2 = num2;

   // Method
  int addition(){
    return num1 + num2;
  }
  
}


class Sub extends Add{  // Add에서 상속을 받아오자. Property와 Method를 다 가져올 수 있으나 생성자는 못 가져온다.
  Sub(super.num1, super.num2); // super는 나의 위를 뜻하므로 여기서는 Add이다
  int substraction(){
    return num1 - num2;
  }
}
