main() {
  // 연산자
  // 자동 증감 연산자
  int num = 0;
  num = num + 1;
  num++;
  print(num);

  num--; // num = num -1
  print(num);

  num = num + 2;
  num += 2;
  print(num);

  // Optinal : Null Safety
  int num1 = 10;
  // int num2 = null; 불가능하다
  int? num2 = null; // 가능
  print(num2);

  num2 ??= 8; // num2값에 값이 없으면 8을 기본값으로 넣어주겠다.
  print(num2);

  int? num3; // 데이터를 안 넣어줘도 null이다.
  print(num3 ??= 5);

  // int num4;
  // print(num4++);

  // 조건 연산자
  int num5 = 10;
  int num6 = 5;

  print(num5 < num6);
  print(num5 > num6);
  print(num5 >= num6);
  print(num5 <= num6);
  print(num5 == num6);
  print(num5 != num6);

  // 논리 연산자
  bool result = 12 > 10 && 1 > 0; // true && true ==> true
  print(result);

  bool result2 = 10 > 5 || 1 > 2; // false || false ==> false
  print(result2);
}
