import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:riverpod_crud_app/model/student.dart';
import 'package:riverpod_crud_app/vm/student_riverpod.dart';


class InsertStudent extends ConsumerWidget {
  InsertStudent({super.key});

  final codeController = TextEditingController();
  final nameController = TextEditingController();
  final deptController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    

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
              onPressed: () => insertAction(context, ref),
              child: Text('입력'),
            )
          ],
        ),
      ),
    );
  } // build

  // Widget //

  Widget _buildTextField(String labelText, TextEditingController controller){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: labelText),
      ),
    );
  }


  // Functions //



insertAction(BuildContext context, WidgetRef ref) async {
  final studentNotifier = ref.read(studentProvider.notifier);
  final student = Student(
    scode: codeController.text.trim(),
    sname: nameController.text.trim(),
    sdept: deptController.text.trim(),
    sphone: phoneController.text.trim(),
    saddress: addressController.text.trim(),
  );

  final result = await studentNotifier.insertStudent(student);

  if (result == "OK") {
    showDialog(context);
  } else {
    errorSnackBar(context);
  }
}

  showDialog(BuildContext context){
    Get.defaultDialog(
      title: "입력 결과",
      middleText: "입력이 완료 되었습니다.",
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      barrierDismissible: false,
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            Get.back();
          }, 
          child: Text('OK')
      ),
    ]
  );
}


  errorSnackBar(BuildContext context){
    Get.snackbar(
      'Error', 
      '입력시 문제가 발생 했습니다.',
      duration: Duration(seconds: 2)
    );
  }


}//class