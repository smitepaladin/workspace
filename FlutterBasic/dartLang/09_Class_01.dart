import 'calc01.dart';
import 'calc03.dart';
import 'clac02.dart';

main(){
  print("Property를 이용한 방법");
  Calc01 calc01 = Calc01(); // Calc01()은 생성자, calc01은 만든 변수로 객체라고 부른다.(=객체지향 프로그램)
  calc01.num1 = 1;
  calc01.num2 = 2;
  print("덧셈결과 : ${calc01.addition()}");
  print("뺄셈결과 : ${calc01.subtraction()}");
  print("곱셈결과 : ${calc01.multiplication()}");
  print("나눗셈결과 : ${calc01.division()}");
  print("");


  print("Method를 이용한 방법");
  Calc02 calc02 = Calc02();
  print("덧셈결과 : ${calc02.addition(1,2)}");
  print("뺄셈결과 : ${calc02.subtraction(1,2)}");
  print("곱셈결과 : ${calc02.multiplication(1,2)}");
  print("나눗셈결과 : ${calc02.division(1,2)}");  
  print("");

  print("생성자를 이용한 방법");
  Calc03 calc03 = Calc03(1,2);
  print("덧셈결과 : ${calc03.addition()}");
  print("뺄셈결과 : ${calc03.subtraction()}");
  print("곱셈결과 : ${calc03.multiplication()}");
  print("나눗셈결과 : ${calc03.division()}");  
  
} // main

