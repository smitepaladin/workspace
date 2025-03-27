import 'package:flutter/material.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property
  late List<String> imageName;
  late int currentImage; // [currentImage]

  @override
  void initState() {
    super.initState();
    imageName = [
      'flower_01.png',
      'flower_02.png',
      'flower_03.png',
      'flower_04.png',
      'flower_05.png',
      'flower_06.png',
    ];

    currentImage = 0;
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Swiping'),
      ),
      body: SimpleGestureDetector(
        onHorizontalSwipe: (direction) => _onHorizontalSwipe(direction),
        onVerticalSwipe: (direction) => _onVerticalSwipe(direction),
        onDoubleTap: () => _onDoubleTap(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                imageName[currentImage]
              ),
              Image.asset(
                'images/${imageName[currentImage]}',
                width: 350,
              ),
            ],
          ),
        ),
      ),
    );
  }//build


  // -- Functions --///
  // SwipeDirection은 타입, direction은 사용자가 입력한 값
  _onHorizontalSwipe(SwipeDirection direction){
    if(direction == SwipeDirection.left){ //right to left
      currentImage++;
      if(currentImage >= imageName.length){
        currentImage = 0;
      }
    }else{ // left to right
      currentImage--;
      if(currentImage < 0){
        currentImage = imageName.length - 1;
      }
    }

    setState(() {});
  }

  _onVerticalSwipe(SwipeDirection direction){
    if(direction == SwipeDirection.down){ //up to down
      currentImage++;
      if(currentImage >= imageName.length){
        currentImage = 0;
      }
    }else{ // left to right
      currentImage--;
      if(currentImage < 0){
        currentImage = imageName.length - 1;
      }
    }

    setState(() {}); // 바뀐 property를 bulid에게 알려주는 역할. build는 화면을 그리는 역할.
  }

  _onDoubleTap(){
    currentImage++;
    if(currentImage >= imageName.length){
      currentImage = 0;    
    }

    setState(() {});
  }



}//Class