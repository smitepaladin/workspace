import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _HomeState();
}

class _HomeState extends State<FirstPage> {


  //Property
  late List<String> imageFiles;
  late int currentPage;
  late int nextPage;

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
  nextPage = 1;
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('무한 이미지 반복'),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(imageFiles[currentPage],
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              ),
            ),
            Stack(
              children: [
                Image.asset(
                  'images/${imageFiles[currentPage]}',
                  fit: BoxFit.fill,
                  width: 350,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    prevButton();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)
                    )
                  ),  
                  child: Text('<< 이전'),
                ),
                ElevatedButton(
                  onPressed: () {
                    nextButton(screenWidth, screenHeight);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)
                    )
                  ),  
                  child: Text('다음 >>'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }//Build


  // -- Functions -- //

  prevButton(){
    currentPage --;
    if(currentPage < 0){
      currentPage = imageFiles.length -1;
    }

    nextPage --;
    if(nextPage < 0){
      nextPage = imageFiles.length -1;
    }
    setState(() {});
  }

  nextButton(double screenWidth, double screenHeight){
    currentPage ++;
    if(currentPage >= imageFiles.length){
      currentPage = 0;
    }

    nextPage ++;
    if(nextPage >= imageFiles.length){
      nextPage = 0;
    }

  setState(() {});
  }
  


}//Class