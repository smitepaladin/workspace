main(){
  // 조건문 (Conditinal Statement)
  int num1 = 5;
  String result = "";
  
  if(num1 > 10){ // 이 중괄호 area를 Scope라고 한다.
    result = "10보단 큰";
  }else if(num1 < 10){
    result = "10보다 작은";
  }else{ // else만 쓰면 Scope가 없다
    result = "10과 같은";
  }

print("입력된 숫자 $num1은(는) $result 수 입니다.");


int num2 = 14;

switch(num2 % 5){
  case 0:
  print('입력된 숫자 $num2는 5의 배수 입니다.');
  default:
  print('입력된 숫자 $num2는 5의 배수가 아니며 나머지 값은 ${num2%5} 입니다.');
}

}

// Exercise
// 변수에 있는 숫자 값을 비교해서
// 숫자가 5의 배수이면 '입력된 숫자 __는 5의 배수입니다'
// 숫자가 5의 배수가 아니면 '입력된 숫자 __는 5의 배수가 아니며 나머지 값은 __입니다.'



// Switch

