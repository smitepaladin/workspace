import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property(즉 state)
  late String _lampImage;        // Image File Name
  late double _lampWidth;        // Image Width
  late double _lampHeight;       // Image Height
  late String _buttonName;       // Button title
  late bool _switch;             // Switch on, off
  late bool _lampSizeStatus;     // 현재 화면의 Lamp의 크기
  late double _rotation;         // 회전 각도

@override
  void initState() {
    super.initState();
    _lampImage = 'images/lamp_on.png';
    _lampWidth = 150;
    _lampHeight = 300;
    _buttonName = 'Iamge 확대';
    _switch = true;
    _lampSizeStatus = false;
    _rotation = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'image확대 및 축소'
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              height: 550,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RotationTransition(
                    turns: AlwaysStoppedAnimation(_rotation / 360),
                    child: Image.asset( // sizedbox를 혼자 차지하고 있기 때문에 크기가 안 변한다. Collum으로 한번 더 감싸서 종속성을 풀어준다.
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
                    decisionLampSize();
                  },
                  child: Text(_buttonName),
                ),
                Column(
                  children: [
                    Text(
                      '전구 스위치',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                    Switch(
                      value: _switch,
                      onChanged: (value) {
                        _switch = value;
                        decisionOnOff();
                      },
                    ),
                  ],
                )
              ],
            ),
            SizedBox( // 슬라이더 크기 조절을 위해 만든 sizedbox
              width: 200,
              child: Slider(
                min: 0,
                max: 360,
                value: _rotation,
                onChanged: (value) {
                  _rotation = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ),
    );
  }//build


  // -- functions --

  decisionLampSize(){
    if(_lampSizeStatus == true){
      _lampWidth= 150;
      _lampHeight= 300;
      _buttonName = "Image 확대";
      _lampSizeStatus = false;
    }else{
      _lampWidth = 250;
      _lampHeight= 500;
      _buttonName = 'Image 축소';
      _lampSizeStatus = true;
    }
    setState(() {});
  }

  decisionOnOff(){
    _lampImage = _switch ? 'images/lamp_on.png' : 'images/lamp_off.png';
    setState(() {});
  }

}//Class