import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alert Dialog with Gesture'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () => _showDialog(context),
          child: Text(
            'Hello World!'
          )
        ),
        ),
    );
  } //build

  // --- Function ---
  _showDialog(BuildContext context){
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.amber,
      builder: (context){
        return AlertDialog(
          title: Text('Alert Title'),
          content: Text('Hello World를 Touch했습니다.'),
          actions: [
            Center(
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(context), // of(context) 를 통해서 바로 만든 context만 지우겠다
                child: Text('종료'),
              ),
            ),
          ],
        );
      },
    );
  }



} // Home