import 'package:bmi_image_app/model/bmi.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BmiNotifier extends StateNotifier<Bmi> {
  BmiNotifier() : super(Bmi()); // 초기값

  void calcutlateBMI(double heightCm, double weightKg) {
    final height = heightCm / 100;
    final bmi = double.parse((weightKg / (height * height)).toStringAsFixed(1));

    String resultStr = '';
    String bmiImage = '';

    if (bmi <= 18.4) {
      resultStr = "저체중";
      bmiImage = 'images/underweight.png';
    } else if (bmi <= 22.9) {
      resultStr = "정상체중";
      bmiImage = 'images/normal.png';
    } else if (bmi <= 24.9) {
      resultStr = "과체중";
      bmiImage = 'images/risk.png';
    } else if (bmi <= 29.9) {
      resultStr = "비만";
      bmiImage = 'images/overweight.png';
    } else {
      resultStr = "고도비만";
      bmiImage = 'images/obese.png';
    }

    state = state.copywith(
      height: height,
      weight: weightKg,
      bmi: bmi,
      resultStr: resultStr,
      bmiImage: bmiImage,
      result: "귀하의 bmi지수는 $bmi 이고\n$resultStr 입니다.",
    );
  }
}

  final bmiProvider = StateNotifierProvider<BmiNotifier, Bmi>(
    (ref) => BmiNotifier(),
  );