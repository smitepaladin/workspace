import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  // Property
  late String userId; // 화면에서 변하지는 않지만 외부에서 받는거라 생성
  late String password;

  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    userId = "";
    password = "";
    initStorage();
  }

  initStorage(){
    userId = box.read('p_userId');
    password = box.read('p_password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ID와 Password 출력'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('User ID : $userId'),
            Text('Password : $password'),
          ],
        ),
      ),
    );
  }
}