import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:riverpod_crud_app/view/insert_student.dart';
import 'package:riverpod_crud_app/view/update_student.dart';
import 'package:riverpod_crud_app/vm/student_riverpod.dart';


class QueryStudent extends ConsumerWidget {
  const QueryStudent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentAsync = ref.watch(studentProvider);
    final studentNotifier = ref.read(studentProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text("Provider CRUD for Students"),
        actions: [
          IconButton(
            onPressed: () => Get.to(() => InsertStudent())!.then((_) {
              studentNotifier.refreshStudent();
            },),
            icon: Icon(Icons.add)
          )
        ],
      ),
      body: studentAsync.when(
        data: (students) {
          return students.isEmpty
          ? Center(child: Text("등록된 학생이 없습니다."))
          : ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              final s = students[index];
              return GestureDetector(
                onLongPress: () {
                  _showDialog(context, ref, s.scode);
                },
                onTap: () {
                Get.to(() => UpdateStudent(),
                arguments: [
                  s.scode,
                  s.sname,
                  s.sdept,
                  s.sphone,
                  s.saddress,
                ]
              )!.then((_) {
                studentNotifier.refreshStudent();
              },);
                },
                child: Card(
                  child: ListTile(
                    title: Text("${s.sname} ${s.scode}"),
                    subtitle: Text("${s.sdept} ${s.sphone}"),
                  ),
                ),
              );
            },
          );
        },
        error: (error, _) => Center(child: Text("에러발생 : $error")),
        loading: () => Center(child: CircularProgressIndicator()),
      )    
    );
  }// build

  // fucntions//

_showDialog(BuildContext context, WidgetRef ref, String scode) {
  final studentNotifier = ref.read(studentProvider.notifier);

  Get.defaultDialog(
    title: '삭제 여부',
    middleText: '정말로 삭제하시겠습니까?',
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            Get.back();
          }, 
          child: Text('아니오')
        ),
        TextButton(
          onPressed: () async {
            await studentNotifier.deleteStudent(scode).then((_) {
              studentNotifier.refreshStudent();
            },);
            Get.back(); // 다이얼로그 닫기
          }, 
          child: Text('예')
        ),
      ],
    )
  );
}
}// class