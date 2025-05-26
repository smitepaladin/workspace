import 'package:get/get.dart';

class Calc extends GetxController{
  int num1 = 0;
  int num2 = 0;


  int addResult = 0;
  int subResult = 0;
  int mulResult = 0;
  double divResult = 0.0;

  void caculation(){
    addition();
    subtraction();
    multiplication();
    division();
    update(); // Notify와 같은 역할
  }

  void addition(){
    addResult = num1 + num2;
  }

  void subtraction(){
    subResult = num1 - num2;
  }


  void multiplication(){
    mulResult = num1 * num2;
  }


  void division(){
    if(num2 == 0){
      divResult = double.infinity;
    }else{
      divResult = num1.toDouble() / num2.toDouble();
    }
    
  }
}
