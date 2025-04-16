import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property
  // late int selectedHeight;
  // late int selectedWeight;
  late List<int> selectedHeight;
  late List<int> selectedWeight;
  late String firstLine;
  late String imageName;

  @override
  void initState() {
    super.initState();
    // selectedHeight = 160;
    // selectedWeight = 60;
    selectedHeight = List.generate(101, (index) => index + 100);
    selectedWeight = List.generate(171, (index) => index + 30);
    imageName = "risk";
    firstLine = "귀하의 bmi지수는 23.4이고 과체중입니다.";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('BMI 계산기')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('신장             '), Text('몸무게')],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 200,
                  child: CupertinoPicker(
                    itemExtent: 50,
                    scrollController: FixedExtentScrollController(
                      initialItem: 60,
                    ),
                    onSelectedItemChanged: (value) {
                      selectedHeight = value + 100; // 선택된 신장
                      bmiShow();
                      setState(() {});
                    },
                    children: List.generate(
                      101,
                      (index) => Center(child: Text('${index + 100}')),
                    ),
                  ),
                ),
                SizedBox(
                  width: 100,
                  height: 200,
                  child: CupertinoPicker(
                    itemExtent: 50,
                    scrollController: FixedExtentScrollController(
                      initialItem: 30,
                    ),
                    onSelectedItemChanged: (value) {
                      selectedWeight = value + 30; // 선택된 몸무게
                      bmiShow();
                      setState(() {});
                    },
                    children: List.generate(
                      171,
                      (index) => Center(child: Text('${index + 30}')),
                    ),
                  ),
                ),
              ],
            ),
            Text(firstLine),
            Image.asset('images/$imageName.png'),
          ],
        ),
      ),
    );
  } // build

  //functions//
  bmiShow() {
    int height = selectedHeight;
    int weight = selectedWeight;
    double bmi = weight / pow(height / 100, 2);
    String cat = "";

    if (weight / pow(height / 100, 2) >= 30) {
      cat = "고도비만";
      imageName = "obese";
    } else if (weight / pow(height / 100, 2) >= 25) {
      cat = "비만";
      imageName = "overweight";
    } else if (weight / pow(height / 100, 2) >= 23) {
      cat = "과체중";
      imageName = "risk";
    } else if (weight / pow(height / 100, 2) >= 18.5) {
      cat = "정상체중";
      imageName = "normal";
    } else {
      cat = "저체중";
      imageName = "underweight";
    }

    firstLine = '귀하의 bmi 지수는 ${bmi.toStringAsFixed(1)}이고 $cat 입니다.';
    setState(() {});
  }
}//Class