import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_crud_app/view/query_student.dart';
import 'package:getx_crud_app/vm/vm_handler.dart';

void main() {
  Get.put(VmHandler());
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
      home: const QueryStudent(),
    );
  }
}
