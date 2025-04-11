import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:navigator_lamp_switch_app/model/messege.dart';

class Controller extends StatefulWidget {
  const Controller({super.key});

  @override
  State<Controller> createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {
  //Property 

  late String switchLabel;
  late String switchColorlabel;
  late bool switchValue;
  late bool swtichColor;



  @override
  void initState() { // 초기환경 설정
    super.initState();
    if(Messege.lampColor){
      swtichColor = true;
      switchColorlabel = "Yellow";
    }else{
      swtichColor = false;
      switchColorlabel = "Red";
    }

    if(Messege.lampStatus){
      switchValue = true;
      switchLabel = "On";      
    }else{
      switchValue = false;
      switchLabel = "Off";
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(switchColorlabel),
                Switch(
                  value: swtichColor,
                  onChanged: (value) {
                    swtichColor = value;
                    if(swtichColor == true){
                      switchColorlabel = 'Yellow';
                    }else{
                      switchColorlabel = 'Red';
                    }
                    setState(() {});
                    returnValue();
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(switchLabel),
                Switch(
                  value: switchValue,
                  onChanged: (value) {
                    switchValue = value;
                    if(switchValue == true){
                      switchLabel = 'ON';
                    }else{
                      switchLabel = 'OFF';
                    }
                    setState(() {});
                    returnValue();
                  },
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                returnValue();
              },
              child: Text('OK'),
            ),
          ],
        ),
      ),
    );
  }//


  returnValue(){
    Messege.lampStatus = switchValue;
    Messege.lampColor = swtichColor;
    Get.back();
  }
}//