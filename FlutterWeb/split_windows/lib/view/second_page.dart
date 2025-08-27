import 'package:flutter/material.dart';
import 'package:flutter_split_view/flutter_split_view.dart';
import 'package:split_windows/view/third_page.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                SplitView.of(context).pop();
              },
              child: Text('back')
            ),
            ElevatedButton(
              onPressed: () {
                SplitView.of(context).push(
                  ThirdPage(),
                  title: 'Third'
                );
              },
              child: Text('forword')
            ),
          ],
        ),
      ),
    );
  }
}