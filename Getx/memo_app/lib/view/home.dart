import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memo_app/model/memo.dart';
import 'package:memo_app/vm/memo_model.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final memoController = Get.find<MemoController>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Memo"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                    itemCount: memoController.memos.length,
                    itemBuilder: (context, index) {
                      final Memo memo = memoController.memos[index];
                      return ListTile(
                        title: Text(memo.title),
                        subtitle: Text(memo.content),
                        trailing: IconButton(
                          onPressed: () => memoController.deleteMemo(memo.id),
                          icon: Icon(Icons.delete),
                        ),
                      );
                    },
                  )
            )
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
                onPressed: () {
                  final title = titleController.text.trim();
                  final content = contentController.text.trim();

                  if(title.isNotEmpty && content.isNotEmpty){
                    memoController.addMemo(title, content);
                    titleController.clear();
                    contentController.clear();
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