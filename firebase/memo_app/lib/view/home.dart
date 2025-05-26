import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memo_app/model/memo.dart';
import 'package:memo_app/vm/memo_model.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final memoModel = context.watch<MemoModel>();
    final memoList = memoModel.memos;

    return Scaffold(
      appBar: AppBar(
        title: Text("Memo"),
      ),
      body: Column(
        children: [
          Expanded(
            child: memoList.isEmpty
            ? Center(child: Text('메모가 없습니다.'))
            : ListView.builder(
              itemCount: memoList.length,
              itemBuilder: (context, index) {
                Memo memo = memoList[index];
                return ListTile(
                  title: Text(memo.title),
                  subtitle: Text(memo.content),
                  trailing: IconButton(
                    onPressed: () async{
                      await context.read<MemoModel>().deleteMemo(memo.id);
                      Get.snackbar(
                        "삭제완료",
                        "${memo.title} 메모가 삭제되었습니다.",
                        snackPosition: SnackPosition.TOP
                      );
                    },
                    icon: Icon(Icons.delete),
                  ),
                );
              },
            )
            ,
          ),
          Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: "제목을 입력하세요."),
              ),
              TextField(
                controller: contentController,
                decoration: InputDecoration(labelText: "내용을 입력하세요."),
              ),
              ElevatedButton(
                onPressed: () async {
                  if(titleController.text.isNotEmpty || contentController.text.isNotEmpty){
                    await context.read<MemoModel>().addMemo(
                      titleController.text, contentController.text
                    );
                    titleController.clear();
                    contentController.clear();
                    Get.snackbar("추가완료", "메모가 추가되었습니다");
                  }else{
                    Get.snackbar("오류", "제목과 내용을 모두 입력해주세요");
                  }
                },
                child: Text("메모 추가"),
              ),
            ],
          )
        ],
      ),
    );
  }
}