import 'package:chart_tabbar_app/model/developer_data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChart extends StatefulWidget {
  const PieChart({super.key});

  @override
  State<PieChart> createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> {
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
        title: Text('Pie Chart'),
      ),
      body: Center(
        child: SizedBox( // 차트 크기를 맞추기 위해 SfCircularChart에 사이즈드 박스를 준다.
          width: 380,
          height: 600,
          child: SfCircularChart( 
            title: ChartTitle(text: 'Yearly Growth in the Flutter Community'),
            tooltipBehavior: tooltipBehavior, // 툴팁 정의하기
            legend: Legend(isVisible: true), // name값을 따라간다.
            series: <CircularSeries<DeveloperData, int>>[ // CircularSeries에 타입을 줘야한다. DevelperData와 int
              PieSeries<DeveloperData, int>(
                name: 'Developers',
                dataSource: data,
                xValueMapper: (DeveloperData years, _) => years.year,
                yValueMapper: (DeveloperData developers, _) => developers.developers,
                dataLabelSettings: DataLabelSettings(isVisible: true),
                enableTooltip: true,
              )
            ],

          ),
        ),
      ),
    );
  }
}