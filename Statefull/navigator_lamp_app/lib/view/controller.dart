import 'package:flutter/material.dart';
import 'package:navigator_lamp_app/model/messege.dart';

class Controller extends StatefulWidget {
  const Controller({super.key});

  @override
  State<Controller> createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {
  //Property 화면에 바뀌는게 3개니까 3개
  late TextEditingController textEditingController;
  late String switchLabel;
  late bool switchValue;


  @override
  void initState() { // 초기환경 설정
    super.initState();
    textEditingController = TextEditingController();
    textEditingController.text = Messege.contents;
    if(Messege.lampStatus){
      switchLabel = 'On';
      switchValue = true;
    }else{
      switchLabel = 'Off';
      switchValue = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('수정화면'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: textEditingController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(switchLabel),
                Switch(
                  value: switchValue,
                  onChanged: (value) {
                    switchValue = value;
                    if(switchValue){
                      switchLabel = 'On';
                    }else{
                      switchLabel = 'Off';
                    }
                    setState(() {});
                  },
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Messege.contents = textEditingController.text;
                Messege.lampStatus = switchValue;
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}