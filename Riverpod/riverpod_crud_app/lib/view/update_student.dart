import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:riverpod_crud_app/model/student.dart';
import 'package:riverpod_crud_app/vm/student_riverpod.dart';

class UpdateStudent extends ConsumerWidget {
  UpdateStudent({super.key});
  final codeController = TextEditingController();
  final nameController = TextEditingController();
  final deptController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final args = Get.arguments ?? "__";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    codeController.text = args[0];
    nameController.text = args[1];
    deptController.text = args[2];
    phoneController.text = args[3];
    addressController.text = args[4];

    return Scaffold(
      appBar: AppBar(title: Text("Update Student")),
      body: Center(
        child: Column(
          children: [
            // _buildTextField("학번", codeController),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: codeController,
                decoration: InputDecoration(labelText: "학번"),
                readOnly: true,
              ),
            ),
            _buildTextField("성명", nameController),
            _buildTextField("전공", deptController),
            _buildTextField("전화번호", phoneController),
            _buildTextField("주소", addressController),
            ElevatedButton(
              onPressed: () => updateAction(context, ref),
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

  updateAction(BuildContext context, WidgetRef ref) async {
    final studentNotifier = ref.read(studentProvider.notifier);
    final student = Student(
      scode: codeController.text.trim(),
      sname: nameController.text.trim(),
      sdept: deptController.text.trim(),
      sphone: phoneController.text.trim(),
      saddress: addressController.text.trim(),
    );
    final result = await studentNotifier.updateStudent(student);

    if (result == "OK") {
      showDialog(context);
    } else {
      errorSnackBar(context);
    }
  }

  showDialog(BuildContext context) {
    Get.defaultDialog(
      title: "수정 결과",
      middleText: "수정이 완료 되었습니다.",
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
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

  errorSnackBar(context) {
    Get.snackbar('Error', '수정시 문제가 발생 했습니다.', duration: Duration(seconds: 2));
  }
}//class