import 'dart:convert';
import 'package:bbs/view/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Edit extends StatefulWidget {
  const Edit({super.key});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  //Property
  late int bId;
  late String bName;
  late String bTitle;
  late String bContent;
  late String bDate;

  final keyController = TextEditingController();
  final nameController = TextEditingController();
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    bId = args[0];
    bName = args[1];
    bTitle = args[2];
    bContent = args[3];
    bDate = args[4];

    // TextField 초기화
    keyController.text = bId.toString();
    nameController.text = bName;
    titleController.text = bTitle;
    contentController.text = bContent;
  }

  Future<void> updatePost({
    required int bId,
    required String bName,
    required String bTitle,
    required String bContent,
    required String bDate,
  }) async {
    var url = Uri.parse('http://127.0.0.1:8000/update/$bId');

    var body = jsonEncode({
      "bName": bName,
      "bTitle": bTitle,
      "bContent": bContent,
      "bDate": bDate,
    });

    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      if (result["result"] == "OK") {
        print("게시글 수정 성공");
      } else {
        print("수정 실패: ${result["result"]}");
      }
    } else {
      print("서버 응답 오류: ${response.statusCode}");
    }
  }

  Future<void> deletePost(int bId) async {
    var url = Uri.parse('http://127.0.0.1:8000/delete/$bId');

    var response = await http.post(url);

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      if (result["result"] == "OK") {
        print("게시글 삭제 성공");
      } else {
        print("삭제 실패: ${result["result"]}");
      }
    } else {
      print("서버 응답 오류: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('게시글 수정 및 삭제'),
        actions: [
          TextButton.icon(
            onPressed: () {
              Get.to(() => Home());
            },
            icon: Icon(Icons.book, color: Colors.black),
            label: Text("게시판으로 이동", style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: keyController,
                    readOnly: true,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 16),

                  TextField(
                    controller: nameController,
                    maxLength: 20,
                    decoration: InputDecoration(
                      hintText: "이름을 수정하세요",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),

                  TextField(
                    controller: titleController,
                    maxLength: 40,
                    decoration: InputDecoration(
                      hintText: "제목을 수정하세요",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),

                  TextField(
                    controller: contentController,
                    maxLength: 120,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "내용을 수정하세요",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 32),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OutlinedButton(
                          onPressed: () async {
                            await updatePost(
                              bId: bId,
                              bName: nameController.text,
                              bTitle: titleController.text,
                              bContent: contentController.text,
                              bDate: DateTime.now().toString().replaceFirst('T', ' '),
                            );
                            Get.to(() => Home());
                          },
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            side: BorderSide(color: Colors.purple),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: Text(
                            "수정",
                            style: TextStyle(color: Colors.purple, fontSize: 16),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OutlinedButton(
                          onPressed: () async {
                            await deletePost(bId);
                            Get.to(() => const Home());
                          },
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            side: BorderSide(color: Colors.purple),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: Text(
                            "삭제",
                            style: TextStyle(color: Colors.purple, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
