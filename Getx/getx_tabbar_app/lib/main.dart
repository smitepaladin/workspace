import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_tabbar_app/view/home.dart';
import 'package:getx_tabbar_app/vm/tab_model.dart';

void main() {
  Get.put(TabModel());
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
