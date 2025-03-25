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
    buttonState = "Hello";
    buttonColor = Colors.blue;
    buttonTextColor = Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change button color & text'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _onClick(),
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                foregroundColor: buttonTextColor
              ),
              child: Text(buttonState),
            ),
          ],
        ),
      )
    );
  }  // build

  // ---- function ----
  _onClick(){
    (buttonState == "Hello")
      ?(
        buttonState = "Flutter",
        buttonColor = Colors.amber,
        buttonTextColor = Colors.white,
      )
      : (
        buttonState = "Hello",
        buttonColor = Colors.blue,
        buttonTextColor = Colors.white
      );


    setState(() {}); // build는 변수가 바뀐것을 알지 못하니 property의 값을 알려줘야한다.
  }



} // Class