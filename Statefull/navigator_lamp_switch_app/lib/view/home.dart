import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:navigator_lamp_switch_app/model/messege.dart';
import 'package:navigator_lamp_switch_app/view/controller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property
  late String lampImage;



  @override
  void initState() {
    super.initState();
    lampImage = "images/lamp_on.png";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main 화면'),
        actions: [
          IconButton(
            onPressed: () {

              Get.to(Controller())!.then((Value) => getData());
            // !는 절대 null값이 아니라는 표시
            // then은 앞의 Future가 실행된 이후 나중에 실행될 것을 예약하는 문법
            // 그래서 Controller에서 작업이 끝난 후 value를 받아와 getData에 전해주는 모양새가 된다.



              // Messege.lampStatus = true; // 눌렀을 때 램프 초기값 가지고 간다.
              // Messege.lampColor = true;
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => Controller(),
              //   ),
              // ).then((value) => getData());
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              lampImage,
              width: 150,
            ),
          ],
        ),
      ),
    );
  }//build

  // ==functions== //

getData(){
  if(Messege.lampStatus){
    if(Messege.lampColor){
      lampImage = 'images/lamp_on.png';
    }else{
      lampImage = 'images/lamp_red.png';
    }
    
    }else{
    lampImage = 'images/lamp_off.png';
  }
  setState(() {});
}

}//Class