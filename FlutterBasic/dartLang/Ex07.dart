main(){
  int num1 = 10;
  int num2 = 4;

  // 덧셈 계산을 Function으로 작업하여 출력
  // 출력 내용 : "덧셈 결과는 14 입니다."

  // 뺄셈 계산을 Function으로 작업하여 출력
  // 출력 내용 : " 10 - 4 = 6"

  // 곱셈 계산을 Function으로 작업하여 출력
  // 출력 내용 : 40

  // 나눗셈 계산을 Function으로 작업하여 출력
  // 출력 내용 : 2.5


  String sum1 = addList(num1, num2);
  String mimus1 = minusList(num1, num2);
  int plus = plusList(num1, num2);
  double na = naList(num1, num2);

  print(sum1);
  print(mimus1);
  print(plus);
  print(na);


} //main

String addList(int num1, int num2){
  int sum = 0;
  sum = num1 + num2;
  String sum1 = "덧셈결과는 $sum 입니다.";
  return sum1;
}

String minusList(int num1, int num2){
  int minus = 0;
  minus = num1 + num2;
  String minus1 = "$num1 - $num2 = $minus";
  return minus1;
}

int plusList(int num1, int num2){
  int plus = 0;
  plus = num1 * num2;
  return plus;
}

double naList(int num1, int num2){
  double na = 0;
  na = num1 / num2;
  return na;
}



