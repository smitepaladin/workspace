main(){
  int num1 = 10;
  int num2 = 4;

  // 덧셈 계산을 Function으로 작업하여 출력
  // 출력 내용 : "덧셈 결과는 14 입니다."
  print(addFunction(num1, num2));

  // 뺄셈 계산을 Function으로 작업하여 출력
  // 출력 내용 : " 10 - 4 = 6"
  print(subFunction(num1, num2));  


  // 곱셈 계산을 Function으로 작업하여 출력
  // 출력 내용 : 40
  print(mulFunction(num1, num2));  

  // 나눗셈 계산을 Function으로 작업하여 출력
  // 출력 내용 : 2.5
  print(divFunction(num1, num2));  


  // function 하청 주려면 적어도 숫자 2개를 넘겨줘야 한다.

} //main

String addFunction(int num1, int num2){
  return("덧셈 결과는 ${num1 + num2} 입니다.");
}

String subFunction(int num1, int num2){
  return("$num1 - $num2 = ${num1 - num2}");
}

int mulFunction(int num1, int num2){
  return(num1 * num2);
}

double divFunction(int num1, int num2){
  return(num1 / num2);
}
