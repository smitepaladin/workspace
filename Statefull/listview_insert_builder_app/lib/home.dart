import 'package:flutter/material.dart';
import 'package:listview_insert_builder_app/view/first_tab.dart';
import 'package:listview_insert_builder_app/view/second_tab.dart';
import 'package:listview_insert_builder_app/model/animal.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  //Property
  late TabController controller;
  late List<Animal> animal; // 제너릭은 모델인 Animal
  late List<Color> animalColor;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
    animal = [];
    addData();
    animalColor = [
      Colors.yellow,
      Colors.yellow,
      Colors.yellow,
      Colors.yellow,
      Colors.yellow,
      Colors.yellow,
      Colors.yellow,
      Colors.yellow,
      Colors.yellow,
    ];
  }

  addData() {
    animal.add(
      Animal(
        imagePath: 'images/bee.png',
        animalName: '벌',
        order: '파충류',
        flyAble: true,
      ),
    );
    animal.add(
      Animal(
        imagePath: 'images/cat.png',
        animalName: '고양이',
        order: '포유류',
        flyAble: false,
      ),
    );
    animal.add(
      Animal(
        imagePath: 'images/cow.png',
        animalName: '젖소',
        order: '포유류',
        flyAble: false,
      ),
    );
    animal.add(
      Animal(
        imagePath: 'images/dog.png',
        animalName: '강아지',
        order: '포유류',
        flyAble: false,
      ),
    );
    animal.add(
      Animal(
        imagePath: 'images/fox.png',
        animalName: '여우',
        order: '포유류',
        flyAble: false,
      ),
    );
    animal.add(
      Animal(
        imagePath: 'images/monkey.png',
        animalName: '원숭이',
        order: '영장류',
        flyAble: false,
      ),
    );
    animal.add(
      Animal(
        imagePath: 'images/pig.png',
        animalName: '돼지',
        order: '포유류',
        flyAble: false,
      ),
    );
    animal.add(
      Animal(
        imagePath: 'images/wolf.png',
        animalName: '늑대',
        order: '포유류',
        flyAble: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listview Test'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: controller,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.red,
          tabs: [
            Tab(icon: Icon(Icons.looks_one)),
            Tab(icon: Icon(Icons.looks_two)),
          ],
        ),
      ),

      body: TabBarView(
        controller: controller,
        children: [
          FirstTab(list: animal), //first_tab과 연결
          SecondTab(
            list: animal,
            borderColor: animalColor,
          ), // second_tab과 연결, list와 borderColor는 매개변수이다.
        ],
      ),
      // bottomNavigationBar: Container(
      //   color: Colors.amber,
      //   child:
      // ),
    );
  }
}
