// 입력한 한 자릿수 정수의 합 구하기
// 입력숫자 : 12345678
// 결과
// Sum of 12345678 = 36

main(){
  int inputValue = 12345678;
  int value = inputValue;
  int remainder = 0;
  int sum = 0;

  while(value !=0){
    remainder = value % 10;
    sum += remainder;
    value = value ~/ 10;
  }

  print("Sum of $inputValue = $sum");

}