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

// 삼항연산자 ** 매우 중요 **
// 디자인에서도 사용 가능하며, 앱에서 데이터를 받아올 때 다 받아왔을 경우, 못 받아왔을 경우를 생각하여 두가지를 모두 준비해야한다. 그 때 사용한다.

bool isPublic = false;
var vis = isPublic ? "True" : "False"; // 기본 true
print(vis);

}


