import 'package:flutter/material.dart';
import 'package:chart_tabbar_app/view/bar_chart.dart';
import 'package:chart_tabbar_app/view/line_chart.dart';
import 'package:chart_tabbar_app/view/scatter_chart.dart';
import 'package:chart_tabbar_app/view/pie_chart.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  // SingleTickerProviderStateMix 가 옵저버 역할을 해서 Home을 띄운다.

  //Property
  late TabController controller;


  @override // override는 State<Home>에게 상속받은것으로 위치에 상관이 없다.
  void initState() {
    super.initState();
    controller = TabController(length: 4, vsync: this); // 탭갯수, 어디에 연결시킬것인가
  }

  @override
  void dispose() {
    controller.dispose(); // 앱이 종료될 때 메모리에 있는 컨트롤러도 죽여라. super.dispose();보다 위에 있어야한다.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: controller,
        children: [
          BarChart(),
          LineChart(),
          ScatterChart(),
          PieChart(),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.amber,
        height: 80,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TabBar(
            controller: controller,
            labelColor: Colors.blue, // 선택할 때 색깔
            indicatorColor: Colors.red, // 아래 인디케이터 색깔
            indicatorWeight: 5, // 인디케이터 두께
            tabs: [
              Tab(
                text: "Bar",
              ),
              Tab(
                text: "Line",
              ),
              Tab(
                text: "Scatter",
              ),
              Tab(
                text: "Pie",
              ),
            ],
          ),
        ),
      ),
    );
  }
}