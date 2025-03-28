import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property
  late List<String> imageFiles;
  late int currentPage;


  @override
  void initState() {
    super.initState();
    imageFiles = [
      'flower_01.png',
      'flower_02.png',
      'flower_03.png',
      'flower_04.png',
      'flower_05.png',
      'flower_06.png',
    ];

  currentPage = 0;
  }





  @override
  Widget build(BuildContext context) {

    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'images/${imageFiles[currentPage]}',
            fit: BoxFit.fill,
            height: screenHeight,
            width: screenWidth,
          ),
          Positioned(
            left: 10,
            top: screenHeight/2,
            child: ElevatedButton(
              onPressed: () {
                prevButton();
              },
              child: Text('<<')
              ),
          ),
          Positioned(
            right: 10,
            top: screenHeight/2,
            child: ElevatedButton(
              onPressed: () {
                nextButton();
              },
              child: Text('>>')
              ),
          ),
        ],
      ),
    );
  }//build


  // -- Functions --///
  // SwipeDirection은 타입, direction은 사용자가 입력한 값



  prevButton(){
    currentPage --;
    if(currentPage < 0){
      currentPage = imageFiles.length -1;
    }

    setState(() {});
  }

  nextButton(){
    currentPage ++;
    if(currentPage >= imageFiles.length){
      currentPage = 0;
    }


  setState(() {});
  }
  

  
    



}//Class