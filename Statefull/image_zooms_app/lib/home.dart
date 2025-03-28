import 'package:flutter/material.dart';
import 'dart:async';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Property
  late String _lampImage; // Image File Name
  late double _lampWidth; // Image Width
  late double _lampHeight; // Image Height
  late String _buttonName; // Button title
  late bool _switch; // switch의 켜짐 상태
  late bool _lampSizeStatue; // 현재 화면의 Lamp 크기 (false: 작은전구)
  late int radian;

  @override
  void initState() {
    super.initState();
    _lampImage = "images/lamp_on.png";
    _lampWidth = 150;
    _lampHeight = 300;
    _buttonName = "Image 확대";
    _switch = true;
    _lampSizeStatue = false;
    radian = 0;


    Timer.periodic(Duration(seconds: 1), (timer){
      changeRadian();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image 확대 및 축소'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 330,
              height: 630,
              child: Column(
                children: [
                  RotationTransition(
                    turns: AlwaysStoppedAnimation(radian*36/360),
                    child: Image.asset(
                      _lampImage,
                      width: _lampWidth,
                      height: _lampHeight,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    dicisionLampSize();
                  },
                  child: Text(_buttonName),
                ),
                Column(
                  children: [
                    Text(
                      '전구 스위치',
                      style: TextStyle(
                        fontSize: 9,
                      ),
                    ),
                    Switch(
                      value: _switch,
                      onChanged: (value){
                        _switch = value;
                        decisionOnOff();
                      })
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }//build


  decisionOnOff(){
    if(_switch == true){
      _lampImage = "images/lamp_on.png";
    }else{
      _lampImage ="images/lamp_off.png";
    }
    setState(() {});
  }


  dicisionLampSize(){
    if(_lampSizeStatue == true){
      _lampWidth = 150;
      _lampHeight = 300;
      _buttonName = 'Image 확대';
      _lampSizeStatue = false;
    }else{
      _lampWidth = 300;
      _lampHeight = 600;
      _buttonName = 'Image 축소';
      _lampSizeStatue = true;
    }
    setState(() {});


  }


  // changeRadian(){
  //   if(_lampSizeStatue == true){
  //     radian--;
  //   }else{
  //     radian++;
  //   }
    
  //   setState(() {});
  // }
  changeRadian(){
    (_lampSizeStatue == true)
    ?(radian--)
    :(radian++);
    
    
    setState(() {});
  }
}//Class