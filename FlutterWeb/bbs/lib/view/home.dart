import 'dart:convert';
import 'package:bbs/view/edit.dart';
import 'package:bbs/view/write.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List data = [];
  int currentPage = 1;
  final int pageSize = 8;
  int totalItems = 0;

  @override
  void initState() {
    super.initState();
    fetchPageData();
  }

  Future<void> fetchPageData() async {
    var url = Uri.parse(
      'http://127.0.0.1:8000/select?page=$currentPage&size=$pageSize',
    );
    var response = await http.get(url);
    var decoded = json.decode(utf8.decode(response.bodyBytes));
    setState(() {
      data = decoded['results'];
      totalItems = decoded['total'];
    });
  }

  void goToNextPage() {
    if (currentPage * pageSize < totalItems) {
      setState(() {
        currentPage++;
      });
      fetchPageData();
    }
  }

  void goToPreviousPage() {
    if (currentPage > 1) {
      setState(() {
        currentPage--;
      });
      fetchPageData();
    }
  }

  List<DataRow> getRows() {
    return List.generate(data.length, (index) {
      final item = data[index];
      return DataRow(
        onLongPress:
            () => Get.to(
              () => Edit(),
              arguments: [
                item['bId'],
                item['bName'],
                item['bTitle'],
                item['bContent'],
                item['bDate'].toString().replaceFirst('T', ' '),
              ],
            ),
        cells: [
          DataCell(Text('${(currentPage - 1) * pageSize + index + 1}')),
          DataCell(
            Text(item['bId'].toString()),
            onTap: () {
              Get.to(
                () => Edit(),
                arguments: [
                  item['bId'],
                  item['bName'],
                  item['bTitle'],
                  item['bContent'],
                  item['bDate'].toString().replaceFirst('T', ' '),
                ],
              );
            },
          ),
          DataCell(Text(item['bName'] ?? '')),
          DataCell(Text(item['bTitle'] ?? '')),
          DataCell(Text(item['bDate'].toString().replaceFirst('T', ' '))),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('게시판'),
        actions: [
          TextButton.icon(
            onPressed: () {
              Get.to(() => Write());
            },
            icon: Icon(Icons.edit, color: Colors.black),
            label: Text("게시글 작성", style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
      body: Center(
        child:
            data.isEmpty
                ? CircularProgressIndicator()
                : SingleChildScrollView(
                  child: Column(
                    children: [
                      DataTable(
                        columns: [
                          DataColumn(
                            label: SizedBox(
                              width: 100,
                              child: Text(
                                '순서',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: SizedBox(
                              width: 100,
                              child: Text(
                                'Key',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: SizedBox(
                              width: 100,
                              child: Text(
                                '작성자',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: SizedBox(
                              width: 100,
                              child: Text(
                                '제목',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: SizedBox(
                              width: 100,
                              child: Text(
                                '작성일자',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                        rows: getRows(),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed:
                                currentPage > 1 ? goToPreviousPage : null,
                            child: Text("이전"),
                          ),
                          SizedBox(width: 16),
                          Text(
                            "페이지 $currentPage / ${(totalItems / pageSize).ceil()}",
                          ),
                          SizedBox(width: 16),
                          ElevatedButton(
                            onPressed:
                                currentPage * pageSize < totalItems
                                    ? goToNextPage
                                    : null,
                            child: Text("다음"),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
      ),
    );
  } // build
} // Class
