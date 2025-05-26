import 'package:get/get.dart';

class CalcBmi extends GetxController{
  var height = 0.0.obs;
  var weight = 0.0.obs;
  var bmi = 0.0.obs;

  var result = "".obs;
  var resultStr = "".obs;
  var bmiImage = 'images/bmi.png'.obs;

  void calcutlateBMI(){
    double h = height.value / 100;
    double w = weight.value;
    double bmiValue = w / (h * h);  
    
    bmi.value = double.parse(bmiValue.toStringAsFixed(1));

    if(bmi<=18.4){
      resultStr.value ="저체중";
      bmiImage.value = 'images/underweight.png';
    }else if(bmi <= 22.9){
      resultStr.value = "정상체중";
      bmiImage.value = 'images/normal.png';
    }else if(bmi <=24.9){
      resultStr.value = "과체중";
      bmiImage.value = 'images/risk.png';
    }else if(bmi <=29.9){
      resultStr.value = "비만";
      bmiImage.value = 'images/overweight.png';
    }else{
      resultStr.value = "고도미만";
      bmiImage.value = 'images/obese.png';
    }

    result.value = "귀하의 bmi지수는 $bmi 이고\n$resultStr 입니다.";
  }

}