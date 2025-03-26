import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late int count; // 클릭수. property에는 꼭 주석 달아라

  @override
  void initState() {
    super.initState();
    count = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Count Up')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('현재 클릭수는 $count 입니다.'),
            ),
            FloatingActionButton(
              onPressed: () {
                addCount();
              },
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     addCount();
      //   },
      //   backgroundColor: Colors.red,
      //   foregroundColor: Colors.white,
      //   child: Icon(Icons.add),
      // ),
      floatingActionButton: ElevatedButton(
        onPressed: () => addCount(),
        child: Text('Add'),
        ),
    );
  } //build

  // --function--

  addCount() {
    count++;
    setState(() {});
  }
} //Class
