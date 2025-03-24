import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toast Messsage'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Fluttertoast.showToast( // .찍고 액션을 줬다 = 팩토리 생성자
              msg: 'Toast Button is clicked.',
              gravity: ToastGravity.TOP,
              fontSize: 20,
              textColor: Colors.yellow,
              toastLength: Toast.LENGTH_SHORT
            );
          },
          child: Text("Toast Button"),
        ),
      )
    );
  }
}