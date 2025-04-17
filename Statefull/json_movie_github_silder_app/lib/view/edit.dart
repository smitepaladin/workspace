import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Edit extends StatefulWidget {
  const Edit({super.key});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  var value = Get.arguments ?? "__"; // null값이 포함될 수 있다.
  late TextEditingController textEditingController;


  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    textEditingController.text = value[1]; // 가져온 영화의 title을 미리 넣어준다.
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              value[0]
            ),
            TextField(
              controller: textEditingController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.back(result: textEditingController.text);
                  },
                  child: Text('Edit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.back(result: value[1]); // 그냥 보내면 null값을 home에서 받지 못하므로, 원래값을 넣어준다.
                  },
                  child: Text('Cancel'),
                ),
              ],
            )
          ],
        ),
      ),

    );
  }
}