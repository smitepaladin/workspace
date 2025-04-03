import 'package:flutter/material.dart';
import 'package:navigator_lamp_app/model/messege.dart';
import 'package:navigator_lamp_app/view/controller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property
  late TextEditingController textEditingController;
  late String lampImage;


  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
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
              Messege.contents = textEditingController.text; // 눌렀을 때 텍스트필드 입력값을 가지고 간다.
              Messege.lampStatus = true; // 눌렀을 때 램프 초기값 가지고 간다.
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Controller(),
                ),
              ).then((value) => getData());
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                labelText: '글자를 입력 하세요'
              ),
            ),
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
  textEditingController.text = Messege.contents;
  if(Messege.lampStatus){
    lampImage = 'images/lamp_on.png';
  }else{
    lampImage = 'images/lamp_off.png';
  };
  setState(() {});
}

}//Class