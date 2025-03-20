main(){
  // for문
  // 1부터 10까지 출력해보기
  // for 밖에서 선언한다면 전역변수이다.


  for(int i=1;i<=10;i++){
    print(i);
  }


// 1부터 10까지 합 구하기
// for문은 범위 증가밖에 하지 못한다
  int sum = 0;
  int startNum = 1;
  int endNum = 100;

  for(int i=startNum;i<=endNum;i++){ // 위의 i와는 다른 지역변수이다.
    sum += i; //sum = sum + i
  }
  print('$startNum부터 $endNum까지의 합계는 $sum 입니다.');


}