import 'package:flutter/material.dart';
import 'package:snackbar_app/snackbar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    //build는 랜더링하는것 - 초당 60번움직이면서 띄워줌, context는 스캐폴드의 내용을 메모리로 넣어준다.
    return Scaffold(
      // 디자인쪽은 리턴이 다 스캐폴드다.
      appBar: AppBar(
        title: Text('Snack Bar'),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      body: MySnackBar(),
    );
  } // build
} // class
