import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late bool onOff;
  late bool zoom;
  late String msg;
  late String fileName;
  late double size;

  @override
  void initState() {
    super.initState();
  onOff = true;
  zoom = true;
  msg = "Image 축소";
  fileName = "lamp_on.png";
  size = 500;
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image 확대 및 축소'),
      ),
      body: Column(
        children: [
          Image.asset(
            'images/${fileName}',
            height: size,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  imageZoom();
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.red,
                ),
                child: Text(msg),
              ),
              Switch(
                value: onOff,
                onChanged: (value) {
                onOff = value; // 지정변수를 입력값과 동일하게 해줌
                  switchOnOff();
                }
              ),
            ],
          ),
        ],
      ),
    );
  }//Build

  // --Function -- //

  imageZoom(){
    if(size == 400){
      size = 500;
      msg = "Image 축소";
    }else{
      size = 400;
      msg = "Image 확대";
    }
    setState(() {});
  }

  switchOnOff(){
    if(onOff == true){
      fileName = "lamp_on.png";
    }else{
      fileName = "lamp_off.png";
    }
    setState(() {});
  }


}//Class