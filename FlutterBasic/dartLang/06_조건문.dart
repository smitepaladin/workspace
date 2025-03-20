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
}