import 'package:flutter/material.dart';

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
        title: Text('무한 이미지 반복'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              imageName[currentImage],
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,                
              ),
            ),
            Image.asset(
              'images/${imageName[currentImage]}',
              width: 350,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,10,10,0),
                  child: ElevatedButton(
                    onPressed: () {
                      onBack();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)
                      )
                    ),
                    child: Text('<< 이전')
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10,10,0,0),
                  child: ElevatedButton(
                    onPressed: () {
                      onGo();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)
                      )
                    ),
                    child: Text('다음 >>')
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }//build


  // -- Functions --///
  // SwipeDirection은 타입, direction은 사용자가 입력한 값


  onGo(){
    currentImage++;
      if(currentImage >= imageName.length){
        currentImage = 0;
      }

      setState(() {});
    }

    
  

  onBack(){
      currentImage--;
      if(currentImage < 0){
        currentImage = imageName.length - 1;
      }
      setState(() {}); // 바뀐 property를 bulid에게 알려주는 역할. build는 화면을 그리는 역할.
    }

    



}//Class