// Property를 이용한 방법
class Calc03{
  // Property(Attribute, Field)
  int _num1 = 0; // 언더바는 Private의 의미를 가진다.
  int _num2 = 0;

  // Constructor(생성자)

Calc03(int num1, int num2) // <- public으로 받아온 변수를 private에 넣어준다.
: _num1 = num1,
  _num2 = num2;



  // Method // Class에 속해있으므로 Function이 아니다.
  int addition(){ //파라미터를 받은게 없다
    return _num1 + _num2;
  }


  int subtraction(){
    return _num1 - _num2;
  }


  int multiplication(){
    return _num1 * _num2;
  }


  double division(){
    return _num1 / _num2;
  }
} // Calc03