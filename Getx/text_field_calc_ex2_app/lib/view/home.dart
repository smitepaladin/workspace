import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text_field_calc_ex2_app/vm/calc.dart';

class Home extends StatelessWidget {
  Home({super.key}); // const제거, main에서도 제거

  final num1Controller = TextEditingController();
  final num2Controller = TextEditingController();

  final Calc calc = Get.find<Calc>(); // 컨트롤러 주입 받기

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text('간단한 계산기 using Rx')),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: num1Controller,
                    decoration: InputDecoration(labelText: "첫번째 숫자를 입력하세요"),
                    keyboardType: TextInputType.number,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: num2Controller,
                    decoration: InputDecoration(labelText: "두번째 숫자를 입력하세요"),
                    keyboardType: TextInputType.number,
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _calculate,
                      child: Text("계산하기"),
                    ),
                    ElevatedButton(
                      onPressed: _reset,
                      child: Text('지우기'),
                    ),
                  ],
                ),

                buildResultTextField("덧셈결과", calc.addResult),
                buildResultTextField("뺄셈결과", calc.subResult),
                buildResultTextField("곱셈결과", calc.mulResult),
                buildResultTextField("나눗셈결과", calc.divResult, isDouble: true),
              ],
            ),
          ),
        ),
      ),
    );
  } //build

  // Widget //

  Widget buildResultTextField(String label, Rx value, {bool isDouble = false}) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: TextEditingController(
            text: isDouble
            ? (value.value as double).toStringAsFixed(3)
            : value.value.toString(),
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: label,
          ),
          readOnly: true,
        ),
      ),
    );
  }

  // functions //

  void _calculate() {
    final num1Text = num1Controller.text.trim();
    final num2Text = num2Controller.text.trim();

    if (num1Text.isEmpty || num2Text.isEmpty) {
      errorSnackBar();
      return;
    }

    calc.num1.value = int.tryParse(num1Text) ?? 0; // 파싱해서 int가 아니면 0으로 바꾼다.
    calc.num2.value = int.tryParse(num2Text) ?? 0; // 파싱해서 int가 아니면 0으로 바꾼다.
    calc.calculation();
  }

  void _reset() {
    num1Controller.clear();
    num2Controller.clear();
    calc.reset();
  }

  void errorSnackBar() {
    Get.snackbar(
      "Error",
      "숫자를 입력하세요",
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}//class