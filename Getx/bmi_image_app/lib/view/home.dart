import 'package:bmi_image_app/vm/calc_bmi_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final heightController = TextEditingController();
  final weightController = TextEditingController();

  final CalcBmi calcBmi = Get.find<CalcBmi>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('BMI 계산기')),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: heightController,
              decoration: InputDecoration(labelText: "신장을 입력하세요(cm)"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: weightController,
              decoration: InputDecoration(labelText: "몸무게를 입력하세요(kg)"),
              keyboardType: TextInputType.number,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _calculate(),
                  child: Text('BMI 계산'),
                ),
                // ElevatedButton(
                //   onPressed: () => removeAction(context),
                //   child: Text('지우기')
                // ),
              ],
            ),
            Obx(
              () => Column(
                children: [
                  Text(
                    calcBmi.result.value,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Image.asset(calcBmi.bmiImage.value),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  } //builc
  //--function--

  void _calculate() {
    final heightText = heightController.text.trim();
    final weightText = weightController.text.trim();

    if (heightText.isEmpty || weightText.isEmpty) {
      _errSnackBar();
      return;
    } else {
      calcBmi.height.value = double.tryParse(heightText) ?? 0;
      calcBmi.weight.value = double.tryParse(weightText) ?? 0;
      calcBmi.calcutlateBMI();
    }
  }

  void _errSnackBar() {
    Get.snackbar(
      'Error',
      '숫자를 입력하세요',
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}//class