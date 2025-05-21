import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mysql_image_app/view/insert_address.dart';
import 'package:mysql_image_app/view/update_address.dart';

class QueryAddress extends StatefulWidget {
  const QueryAddress({super.key});

  @override
  State<QueryAddress> createState() => _QueryAddressState();
}

class _QueryAddressState extends State<QueryAddress> {
  List data = [];

  @override
  void initState() {
    super.initState();
    getJsonData();
  }

getJsonData()async{
  var response = await http.get(Uri.parse('http://127.0.0.1:8000/select'));
  data.clear();
  data.addAll(json.decode(utf8.decode(response.bodyBytes))['results']);
  setState(() {});
  // print(data);
}

// ---------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('주소록 검색'),
        actions: [
          IconButton(
            onPressed: () => Get.to(()=> InsertAddress())!.then((value) => getJsonData()),
            icon: Icon(Icons.add_outlined)
          )
        ],
      ),
      body: Center(
        child: data.isEmpty
        ? Center(
          child: Text('데이터가 없습니다'),
        )
        : ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(()=> UpdateAddress(),
                  arguments: [
                    data[index]['seq'],
                    data[index]['name'],
                    data[index]['phone'],
                    data[index]['address'],
                    data[index]['relation'], // 이미지 안 가져간다.
                  ]
                )!.then((value) => getJsonData());
              },
              child: Slidable(
                endActionPane: ActionPane(
                  motion: BehindMotion(),
                  children: [
                    SlidableAction(
                      backgroundColor: Colors.red,
                      icon: Icons.delete_forever,
                      label: "Delete",
                      onPressed: (context) => deleteAction(data[index]['seq']),
                    )
                  ],
                ),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        // ?t=내용 => 네트워크에서 바뀌는 것을 감지해서 이미지 가지고 올 수 있게 밀리세컨드 단위로 가져옴
                        Image.network('http://127.0.0.1:8000/view/${data[index]['seq']}?t=${DateTime.now().millisecondsSinceEpoch}',
                        width: 100,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("이름 : ${data[index]['name']}"),
                            Text("전화번호 : ${data[index]['phone']}"),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          ),
      ),
    );
  }//Build


  // -- functions --
  deleteAction(int seq){
    getJsonDataDelete(seq);
    getJsonData();
  }

  getJsonDataDelete(int seq)async{
  var response = await http.delete(Uri.parse('http://127.0.0.1:8000/delete/$seq'));
  var result = json.decode(utf8.decode(response.bodyBytes))['result'];
  if(result != "OK"){
      errorSnackBar();
    }
  }

  errorSnackBar(){
    Get.snackbar(
      'Error', 
      '삭제시 문제가 발생 했습니다.',
      duration: Duration(seconds: 2)
    );
  }

}// Class
