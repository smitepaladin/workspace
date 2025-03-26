import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property
  late String buttonText;
  late Color buttonBackColor;
  late bool buttonCheck; // Hello:true, Flutter:false 로 정하자
  late Color bodyColor; // 화면 전체 색깔 정의
  late int clickCount; // 버튼 누른 횟수


  @override
  void initState() {
    super.initState();
    buttonText = "Hello";
    buttonCheck = true;
    buttonBackColor = Colors.blue;
    bodyColor = Colors.white;
    clickCount = 10;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bodyColor,
      appBar: AppBar(
        title: Text("Chages button color & Text"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            onClick();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonBackColor,
          ),
          child: Text(
            buttonText,
          ),
        ),
        
      ),
    );
  } // build


  // -- Functon --
  onClick(){
    print("현재 상태 : $buttonText, $buttonCheck, $clickCount");
    clickCount++;
    if(clickCount%20 == 0){
        clickCount = 0;
        bodyColor = Colors.amber;
      }else if(clickCount%10 == 0){
        bodyColor = Colors.white;
      }

      (buttonCheck == true)
      ?(
      buttonText = "Flutter",
      buttonCheck = false,
      buttonBackColor = Colors.amber
      )
    : (
      buttonText = "Hello",
      buttonCheck = true,
      buttonBackColor = Colors.blue
      );

    // if(buttonCheck == true){
    //   buttonText = "Flutter";
    //   buttonCheck = false;
    //   buttonBackColor = Colors.amber;
    // }else{
    //   buttonText = "Hello";
    //   buttonCheck = true;   
    //   buttonBackColor = Colors.blue;
    // }

    print("바뀐 상태 : $buttonText, $buttonCheck, $clickCount");
    print("-------------------------------");
    setState(() {});
  }

} // Class