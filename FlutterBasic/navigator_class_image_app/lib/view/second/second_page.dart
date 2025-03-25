import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('screen 2nd'),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/2ndimage'),
              child: Text('SecondImagePage'),
            ),
          ],
        ),
      )
    );
  }
}