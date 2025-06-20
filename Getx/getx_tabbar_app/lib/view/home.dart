import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_tabbar_app/view/first_page.dart';
import 'package:getx_tabbar_app/view/second_page.dart';
import 'package:getx_tabbar_app/view/third_page.dart';
import 'package:getx_tabbar_app/vm/tab_model.dart';

class Home extends StatelessWidget {
  final TabModel controller = Get.find<TabModel>(); // 컨트롤러 주입

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GetX Tabbar Example"),
        bottom: TabBar(
          controller: controller.tabController,
          tabs: [
            Tab(icon: Icon(Icons.home), text: "홈"),
            Tab(icon: Icon(Icons.business), text: "비즈니스"),
            Tab(icon: Icon(Icons.school), text: "학교"),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: [FirstPage(), SecondPage(), ThirdPage()],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: (index) {
            controller.tabController.index = index;
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
            BottomNavigationBarItem(icon: Icon(Icons.business), label: "비즈니스"),
            BottomNavigationBarItem(icon: Icon(Icons.school), label: "학교"),
          ],
        ),
      ),
    );
  }
}
