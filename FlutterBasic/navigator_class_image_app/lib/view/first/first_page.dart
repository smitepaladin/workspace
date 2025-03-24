import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('screen 1st'),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/1stimage'),
              child: Text('FirstImagePage'),
            ),
          ],
        ),
      )
    );
  }
}