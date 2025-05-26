import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_crud_app/vm/vm_handler.dart';

class InsertStudent extends StatelessWidget {
  InsertStudent({super.key});

  final codeController = TextEditingController();
  final nameController = TextEditingController();
  final deptController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final vmHandler = Get.find<VmHandler>();

    return Scaffold(
      appBar: AppBar(title: Text("Insert Student")),
      body: Center(
        child: Column(
          children: [
            _buildTextField("학번", codeController),
            _buildTextField("성명", nameController),
            _buildTextField("전공", deptController),
            _buildTextField("전화번호", phoneController),
            _buildTextField("주소", addressController),
            ElevatedButton(
              onPressed: () => insertAction(context),
              child: Text('입력'),
            ),
          ],
        ),
      ),
    );
  } // build

  // Widget //

  Widget _buildTextField(String labelText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: labelText),
      ),
    );
  }

  // Functions //

  Future<void> insertAction(BuildContext context) async {
    final vmHandler = Get.find<VmHandler>();
    final result = await vmHandler.insertStudent(
      codeController.text.trim(),
      nameController.text.trim(),
      deptController.text.trim(),
      phoneController.text.trim(),
      addressController.text.trim(),
    );

    if (result == "OK") {
      showDialog();
    } else {
      errorSnackBar();
    }
  }

  showDialog() {
    Get.defaultDialog(
      title: "입력 결과",
      middleText: "입력이 완료 되었습니다.",
      backgroundColor: Colors.white,
      barrierDismissible: false,
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            Get.back();
          },
          child: Text('OK'),
        ),
      ],
    );
  }

  errorSnackBar() {
    Get.snackbar('Error', '입력시 문제가 발생 했습니다.', duration: Duration(seconds: 2));
  }
}//class