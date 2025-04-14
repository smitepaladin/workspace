import 'package:chart_app/model/developer_data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ScatterChart extends StatefulWidget {
  const ScatterChart({super.key});

  @override
  State<ScatterChart> createState() => _ScatterChartState();
}

class _ScatterChartState extends State<ScatterChart> {
  // Property

  late List<DeveloperData> data; // 제네릭은 DeveloperData
  late TooltipBehavior tooltipBehavior; // 툴팁

  @override
  void initState() {
    super.initState();
    data = [];
    tooltipBehavior = TooltipBehavior(enable: true);
    addData();
  }


  addData(){ // 하나의 화면에서 움직이기 때문에 async를 쓸 필요가 없다.
    data.add(DeveloperData(year: 2017, developers: 19000));
    data.add(DeveloperData(year: 2018, developers: 40000));
    data.add(DeveloperData(year: 2019, developers: 35000));
    data.add(DeveloperData(year: 2020, developers: 37000));
    data.add(DeveloperData(year: 2021, developers: 45000));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scatter Chart'),
      ),
      body: Center(
        child: SizedBox( // 차트 크기를 맞추기 위해 SFCartesianChart에 사이즈드 박스를 준다.
          width: 380,
          height: 600,
          child: SfCartesianChart( // Barchart는 여기에 들어있다
            title: ChartTitle(text: 'Yearly Growth in the Flutter Community'),
            tooltipBehavior: tooltipBehavior, // 툴팁 정의하기
            legend: Legend(isVisible: true), // name값을 따라간다.
            series: [

              // 산포도 그래프, ColumnSeries를 ScatterSeries로 바꿨다. 처음에는 세로막대 그래프를 그리고 바꿔서 하는것이 XY구분에 좋다.
              ScatterSeries<DeveloperData, int>(
                color: Theme.of(context).colorScheme.primary,
                name: 'Developers',
                dataSource: data,
                xValueMapper: (DeveloperData years, _) => years.year, // 변수값을 잡았다. index는 안쓰니까 지워버리고 다른것으로 채웠다.
                yValueMapper: (DeveloperData developers, _) => developers.developers,
                dataLabelSettings: DataLabelSettings(isVisible: true), // 그래프에 숫자를 표시
                enableTooltip: true, // 위에서 정의 필요
              ), // 그래프 내 입력 끝
            ],
            // X축을 Category로 표현
            primaryXAxis: CategoryAxis( // 카테고리화 되면서 int가 Stirng으로 자동으로 바뀐다. 소숫점도 사라짐.
              title: AxisTitle(text: '년도'),
            ),
            // Y축을 숫자로 표현
            primaryYAxis: NumericAxis(
              title: AxisTitle(text: '인원수'),
            ),
          ),
        ),
      ),
    );
  }
}