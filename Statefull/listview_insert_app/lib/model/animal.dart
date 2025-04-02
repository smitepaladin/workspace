class Animal {
  // Property

  String imagePath; // 이미지파일 주소와 파일명
  String animalName; // 동물이름
  String order; // 종
  bool flyAble; // 날수있는가 여부



  // Constructer
  Animal(
    {
      required this.imagePath,
      required this.animalName,
      required this.order,
      required this.flyAble,
    }

  );
  
}