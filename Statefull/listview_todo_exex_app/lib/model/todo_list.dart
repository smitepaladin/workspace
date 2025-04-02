class TodoList {
  //Property

  String imagePath; // 이미지 파일 주소와 파일명
  String workList; // 사용자 입력값, 할일 Late를 안 쓰는 이유는 required 때문이다.

  // Constructer
  TodoList(
    {
      required this.imagePath,
      required this.workList
    }
  );
}
