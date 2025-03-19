// Collection은 데이터를 받아오는 기능

main() {
  // List collecction
  List threeKingdoms = [];

  // List에 데이터 추가하기
  // heap 메모리에는 threeKingdoms
  // data 메모리에는 아무것도 없음

  threeKingdoms.add("위");
  threeKingdoms.add("촉");
  threeKingdoms.add("오");
  threeKingdoms.add("We");

  print(threeKingdoms);

  // 원하는 데이터만 출력하기
  // 위 만 출력하기
  // 모든 언어의 시작 index는 0부터 시작한다(R제외하고)
  print(threeKingdoms[0]);

  // CRUD (만들고 수정하고 사용하고 지운다)

  // 수정 : 위 <- We
  threeKingdoms[0] = "We";
  print(threeKingdoms);

  // List의 삭제

  // Index번호로 삭제
  threeKingdoms.removeAt(1);

  // 데이터값으로 삭제
  threeKingdoms.remove('We');
  // 뒤의 We는 지워지지 않았다.

  print(threeKingdoms);

  // 데이터 갯수 파악
  print(threeKingdoms.length);

  // 숫자 등록하기
  threeKingdoms.add(1);
  print(threeKingdoms);

  // if -> for -> Func -> class -> Model 순서로 쓸 줄 알아야 한다.

  // ---------
  // List의 정해진 변수 타입(Generic)의 데이터만 추가하기
  // ---------

  List<String> threeKingdoms2 = [];
  threeKingdoms2.add('We');
  // threeKingdoms2.add(1);
  List<int> threekingdoms3 = [];
  threekingdoms3.add(1);
  // threekingdoms3.add('We');

  // List 선언시 초기값 설정
  List<String> threekingdoms4 = ['위', '촉', '오'];
  //위나라가 삼국을 통일했습니다.

  print("${threekingdoms4[0]}나라가 삼국을 통일했습니다.");
}
