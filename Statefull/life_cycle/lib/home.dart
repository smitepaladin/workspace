import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property(Field, Attribute) 바뀌는 것을 정한다.
  late String buttonState;
  late Color buttonColor;
  late Color buttonTextColor;
  
  @override
  void initState() {
    super.initState();
    buttonState = "OFF";
    buttonColor = Colors.blue;
    buttonTextColor = Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Life cycle'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _onClick(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white
              ),
              child: Text('버튼을 누르세요'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('버튼 상태'),
                Text(buttonState)
              ],
            )
          ],
        ),
      )
    );
  }  // build

  // ---- function ----
  _onClick(){
    (buttonState == "ON")
    ?(
      buttonState = "OFF",
      buttonColor = Colors.red,
      buttonTextColor = Colors.black,
      )
      : (
        buttonState = "ON",
        buttonColor = Colors.blue,
        buttonTextColor = Colors.white,
      );

    setState(() {}); // build는 변수가 바뀐것을 알지 못하니 property의 값을 알려줘야한다.
  }



} // Class