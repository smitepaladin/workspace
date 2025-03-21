  // 1부터 10까지 합을 구하고 그 합이 홀수인지 짝수인지 출력
  // 단, 클래스 1개 생성 클래스 Method를 2개(합계, 홀짝수판단)
  // 숫자의 범위는 main에서 선정한다.
  // 클래스와의 데이터 연계 방법은 생성자를 사용한다.


  // 결과
  /*
    1부터 10까지의 합은 55입니다.
    1부터 10까지의 합은 홀수 입니다.
  */
main(){
  int startNum = 20;
  int endNum = 12;

  Calc calc = Calc.check(startNum, endNum);
  int sum = calc.sumCalc();
  String result = calc.evenOdd(sum);

  print("$startNum 부터 $endNum 까지의 합은 $sum 입니다.");
  print("$startNum 부터 $endNum 까지의 합은 $result 입니다.");
}


class Calc{
  // Property

  late int num1;
  late int num2;

  // Constructor
  Calc(int num1, int num2)
  : this.num1 = num1,
    this.num2 = num2;


  // factory 생성자
  factory Calc.check(int num1, int num2){
    int startNum = 0;
    int endNum = 0;


    if(num1 > num2){
      startNum = num2;
      endNum = num1;
    }else{
      startNum = num1;
      endNum = num2;
    }
    return Calc(startNum, endNum);
  }


  // Method
  int sumCalc(){
    int sum = 0;
    for(int i=num1;i<=num2;i++){
    sum += i;
      }
      return sum;
    }

  String evenOdd(int sum){
    String result = "";
    if(sum %2 == 0){
        result = "짝수";
    }else{
      result = "홀수";
    }
    return result;
  }
  }

