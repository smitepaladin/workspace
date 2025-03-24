import 'package:flutter/material.dart';

class FirstImagePage extends StatelessWidget {
  const FirstImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Image Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(
                'images/pikachu-1.jpg',
                ),
              radius: 60,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text('Go to the Home'),
            ),
          ],
        ),
      )
    );
  }
}