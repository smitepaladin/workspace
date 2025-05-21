import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_todo_list_app/model/image_todo_list.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_todo_list_app/view/insert_todo_list.dart';

class QueryTodoList extends StatefulWidget {
  const QueryTodoList({super.key});

  @override
  State<QueryTodoList> createState() => _QueryTodoListState();
}

class _QueryTodoListState extends State<QueryTodoList> {
  List<ImageTodoList> data = [];
  
  @override
  void initState() {
    super.initState();
    getJSONData();
  }

  getJSONData()async{
    var url = Uri.parse("http://127.0.0.1:8000/select");
    var response = await http.get(url);
    // 페이지 바귀면 데이터베이스에서 다시 받아오자

    data.clear(); // 일단 다 지우고
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    List result = dataConvertedJSON['results'];
    data = result.map((e) => ImageTodoList.fromJson(e)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List검색"),
        actions: [ // 앱바 버튼은 actions 로 만든다
          IconButton(
            onPressed: () {
              Get.to(
                () => InsertTodoList()
              )!.then((value) => getJSONData());
            },
            icon: Icon(Icons.add_outlined)
          ),
        ],
      ),
      body: Center(
          child: data.isEmpty
          ? Text(
            '데이터가 없습니다.',
            style:  TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
            )
        : ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return SizedBox(
              height: 100,
              child: Card(
                color: index % 2 == 0
                ? Colors.amber
                : Colors.blue
                ,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'images/${data[index].image}',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10,0,0,0),
                      child: Text(
                        data[index].contents
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10,0,0,0),
                      child: Text(
                        data[index].insertdate
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }//build

}//Class