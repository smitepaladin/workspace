import 'package:collection_view_image_app/view/detail_flower.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QueryFlower extends StatefulWidget {
  const QueryFlower({super.key});

  @override
  State<QueryFlower> createState() => _QueryFlowerState();
}

class _QueryFlowerState extends State<QueryFlower> {

  //Property

  late List<String> imageList;


  @override
  void initState() {
    super.initState();
    imageList = [
      'images/flower_01.png',
      'images/flower_02.png',
      'images/flower_03.png',
      'images/flower_04.png',
      'images/flower_05.png',
      'images/flower_06.png',


    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flower Garden'),
      ),
      body: GridView.builder(
        itemCount: imageList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10, // 한줄 당 cell끼리의 간격
          mainAxisSpacing: 10, // 한줄과 다음줄과의 간격        
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(
                DetailFlower(),
                arguments: imageList[index]
              );
            },
            child: Card(
              child: Center(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          imageList[index],
                          width: 100,
                        ),
                      ),
                      RotationTransition(
                        turns: AlwaysStoppedAnimation(310/360),
                        child: Text('All rights reserved!',
                        style: TextStyle(
                          color: Colors.white
                        ),),
                      )
                      ],
                    ),
                    Text(imageList[index].substring(7),
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}