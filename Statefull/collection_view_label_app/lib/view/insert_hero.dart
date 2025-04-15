import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InsertHero extends StatefulWidget {
  const InsertHero({super.key});

  @override
  State<InsertHero> createState() => _InsertHeroState();
}

class _InsertHeroState extends State<InsertHero> {

  //Property

  late TextEditingController textEditingController;


  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('인물 추가'),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                labelText: '인물을 추가 하세요',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                String resultMessage = '';
                if(textEditingController.text.trim().isNotEmpty){
                  resultMessage = textEditingController.text.trim();
                }
                Get.back(result: resultMessage); // result에 리스트, 펑션 다 넘겨줄 수 있다.
              },
              child: Text('추가'),
            )
          ],
        ),
      ),
    );
  }
}