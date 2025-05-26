import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_crud_app/view/insert_student.dart';
import 'package:getx_crud_app/view/update_student.dart';
import 'package:getx_crud_app/vm/vm_handler.dart';


class QueryStudent extends StatelessWidget {
  const QueryStudent({super.key});

  @override
  Widget build(BuildContext context) {
    final VmHandler vmHandler = Get.find<VmHandler>(); // 컨트롤러 주입
    vmHandler.fetchStudents();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Provider CRUD for Students"),
        actions: [
          IconButton(
            onPressed: () async{
              Get.to(()=> InsertStudent())!.then((_) => vmHandler.fetchStudents());
            },
            icon: Icon(Icons.add)
          )
        ],
      ),
      body: Obx(() {
        return ListView.builder(
        itemCount: vmHandler.students.length,
        itemBuilder: (context, index) {
          final s = vmHandler.students[index];
          return GestureDetector(
            onLongPress: () {
              _showDialog(context, s.scode);
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
              );
            },
            child: ListTile(
              title: Text("${s.sname} (${s.scode})"),
              subtitle: Text("${s.sdept} | ${s.sphone}"),
            ),
          );
        },
      );
      })
      
      
    );
  }// build

  // fucntions//

_showDialog(BuildContext context, String scode) {
  Get.defaultDialog(
    title: '삭제 여부',
    middleText: '정말로 삭제하시겠습니까?',
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text('아니오'),
        ),
        TextButton(
          onPressed: () async {
            final vmHandler = Get.find<VmHandler>();
            await vmHandler.deleteStudent(scode);
            Get.back(); // 삭제 후 다이얼로그 닫기
          },
          child: Text('예'),
        ),
      ],
    ),
  );
}
}// class