import 'package:flutter/material.dart';
import 'package:tabbar_image_ex_app/first_page.dart';
import 'package:tabbar_image_ex_app/second_page.dart';
import 'package:tabbar_image_ex_app/third_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  // SingleTickerProviderStateMix 가 옵저버 역할을 해서 Home을 띄운다.

  //Property
  late TabController controller;


  @override // override는 State<Home>에게 상속받은것으로 위치에 상관이 없다.
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this); // 탭갯수, 어디에 연결시킬것인가
  }

  @override
  void dispose() {
    controller.dispose(); // 앱이 종료될 때 메모리에 있는 컨트롤러도 죽여라. super.dispose();보다 위에 있어야한다.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("이미지 변경하기"),
        backgroundColor: Colors.amber,
      ),
      body: TabBarView(
        controller: controller,
        children: [
          FirstPage(),
          SecondPage(),
          ThirdPage(),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        height: 70,
        child: TabBar(
          controller: controller,
          labelColor: Colors.blue, // 선택할 때 색깔
          tabs: [
            Tab(
              icon: Icon(
                Icons.card_giftcard,
              ),
              text: "Button",
            ),
            Tab(
              icon: Icon(
                Icons.print,
              ),
              text: "Swipe",
            ),
            Tab(
              icon: Icon(
                Icons.punch_clock,
              ),
              text: "Timer",
            ),
          ],
        ),
      ),
    );
  }
}