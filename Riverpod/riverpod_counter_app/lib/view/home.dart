import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_counter_app/vm/counter.dart';


class Home extends ConsumerWidget { // statless포함
  Home({super.key});


  // 상태 관리 Provider 정의
  // state하나가지고 Provider를 여러개 쓸 수 있다.
  final counterProvider = StateNotifierProvider((ref) => Counter()); // counterProvider는 StateNotifier를 돕는다.
  final totalClickProvider = StateNotifierProvider((ref) => Counter());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider); // provider를 통해서 watch한다.
    final totalClicks = ref.watch(totalClickProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Riverpot State'),
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
                ref.read(counterProvider.notifier).increment();
                ref.read(totalClickProvider.notifier).clickCount();
              },
              backgroundColor: Colors.blue,
              child: Icon(Icons.add),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: () {
                ref.read(counterProvider.notifier).decrement();
                ref.read(totalClickProvider.notifier).clickCount();
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