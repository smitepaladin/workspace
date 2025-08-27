import 'dart:convert';
import 'package:bbs/view/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Write extends StatefulWidget {
  const Write({super.key});

  @override
  State<Write> createState() => _WriteState();
}

class _WriteState extends State<Write> {
  //Property
  final nameController = TextEditingController();
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = "";
    titleController.text = "";
    contentController.text = "";
  }

  Future<void> insertPost({
    required String bName,
    required String bTitle,
    required String bContent,
  }) async {
    var url = Uri.parse('http://127.0.0.1:8000/insert');
    var bDate = DateTime.now().toString().replaceFirst('T', ' ');

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
        print("게시글 작성 성공");
      } else {
        print("작성 실패: ${result["result"]}");
      }
    } else {
      print("서버 응답 오류: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('게시판'),
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
                    controller: nameController,
                    maxLength: 20,
                    decoration: InputDecoration(
                      hintText: "이름을 입력하세요",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),

                  TextField(
                    controller: titleController,
                    maxLength: 40,
                    decoration: InputDecoration(
                      hintText: "제목을 입력하세요",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),

                  TextField(
                    controller: contentController,
                    maxLength: 120,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "내용을 입력하세요",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 32),

                  OutlinedButton(
                    onPressed: () async {
                      await insertPost(
                        bName: nameController.text,
                        bTitle: titleController.text,
                        bContent: contentController.text,
                      );
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
                      "입력",
                      style: TextStyle(color: Colors.purple, fontSize: 16),
                    ),
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
