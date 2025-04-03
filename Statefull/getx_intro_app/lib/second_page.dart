import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  //Property


  var value = Get.arguments ?? "__"; // null 이 들어오면 __로 바꾼다.



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'Single Arguments: $value',
            ),
            Text(
              'Multiple Arguments #1 : ${value[0]}\n'
              'Multiple Arguments #1 : ${value[1]}'
            ),
            ElevatedButton(
              onPressed: () => Get.back(result: "Good"),
              child: Text('Reply'),
            ),
          ],
        ),
      ),
    );
  }
}