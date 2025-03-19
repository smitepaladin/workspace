main() {
  // var와 dynamic
  // dynamic은 파이썬의 변수타입
  var name = "유비";
  name = "관우";
  // var는 뒤의 데이터 타입을 보고 판단을 한다.
  // name = 1; 에러

  dynamic name1 = "장비";
  name1 = "조자룡";
  name1 = 10;
  // dynamic은 뭐든 잘 들어간다.

  int num1 = 100;
  print(name1 + num1);
  // Dart만이 dynamic과 int를 같이 연산할 수 있다. 다른언어는 X, 별로 좋은 케이스가 아니다.
  
  
}
