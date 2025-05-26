import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textfield_calc_ex_app/vm/calc.dart';

class Home extends StatelessWidget {
  Home({super.key}); // const제거, main에서도 제거

  final num1Controller = TextEditingController();
  final num2Controller = TextEditingController();
  final addController = TextEditingController();
  final subController = TextEditingController();
  final mulController = TextEditingController();
  final divController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text('간단한 계산기')),
        body: GetBuilder<Calc>(
          builder: (calc) {
            return SingleChildScrollView(
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
                          onPressed: () => calcAction(), 
                          child: Text("계산하기"),
                        ),
                        ElevatedButton(
                          onPressed: () => removeAction(),
                          child: Text('지우기'),
                        ),
                      ],
                    ),
              
                    buildResultTextField("덧셈결과", addController),
                    buildResultTextField("뺄셈결과", subController),
                    buildResultTextField("곱셈결과", mulController),
                    buildResultTextField("나눗셈결과", divController),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  } //build

  // Widget //

  Widget buildResultTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
        ),
        readOnly: true,
      ),
    );
  }

  // functions //

  void calcAction() {
    final calc = Get.find<Calc>();
    final num1Text = num1Controller.text.trim();
    final num2Text = num2Controller.text.trim();

    if (num1Text.isEmpty || num2Text.isEmpty) {
      errorSnackBar();
      return;
    }

    calc.num1 = int.tryParse(num1Text) ?? 0; // 파싱해서 int가 아니면 0으로 바꾼다.
    calc.num2 = int.tryParse(num2Text) ?? 0; // 파싱해서 int가 아니면 0으로 바꾼다.
    calc.caculation();
    addController.text = calc.addResult.toString();
    subController.text = calc.subResult.toString();
    mulController.text = calc.mulResult.toString();
    divController.text = calc.divResult.toStringAsFixed(3);
  }

  void removeAction() {
    num1Controller.clear();
    num2Controller.clear();
    addController.clear();
    subController.clear();
    mulController.clear();
    divController.clear();
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