// Property를 이용한 방법
class Calc01{
  // Property(Attribute, Field)
  int num1 = 0;
  int num2 = 0;

  // Constructor(생성자) - 안 쓰면 기본 생성자가 만들어짐

  // Method // Class에 속해있으므로 Function이 아니다.
  int addition(){ //파라미터를 받은게 없다
    return num1 + num2;
  }


  int subtraction(){
    return num1 - num2;
  }


  int multiplication(){
    return num1 * num2;
  }


  double division(){
    return num1 / num2;
  }
} // Calc01