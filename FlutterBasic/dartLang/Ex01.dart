// Factorial 구하기
// 4! = 4 * 3 * 2 * 1
// 결과
// 4's factorial value = 24


main(){
  int inputValue = 4; // 단, 데이터는 변경 가능해야한다.
  int fac = 1;
  for(int i=1; i <= inputValue; i++){
    fac = fac*i;
  }

  print("$inputValue's factorial value = $fac");


}