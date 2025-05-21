class ImageTodoList {
  final int? seq;
  final String contents;
  final String image;
  final String insertdate;
  

  ImageTodoList(
    {
      this.seq,
      required this.contents,
      required this.image,
      required this.insertdate,
    }
  );


  factory ImageTodoList.fromJson(Map<String, dynamic> json){
    return ImageTodoList(
      seq: json['seq'],
      contents: json['contents'],
      image: json['image'],
      insertdate: json['insertdate'],
    );
  }

  // 여기까지는 가져오는 애들
  // Post를 쓰기 때문에 아래가 필요
  Map<String, dynamic> toJSON(){
  return {
    'contents': contents,
    'image': image,
    'insertdate' : insertdate
    };
  }

}