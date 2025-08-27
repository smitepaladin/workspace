import 'package:flutter/material.dart';

class PlaceHolderPage extends StatefulWidget {
  const PlaceHolderPage({super.key});

  @override
  State<PlaceHolderPage> createState() => _PlaceHolderPageState();
}

class _PlaceHolderPageState extends State<PlaceHolderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Click the button in main view to push here.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey
            ),
            )
          ],
        ),
      )
    );
  }
}