import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text_field_calc_ex2_app/view/home.dart';
import 'package:text_field_calc_ex2_app/vm/calc.dart';

void main() {
  Get.put(Calc()); // GetX 컨트롤러 등록
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