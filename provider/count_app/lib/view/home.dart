import 'package:count_app/vm/counter.dart';
import 'package:count_app/vm/total_click.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    //Property
    final counter = context.watch<Counter>().count; // count값이 변하면 Counter(메모리값)를 째려보다가 count를 가져와라.
    final totalClicks = context.watch<TotalClickCounter>().count; // 이것으로 메모리끼리 연결되었다.

    return Scaffold(
      appBar: AppBar(
        title: Text('Provider State'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('현재 $totalClicks번 클릭하였습니다. \n'),
            Text('현 카운트의 결과 값은 $counter 입니다')
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: () {
                context.read<Counter>().increment(); // read는 함수 실행
                context.read<TotalClickCounter>().clickCount();
              },
              backgroundColor: Colors.blue,
              child: Icon(Icons.add),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: () {
                context.read<Counter>().decrement(); // read는 함수 실행
                context.read<TotalClickCounter>().clickCount();
              },
              backgroundColor: Colors.red,
              child: Icon(Icons.remove),
            ),
          ),
        ],
      ),
    );
  }
}