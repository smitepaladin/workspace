// List를 이용하여 5보다 작은 숫자만 List에 넣기

main(){
  List<int> nums = [1,1,2,3,5,8,13,21,34,66,89]; // 데이터가 많은 변수는 뒤에 _s를 넣어서 구분을 하자.
  List<int> result = [];

  for(int num in nums){ // start변수만 i를 쓰지 다른 변수를 i로 넣지 않는것이 좋다.
    if(num < 5){
      result.add(num);
    }
  }

  print(result);


  // List Comprehension

  print([for(int num in nums) if(num<5) num]);


}