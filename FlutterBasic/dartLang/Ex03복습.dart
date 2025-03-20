// List의 최댓값과 최댓값 위치 구하기

// 결과
// 숫자들 중 최댓값은 15이고 5번째 값 입니다.
// List<int> num = [11,12,11,15,12];


main(){
  List<int> num = [11,12,11,15,12];

  int maxValue = num[0];
  int loopCount = 0;
  int maxIndex = 0;

  for(int i in num){
    loopCount++;
    if(i > maxValue){
      maxValue = i;
      maxIndex = loopCount;
    }
  }
  print("숫자들 중 최댓값은 $maxValue이고 $maxIndex번째 값 입니다.");
}

