import 'package:flutter/widgets.dart';

class TotalClickCounter with ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void clickCount(){
    _count++;
    notifyListeners();
  }
}