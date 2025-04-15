import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailFlower extends StatefulWidget {
  const DetailFlower({super.key});

  @override
  State<DetailFlower> createState() => _DetailFlowerState();
}

class _DetailFlowerState extends State<DetailFlower> {

  //Property

  late String imageName;

  @override
  void initState() {
    super.initState();
    imageName = Get.arguments ?? "__";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(imageName.substring(7)),
      ),
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            imageName,
            width: 300,
          ),
        ),
      ),
    );
  }
}