main() {
  //Map : Key와 Value로 이루어진 Collecion
  Map fruits = {
    'apple': '사과', //apple이 Key값, 사과가 Value값
    'grape': '포도',
    'watermelon': '수박', // 이것이 JSON 이다
  };

  print(fruits['apple']);

  //수정하기
  fruits['watermelon'] = '시원한 수박';

  // 데이터 추가하기
  fruits['banana'] = '바나나';
  print(fruits);

  // Map 새로운 구성
  Map carMakers = {};
  carMakers['aaa'] = "AAA";
  carMakers.addAll({'hyundai': '현대자동차', 'kia': '기아자동차'});
  print(carMakers);

  // Map의 Key만 따로 출력하기
  print(carMakers.keys.toString()); // 출력결과를 보면 소괄호로 나오는데, 이것을 Tuple이라 한다.
  // Tuple : List와 비슷하지만 읽기전용이다.
  print(carMakers.keys.toList()); // List 타입이므로 수정할 수 있다.
  print(carMakers.values.toList()); // List

  var carMakersNames =
      carMakers.keys
          .toString(); //String을 써야하는지 List를 써야하는지 모른다면 var로 받아서 받아보고 결정지으면 된다.

  // Generic 선언
  Map<String, int> fruitsPrice = {
    'apple': 1000,
    'grape': 2000,
    'watermelon': 3000,
  };

  print(fruitsPrice['apple']);
  int applePrice = fruitsPrice['apple']!; // Map에서 발생하는 optinal !로 처리
  print("사과의 가격은 $applePrice 입니다.");
}
