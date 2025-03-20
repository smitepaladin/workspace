// Exercise
// num2가 2의 배수이면 '2의 배수 입니다.'
// num2가 3의 배수이면 '3의 배수 입니다.'
// num2가 5의 배수이면 '5의 배수 입니다.'

main(){
  int num2 = 10;

  if(num2 % 2 == 0){
    print("'2의 배수 입니다.'");
  }if(num2 % 3 == 0){
    print("'3의 배수 입니다.'");
  }if(num2 % 5 == 0){
    print("'5의 배수 입니다.'");
  }
// 3개가 모두 다른 조건이므로 elseif로 묶을 수 없다
// elseif는 같은조건 하에서 나눌 때 사용한다

  // Exercise
  // 점수를 입력받아 학점으로 표시하기
  // 90점 이상이면 : '입력하신 점수 __는 A학점 입니다.'
  // 80점 이상이면 : '입력하신 점수 __는 B학점 입니다.'
  // 70점 이상이면 : '입력하신 점수 __는 C학점 입니다.'
  // 60점 이상이면 : '입력하신 점수 __는 D학점 입니다.'
  // 60점 미만이면 : '입력하신 점수 __는 F학점 입니다.'

  int score = 100;
  String result = "";

  if(score > 100 || score <0){
    print('Data를 확인하세요');
  }else{
  
  if(score >= 90){
    result = "A학점";
  }else if(score >= 80){
    result = "B학점";
  }else if(score >= 70){
    result = "C학점";
  }else if(score >= 60){
    result = "D학점";
  }else{
    result = "F학점";
  }
  print("입력하신 점수 $score는 $result입니다.");
  }


// switch 문으로 해보기

if(score > 100 || score <0){
    print('Data를 확인하세요');
}else{

switch(score ~/ 10){
  case 10:
  case 9:
  result = "A학점";
  case 8:
  result = "B학점";
  case 7:
  result = "C학점";
  case 6:
  result = "D학점";
  default:
  result = "F학점";
  }

  print("입력하신 점수 $score는 $result입니다.");

  }

}

