main() {
  // 문자열
  // 객체형 타입이라 대문자로 시작한다
  String str1 = "유비";
  String str2 = "장비";

  // 유비 : 장비

  print(str1 + " : " + str2);

  int intNum1 = 10;
  int intNum2 = 20;

  // 10 + 20 = 30
  // print(intNum1 + "+" + intNum2 + "=" + intNum1 + intNum2);

  // 문자열 보간법 (String Interpolation)
  // 유비 : 장비

  print("$str1 : $str2");
  String result = "$str1 : $str2";
  print(result);

  print("$intNum1 + $intNum2 = ${intNum1 + intNum2}");
  // ${}는 코드다.
}
