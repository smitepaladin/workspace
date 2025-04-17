import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class Second extends StatefulWidget {
  const Second({super.key});

  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {
  //Property

  late List detail;

  @override
  void initState() {
    super.initState();
    detail = Get.arguments ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(detail[1])),
      body: Center(
        child: PhotoView(
          backgroundDecoration: const BoxDecoration(
            color: Colors.white, // PhotoView 내부 배경색을 흰색으로 설정
          ),
          imageProvider: NetworkImage(detail[0]),
        ),
      ),
    );
  }
}
