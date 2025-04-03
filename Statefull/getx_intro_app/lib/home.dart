import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_intro_app/second_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GetX'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Navigation'),
            ElevatedButton(
              onPressed: () => Get.to(SecondPage()),
              child: Text('Get.to():화면이동'),
            ),
            ElevatedButton(
              onPressed: () => Get.toNamed('/third'),
              child: Text('Get.toNamed():화면이동'),
            ),
            Divider(
              thickness: 0.5,
              color: Colors.black,
            ),
            Text('Snack Bar'),
            ElevatedButton(
              onPressed: () => buttonSnack(),
              child: Text('SnackBar보이기'),
            ),
            Divider(
              thickness: 0.5,
              color: Colors.black,
            ),
            Text('Dialog'),
            ElevatedButton(
              onPressed: () => buttonDialog(),
              child: Text('Dialog보이기'),
            ),
            Divider(
              thickness: 0.5,
              color: Colors.black,
            ),
            Text('Bottom sheet'),
            ElevatedButton(
              onPressed: () => buttonBottomSheet(),
              child: Text('Bottom Sheet보이기'),
            ),
            Divider(
              thickness: 0.5,
              color: Colors.black,
            ),
            Text('Screen Transition'),
            ElevatedButton(
              onPressed: () {
                Get.to(
                  SecondPage(),
                  transition: Transition.fade,
                  duration: Duration(seconds: 3)
                );
              },
              child: Text('Get.to(): Transition'),
            ),
            ElevatedButton(
              onPressed: () => Get.toNamed('/third2'),
              child: Text('Get.toName(): Transition'),
            ),
            Divider(
              thickness: 0.5,
              color: Colors.black,
            ),
            Text('Navigation & Arguments'),
            ElevatedButton( // 클래스간 데이터 이동
              onPressed: () => Get.to(
                SecondPage(),
                arguments: 'First'
              ),
              child: Text('Get.to(): Single Arguments'),
            ),
            ElevatedButton( // 클래스간 데이터 이동
              onPressed: () => Get.to(
                SecondPage(),
                arguments: ['First','Second'],
              ),
              child: Text('Get.to(): Multiple Arguments'),
            ),
            ElevatedButton( // 클래스간 데이터 받아오기
              onPressed: () async{ // secondpage가 끝날때까지 기다리고 있어라. await를 쓰기위해 async사용
                var returnValue = await Get.to(SecondPage());
                Get.snackbar(
                  "Return Value",
                  returnValue,
                );
              },
              child: Text('Get.to(): Return Argument'),
            ),
          ],
        ),
      ),
    );
  }//build

  // --Functions-- //

  buttonSnack(){
    Get.snackbar(
      'Snack Bar', // 변수도 넣을 수 있다
      'Message',
      snackPosition: SnackPosition.TOP, // BOTTOM
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red,
      colorText: Colors.white
    );
  }



  buttonDialog(){
    Get.defaultDialog(
      title: 'Dialog',
      middleText: 'Message',
      backgroundColor: Colors.amberAccent,
      barrierDismissible: false,
      actions: [
        TextButton(
          onPressed: Get.back,
          child: Text('Exit'),
        )
      ]
    );
  }


  buttonBottomSheet(){
    Get.bottomSheet(
      Container(
        width: 500,
        height: 300,
        color: Colors.purple[50],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Text Line1'),
            Text('Text Line2')
          ],
        ),
      )
    );
  }


}//Class