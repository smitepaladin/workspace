import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailHero extends StatefulWidget {
  const DetailHero({super.key});

  @override
  State<DetailHero> createState() => _DetailHeroState();
}

class _DetailHeroState extends State<DetailHero> {
  // Property

  late String heroName;

  @override
  void initState() {
    super.initState();
    heroName = Get.arguments ?? "__"; // null값이 오면 __로 받는다.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('인물보기'),
      ),
      body: Center(
        child: Text(
          heroName,
        ),
      ),
    );
  }
}