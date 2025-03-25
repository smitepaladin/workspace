import 'package:flutter/material.dart';

class Sendmail extends StatelessWidget {
  const Sendmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Send Mail',
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text('유비에게 보낸 메일'),
          Text("관우에게 보낸 메일"),
          Text('장비에게 보낸 메일'),
        ],
      )
    );
  }
}