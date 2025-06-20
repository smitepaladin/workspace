class Bmi {
  // 전체 계산 상태를 저장하는 모델
  final double height;
  final double weight;
  final double bmi;

  final String result;
  final String resultStr;
  final String bmiImage;


  Bmi(
    {
      this.height = 0.0,
      this.weight = 0.0,
      this.bmi = 0.0,
      this.result = "",
      this.resultStr = "",
      this.bmiImage = "images/bmi.png",
    }
  );

  // 특정 값만 변경된 새 상태 객체를 만들 때

  Bmi copywith({
    double? height,
    double? weight,
    double? bmi,
    String? result,
    String? resultStr,
    String? bmiImage,
  }) {
    return Bmi(
      height : height ?? this.height,
      weight : weight ?? this.weight,
      bmi : bmi ?? this.bmi,
      result : result ?? this.result,
      resultStr : resultStr ?? this.resultStr,
      bmiImage : bmiImage ?? this.bmiImage,
    );
  }

}