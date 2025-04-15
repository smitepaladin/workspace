main(){
  late List<String> imageList;
  imageList = [
    'images/flower_01.png',
    'images/flower_02.png',
    'images/flower_03.png',
    'images/flower_04.png',
    'images/flower_05.png',
  ];
  print(imageList[0]);
  print(imageList[0][0]);
  print(imageList[0].substring(7));
}