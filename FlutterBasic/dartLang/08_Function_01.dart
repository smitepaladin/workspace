// 펑션과 메소드
// 클라스에 있는 펑션을 메소드라고 한다.
main(){
  List<int> list1 = [1,3,5,7,9];
  List<int> list2 = [10,30,50,70,90];



  // 동일한 기능의 코드인데 중복되어 코딩함.

  //  addList(list1); // function은 메인 안 밖 상관이 없다.
  //  addList(list2);
  int sum1 = addList(list1); //addList도 타입이 int가 된 것을 확인 할 수 있다.
  int sum2 = addList(list2);

  print("리스트의 합계는 $sum1 입니다.");
  print("리스트의 합계는 $sum2 입니다.");  

} // main

int addList(List<int> list11){ // 함수에서는 타입을 지정해줘야 한다. - dynamic은 메모리를 너무 많이 차지
  int sum = 0;
  for(int li in list11){
    sum += li;
  }
  return(sum); // function에서 작업을 마무리 하면 안된다. 리턴해줘야 한다.
}
