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
  int endNum = 10;

  for(int i=startNum;i<=endNum;i++){ // 위의 i와는 다른 지역변수이다.
    sum += i; //sum = sum + i
  }
  print('$startNum부터 $endNum까지의 합계는 $sum 입니다.');

  // Exercise
  // 1부터 10까지의 수 중 짝수의 합과 홀수의 합 구하기(단, for문은 1개만 사용, 수의 범위는 변경 가능하다.)
  // 출력 예시 : 1부터 10까지의 수 중 짝수의 합은 _이고 홀수의 합은 _ 입니다.

  int oddTot = 0;
  int evenTot = 0;
  int snum = 1;
  int eNum = 100;



  for(int i=snum;i<=eNum;i++){
    if(i%2==0){
      evenTot += i;
    }else{
      oddTot += i;
    }
    
  }

  print("$snum부터 $eNum까지의 수 중 짝수의 합은 $evenTot이고 홀수의 합은 $oddTot입니다.");


  // List를 반복문에 사용하기
  List<int> numList = [1,3,5,7,9];
  int sumList = 0;
  for(int i=0; i < numList.length; i++){
    sumList += numList[i];

  }

  print(sumList);


  sumList = 0;
  for(int num in numList){
    sumList += num;
  }

  print(sumList);

  // while
  int sumNum = 0;
  int number = 1;
  while(number <= 10){
    sumNum += number;
    number++;
    }
  print(sumNum);


  while(number <= 100){
    if(number > 10){
      break;
    }
    number++;
  }

  for(int i=1; i<=10; i++){
    if(i==5){
      continue; // 5가 걸린경우 밑의 소스코드로 가지 않고 처음으로 돌아간다. 그렇기 때문에 5가 출력되지 않는것.
    }
    print(i);
  }


}