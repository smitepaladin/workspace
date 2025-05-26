import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_json_movie_github_app/view/home.dart';
import 'package:getx_json_movie_github_app/vm/vm_handler.dart';

void main() {
  Get.put(VmHandler());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Home(),
    );
  }
}
