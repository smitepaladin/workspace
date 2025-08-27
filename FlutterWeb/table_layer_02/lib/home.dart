import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Property
  late List data;

  @override
  void initState() {
    super.initState();
    data = [];
    getJSONData();
  }

  getJSONData() async {
    var url = Uri.parse('https://zeushahn.github.io/Test/student.json');
    var response = await http.get(url);
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    List result = dataConvertedJSON['results'];
    data.addAll(result);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Data Table')),
      body: SingleChildScrollView(
        child: Center(
          child:
              data.isEmpty
                  ? CircularProgressIndicator()
                  : Column(
                    children: [
                      DataTable(
                        columns: [
                          DataColumn(
                            label: SizedBox(
                              width: 100,
                              child: Text(
                                'Code',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: SizedBox(
                              width: 100,
                              child: Text(
                                'Name',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: SizedBox(
                              width: 100,
                              child: Text(
                                'Dept',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: SizedBox(
                              width: 100,
                              child: Text(
                                'Phone',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                        rows: getRows(),
                      ),
                    ],
                  ),
        ),
      ),
    );
  } // Build

  // -- Functions --

  List<DataRow> getRows() {
    List<DataRow> dataRow = [];
    for (int i = 0; i < data.length; i++) {
      List<DataCell> cells = [];
      cells.add(DataCell(Text(data[i]['code'])));
      cells.add(DataCell(Text(data[i]['name'])));
      cells.add(DataCell(Text(data[i]['dept'])));
      cells.add(DataCell(Text(data[i]['phone'])));
      dataRow.add(DataRow(cells: cells));
    }
    return dataRow;
  }
}// Class