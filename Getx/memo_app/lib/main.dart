import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memo_app/firebase_options.dart';
import 'package:memo_app/view/home.dart';
import 'package:memo_app/vm/memo_model.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // firebase 로그인
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // MemoController 주입(전역 싱글톤)
  Get.put(MemoController());
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Home(),
    );
  }
}
