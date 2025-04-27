import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property

  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Key board Enter')),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(labelText: '글자를 입력하세요'),
              keyboardType: TextInputType.text,
              textInputAction:
                  TextInputAction.go, // go와 onSubmitted는 항상 같이 나온다.
              onSubmitted: (value) {
                if (textEditingController.text.trim().isEmpty) {
                  errorSnackBar();
                } else {
                  showSnackBar();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // functions //

  errorSnackBar() {
    Get.snackbar(
      '경고',
      '입력을 확인하세요',
      snackPosition: SnackPosition.TOP,
      colorText: Theme.of(context).colorScheme.onTertiary,
      backgroundColor: Theme.of(context).colorScheme.tertiary,
    );
  }

  showSnackBar() {
    Get.snackbar(
      '입력 완료',
      '입력한 글자는 ${textEditingController.text} 입니다.',
      snackPosition: SnackPosition.TOP,
      colorText: Theme.of(context).colorScheme.onTertiary,
      backgroundColor: Theme.of(context).colorScheme.tertiary,
    );
  }
}
