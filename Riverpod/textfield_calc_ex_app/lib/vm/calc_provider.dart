import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:textfield_calc_ex_app/model/calc_state.dart';

/*
  CalcNotifier : 상태를 변경하는 로직을 담당하는 클래스
*/

class CalcNotifier extends StateNotifier<CalcState>{

  CalcNotifier() : super(CalcState()); // 초기값

  void calculate(int n1, int n2){
    //  상태의 일부만 변경하고 UI에 전달 state는 StateNotifier가 가지고 있는 변수
    state = state.copywith(
      num1: n1,
      num2: n2,
      addResult: n1 + n2,
      subResult: n1 - n2,
      mulResult: n1 * n2,
      divResult: n2 != 0 ? n1 / n2 : 0.0
    );
  }


  void clear(){
    state = CalcState(); // 초기화
  }
}


  // StateNotifierProvider : 현 클래스를 외부에서 사용 가능하게 만들어 주는 Provider 등록 방식
  // 실제 앱에서 사용할 수 있도록 CalcNotifier를 Provider로 등록한다.
  // UI에서 이 Provider를 통해 상태를 읽거나(ref.watch), 제어(ref.read) 한다.
  // state, StateNotifier, StateNotifierProvider 3단계 구성


  final calcProvider = StateNotifierProvider<CalcNotifier, CalcState>(
    (ref) => CalcNotifier(),
  );
