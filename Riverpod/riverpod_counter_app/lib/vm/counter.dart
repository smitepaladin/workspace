import 'package:flutter_riverpod/flutter_riverpod.dart';

class Counter extends StateNotifier{ // StateNotifier가 0값을 가지게 한다.
  Counter() : super(0); // 초기값으로 0으로 생성

  void increment(){ // return할게 없다.
    state++;
  }


  void decrement(){
    state--;
  }

  void clickCount(){
    state++;
  }
}