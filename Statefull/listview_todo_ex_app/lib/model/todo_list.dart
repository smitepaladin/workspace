class TodoList { // Method없는 클래스를 Model이라고 부른다
  // Property
  String imagePath; // 이미지 파일 주소와 파일명
  String workList; // 사용자 입력값

  // Constructer
  TodoList(
    {
      required this.imagePath,  // required로 쓰인것은 반드시 있어야 한다.
      required this.workList
    }
  );
}