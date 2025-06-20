class CalcState {
  // 전체 계산 상태를 저장하는 모델
  final int num1;
  final int num2;
  final int addResult;
  final int subResult;
  final int mulResult;
  final double divResult;

  CalcState(
    {
      this.num1 = 0,
      this.num2 = 0,
      this.addResult = 0,
      this.subResult = 0,
      this.mulResult = 0,
      this.divResult = 0.0,
    }
  );

  // 특정 값만 변경된 새 상태 객체를 만들 때

  CalcState copywith({
    int? num1,
    int? num2,
    int? addResult,
    int? subResult,
    int? mulResult,
    double? divResult,
  }) {
    return CalcState(
      num1 : num1 ?? this.num1,
      num2 : num2 ?? this.num2,
      addResult : addResult ?? this.addResult,
      subResult : subResult ?? this.subResult,
      mulResult : mulResult ?? this.mulResult,
      divResult : divResult ?? this.divResult,
    );
  }

}