// main에서 지정한 숫자를 가지고 구구단을 출력하는 클래스를 생성
// 단, 클래스와 데이터 전달 방법은 생성자를 이용한다.
// 출력시 곱해지는 수 중 홀수는 *로 표시한다.

// 결과

/*
5 X * = 5
5 X 2 = 10
5 X * = 15
5 X 4 = 20
5 X * = 25
5 X 6 = 30
5 X * = 35
5 X 8 = 40
5 X * = 45
*/


main(){
  Gugudan gugudan = Gugudan(4);
  gugudan.gugudanPrint();
}


class Gugudan{
  // Property
  late int dan;
  // Constructor
  Gugudan(int dan)
  : this.dan = dan;



  // Method
  gugudanPrint(){
    print("**** $dan ****");
      for(int i = 1; i < 10; i++){
      if(i % 2 == 1){
        print("$dan X $i = ${dan * i}");
      }else{
        print("$dan X * = ${dan * i}");
      }
    }

  }
}