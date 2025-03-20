// 입력한 한 자릿수 정수의 합 구하기
// 입력숫자 : 12345678
// 결과
// Sum of 12345678 = 36


main(){
  int num = 12345678;
  int numOne = num;
  int remainder = 0;
  int sum = 0;

  while(numOne != 0){
    remainder = numOne % 10;
    sum += remainder;
    numOne = numOne ~/ 10;
  }

  print("Sum of $num = $sum");
}