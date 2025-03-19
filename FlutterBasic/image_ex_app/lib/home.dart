import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Padding'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/pikachu-1.jpg',
              height: 100,
            ),
            Image.asset(
              'images/pikachu-2.jpg',
              height: 100,
            ),
            Image.asset(
              'images/pikachu-3.jpg',
              height: 100,
            ),
          ],
        )
      )
    );
  }
}