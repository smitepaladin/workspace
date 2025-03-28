import 'dart:async';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

    late List<String> imagesFiles;
    late int currentPage;


  @override
  void initState() {
    super.initState();
      imagesFiles = [
      'flower_01.png',
      'flower_02.png',
      'flower_03.png',
      'flower_04.png',
      'flower_05.png',
      'flower_06.png',
    ];

  currentPage = 0;

  // Timer설치
  Timer.periodic(Duration(seconds: 3), (timer){ // 3초마다 실행
    changeImage();
  },);


  } // initState

    changeImage(){
    currentPage++;
    if(currentPage >= imagesFiles.length){
      currentPage = 0;
    }
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
        return Scaffold(
      appBar: AppBar(
        title: Text('3초마다 이미지 무한 반복'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              imagesFiles[currentPage],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
            ),


            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'images/${imagesFiles[currentPage]}'
                ),
              ),
            )
          ],
        ),
      ),
    );
  }//Build




}//Class