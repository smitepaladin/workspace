import 'package:flutter/material.dart';

class Jong extends StatelessWidget {
  const Jong({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GitHub연습 종익"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("깃허브 연습"),
            Text("깃허브 연습"),
            Text("깃허브 연습"),
            Text("깃허브 연습"),
            Text("깃허브 연습"),
            Text("깃허브 연습")
          ],
        ),
      ),
    );
  }
}