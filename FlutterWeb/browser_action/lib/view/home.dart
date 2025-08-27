import 'package:browser_action/view/first_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Main Page'),
            ElevatedButton(
              onPressed: () => Get.to(() => FirstPage()),
              child: Text('Next Page'),
            )
          ],
        ),
      ),
    );
  }
}