main(){
  int num1 = 10;
  int num2 = 4;

  // 덧셈 계산을 Function으로 작업하여 출력
  // 출력 내용 : "덧셈 결과는 14 입니다."
  print(calcFunction(num1, num2, "add")); // num1, num2, "add"는 파라미터라고 부른다.

  // 뺄셈 계산을 Function으로 작업하여 출력
  // 출력 내용 : " 10 - 4 = 6"
  print(calcFunction(num1, num2, "sub"));  


  // 곱셈 계산을 Function으로 작업하여 출력
  // 출력 내용 : 40
  print(calcFunction(num1, num2, "mul"));  

  // 나눗셈 계산을 Function으로 작업하여 출력
  // 출력 내용 : 2.5
  print(calcFunction(num1, num2, "div"));  


  // function 하청 주려면 적어도 숫자 2개를 넘겨줘야 한다.

} //main

calcFunction(int num1, int num2, String part){ //모든 타입을 받아들이기 위해 dynamic이다. , num1, num2는 argument라고 부른다. //num1부터 파라미터가 순서대로 들어온다
  switch(part){
    case"add":
      return("덧셈 결과는 ${num1 + num2} 입니다.");
    case"sub":
      return("$num1 - $num2 = ${num1 - num2}");
    case"mul":
      return(num1*num2);
    default:
      return(num1/num2);
  }
  
}
