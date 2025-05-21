import 'dart:convert';
import 'package:crud_app/model/student.dart';
import 'package:crud_app/view/delete_students.dart';
import 'package:crud_app/view/insert_students.dart';
import 'package:crud_app/view/update_student.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class QueryStudents extends StatefulWidget {
  const QueryStudents({super.key});

  @override
  State<QueryStudents> createState() => _QueryStudentsState();
}

class _QueryStudentsState extends State<QueryStudents> {
  List<Student> data = [];
  
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
    data = result.map((e) => Student.fromJson(e)).toList();
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD for Students'),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(
                () => InsertStudents()
              )!.then((value) => getJSONData());
            },
            icon: Icon(Icons.add_outlined),
          )
        ]
      ),
      body: SizedBox(// 혹시나 싶어서 넣는다. 구분시키려고. 지금은 안씀
        child: Center(
          child: data.isEmpty
          ? Text(
            '데이터가 없습니다.',
            style:  TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
            )
          : ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final student = data[index];
              return GestureDetector(
                onTap: () {
                  Get.to(
                    UpdateStudent(),
                    arguments: [
                      student.code,
                      student.name,
                      student.dept,
                      student.phone,
                      student.address
                    ],
                  )!.then((value) => getJSONData());
                },
                onLongPress: () {
                  Get.to(
                    DeleteStudents(),
                    arguments: [
                      student.code,
                      student.name,
                      student.dept,
                      student.phone,
                      student.address
                    ],
                  )!.then((value) => getJSONData());
                },
                child: Card(
                  color: Colors.amber[50],
                  child: Column(
                    children: [
                      _buildRow("Code :", student.code),
                      _buildRow("Name :", student.name),
                      _buildRow("Dept :", student.dept),
                      _buildRow("Phone :", student.phone),
                      _buildRow("Address:", student.address)
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      )
    );
  }//build

  // -- Widget --
  Widget _buildRow(String label, String value){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
          ),
          Text(value)
        ],
      ),
    );
  }

}//class