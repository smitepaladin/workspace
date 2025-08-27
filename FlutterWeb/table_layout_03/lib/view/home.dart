import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:table_layout_03/view/detail.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property
  late List data;

  @override
  void initState() {
    super.initState();
    data = [];
    getJSONData();
  }

  getJSONData()async{
    var url = Uri.parse("https://zeushahn.github.io/Test/movies.json");
    var response = await http.get(url);
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    List result = dataConvertedJSON['results'];
    data.addAll(result);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Moives List'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: data.isEmpty
          ? CircularProgressIndicator()
          : Column(
            children: [
              DataTable(
                columnSpacing: 0,
                horizontalMargin: 0,
                dataRowMaxHeight: 150,
                columns: [
                  DataColumn(
                    label: Text(
                      'Cinema Poster',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                  DataColumn(
                    label: Text(
                      'Cinema Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                ], 
                rows: getRows()
                ),
            ],
          )
        ),
      )
    );
  } 

  // --Functions --
  List<DataRow> getRows() {
    List<DataRow> dataRow = [];
    for (int i = 0; i < data.length; i++) {
      List<DataCell> cells = [];
      cells.add(
        DataCell(
          onTap: () {
            Get.to(
              () => const Detail(),
              arguments: [
                data[i]['image'],
                data[i]['title']
              ],
              transition: Transition.noTransition
            );
          },
          Padding(
            padding: const EdgeInsets.all(80.0),
            child: Image.network(
              data[i]['image'],
            ),
          ),
        ),
      );
      cells.add(
        DataCell(
          Text(
            data[i]['title'],
          ),
        ),
      );
      dataRow.add(
        DataRow(
          cells: cells,
        ),
      );
    }
    return dataRow;
  }



} // class