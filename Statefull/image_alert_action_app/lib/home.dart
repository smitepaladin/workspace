import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Property
  late String _lampImage; // Image File Name

  @override
  void initState() {
    super.initState();
    _lampImage = "images/lamp_on.png";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Alert를 이용한 메시지 출력',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [Image.asset(_lampImage, width: 300, height: 400)],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      onSwitch();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text('켜기'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      offSwitch();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text('끄기'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  } //build

  onSwitch() {
    if (_lampImage == "images/lamp_on.png") {
      _showWarning(context);
    } else {
      _show(context);
    }

    setState(() {});
  }

  offSwitch() {
    if (_lampImage == "images/lamp_off.png") {
      _showWarning(context);
    } else {
      _show(context);
    }

    setState(() {});
  }

  // _showWarning(BuildContext context){
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (context){
  //       return AlertDialog(
  //         title: Text('경고'),
  //         content: Text('현재 램프가 ${(_lampImage == "images/lamp_on.png")?("켜진"):("꺼진")} 상태입니다.'),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.of(context).pop(), // of(context) 를 통해서 바로 만든 context만 지우겠다
  //             child: Text('네. 알겠습니다.'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  _showWarning(BuildContext context) {
    Get.defaultDialog(
      title: '경고',
      middleText:
          '현재 램프가 ${(_lampImage == "images/lamp_on.png") ? ("켜진") : ("꺼진")} 상태입니다.',
      backgroundColor: Colors.amberAccent,
      barrierDismissible: false,
      actions: [TextButton(onPressed: Get.back, child: Text('네. 알겠습니다.'))],
    );
  }

  _show(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => CupertinoActionSheet(
            title: Text(
              '램프 ${(_lampImage == "images/lamp_on.png") ? ("끄기") : ("켜기")}',
            ),
            message: Text(
              '램프를 ${(_lampImage == "images/lamp_on.png") ? ("끄") : ("켜")}시겠습니까?',
            ),
            actions: [
              CupertinoActionSheetAction(
                onPressed: () {
                  _lampImage =
                      (_lampImage == "images/lamp_on.png")
                          ? ("images/lamp_off.png")
                          : ("images/lamp_on.png");
                  setState(() {});
                  Get.back();
                },
                child: Text('예'),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  Get.back();
                },
                child: Text('아니오'),
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              // Cancle은 action밖에 있어야 한다.
              onPressed: () => Get.back(),
              child: Text('Cancle'),
            ),
          ),
    );
  }
}//Class