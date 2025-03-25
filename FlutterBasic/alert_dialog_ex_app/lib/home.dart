import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alert and push'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: false,
      ),
      body: Center(
        child: GestureDetector(
          onTap: () => _showDialog(context),
          child: Text(
            'Move the 2nd page.'
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
      builder: (context){
        return AlertDialog(
          title: Text('Page 이동'),
          content: Text('아래의 버튼을 누르면 페이지 이동을 합니다.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // of(context) 를 통해서 바로 만든 context만 지우겠다
              child: Text('CANCEL'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/secondpage');
              },
              child: Text('Page 이동'),
            ),
          ],
        );
      },
    );
  }



} // Home