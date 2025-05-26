import 'package:get/get.dart';

class Calc extends GetxController{
  var num1 = 0.obs; // 관찰대상이다.
  var num2 = 0.obs;

  var addResult = 0.obs;
  var subResult = 0.obs;
  var mulResult = 0.obs;
  var divResult = 0.0.obs;


  void calculation(){
    addResult.value = num1.value + num2.value; // value로 줘야 원래 타입으로 돌아온다.
    subResult.value = num1.value - num2.value;
    mulResult.value = num1.value * num2.value;
    divResult.value = num2.value == 0 ? double.infinity : num1.value / num2.value;
  }

  void reset(){
    num1.value = 0;
    num2.value = 0;
    addResult.value = 0;
    subResult.value = 0;
    mulResult.value = 0;
    divResult.value = 0.0;
  }
}