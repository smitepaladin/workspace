import 'package:flutter/material.dart';

class Receivedmail extends StatelessWidget {
  const Receivedmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Received Mail',
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text('유비에게서 온 메일'),
          Text("관우에게서 온 메일"),
          Text('장비에게서 온 메일'),
        ],
      )
    );
  }
}