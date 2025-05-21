import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_crud_app/home.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{// Hive는 메인에서 데이터베이스를 열어놓고 간다.
WidgetsFlutterBinding.ensureInitialized(); // 스마트폰 디렉토리 접근 인증키를 준다.
await Hive.initFlutter();
await Hive.openBox('shopping_box'); // 테이블이름
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
      home: const Home(),
    );
  }
}
