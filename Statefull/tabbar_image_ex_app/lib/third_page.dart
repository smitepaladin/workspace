import 'dart:async';
import 'package:flutter/material.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _HomeState();
}

class _HomeState extends State<ThirdPage> {

    late List<String> imagesNames;
    late int currentPage;
    late Timer timer;


  @override
  void initState() {
    super.initState();
      imagesNames = [
      'flower_01.png',
      'flower_02.png',
      'flower_03.png',
      'flower_04.png',
      'flower_05.png',
      'flower_06.png',
    ];

  currentPage = 0;

  // Timer설치
  timer = Timer.periodic(Duration(seconds: 3), (timer){ // 3초마다 실행
    changeImage();
  },);


  } // initState

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

    changeImage(){
    currentPage++;
    if(currentPage >= imagesNames.length){
      currentPage = 0;
    }
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
        return Scaffold(
      // appBar: AppBar(
      //   title: Text('3초마다 이미지 무한 반복'),
      // ),
      body: Center(
        child: Column(
          children: [
            Text(
              imagesNames[currentPage],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14
              ),
            ),


            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'images/${imagesNames[currentPage]}'
                ),
              ),
            )
          ],
        ),
      ),
    );
  }//Build




}//Class