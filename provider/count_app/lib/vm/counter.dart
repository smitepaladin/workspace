import 'package:flutter/material.dart';

class Counter with ChangeNotifier{ // 카운터가 증가한것을 알려줘야한다.
  int _count = 0; // private는 다른 클래스에서 못 본다.
  int get count => _count; // 다른클래스에서는 _count 가 아니라 count를 볼거다

  void increment(){ // return할게 없다.
    _count++;
    notifyListeners(); // 나 바뀐것을 알려준다.
  }


  void decrement(){
    _count--;
    notifyListeners();
  }
}