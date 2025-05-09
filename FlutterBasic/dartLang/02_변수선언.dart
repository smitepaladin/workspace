main() {
  // 변수 선언
  // 메모리에 자기가 쓸 공간을 확보하는 것
  // 변수에 타입에 따라 선언하는 종류가 다름(정수 실수 문자 문자열)
  // var 변수 선언 : 데이터에 의한 추론형 변수 선언
  var name = "유비";
  name = "장비";

  // var name = "유비"; 에서는 heap에 name가 들어가고 data에 유비가 들어간다.
  // = (assign) 을 통해서 heap과 data 가 연결됨
  // name = "장비"; 에서 data 유비가 장비로 바뀜
  print(name);

  var height = 100;
  print(height);

  // 컴퓨터, 앱 할것없이 화면에 출력되는 모든것은 문자이다
  // 사용자가 입력한 모든것을 받아온다 한들 문자이다.
  // 받아올 때 정수로 바꿔줘야 한다.
  // 모든 처리가 끝나고 화면에 출력할 때 다시 문자로 바꿔줘야 한다.
  // 프로그램 내부적으로만 문자와 숫자를 구분할 뿐이다.
  // 화면에 모든것을 문자로 출력하는 것은 암호화를 위해서이다.

  var weight = 45.8;
  print(weight);

  var gender = true;
  // true나 false가 문자라면 쌍따옴표나 따옴표가 들어가야 하는데 안 들어가있다
  // bool타입이다.
  // 1이 true고 0이 false이다.
  // bool < int < double < string 순으로 메모리를 차지한다.
  // if for collecton 모두 bool을 참조한다.

  gender = false;

  // 내 친구의 이름은 장비 입니다.

  print("내 친구의 이름은 " + name + " 입니다.");
  // Dart에서는 쉼표를 두개 쓸 수가 없다.
  // 같은 타입으로 맞춰줘야만 출력이 가능하다.
  // 노란표시 1이 뜨는것은 gender를 변수로 선언해 놓고 한번도 안 썼기 때문이다.
  // 지워서 메모리 아끼라고 표시해주는것
}
