import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_must_eat_place_app/view/query_place.dart';
import 'package:getx_must_eat_place_app/vm/vm_handler_temp.dart';

void main() {
  Get.put(VmHandlerTemp());
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
      home: QueryPlace(),
    );
  }
}