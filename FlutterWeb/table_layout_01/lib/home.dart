import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Table'),
      ),
      body: Center(
        child: DataTable(
          columns: [
            DataColumn(
              label: SizedBox(
                width: 50,
                child: Text(
                  '학번',
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            DataColumn(
              label: SizedBox(
                width: 50,
                child: Text(
                  '이름',
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            DataColumn(
              label: SizedBox(
                width: 50,
                child: Text(
                  '전화번호',
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ],
          rows: [
            DataRow(
              cells: [
                DataCell(Text('S001')),
                DataCell(Text('유비')),
                DataCell(Text('001')),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('S002')),
                DataCell(Text('관우')),
                DataCell(Text('002')),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text('S003')),
                DataCell(Text('장비')),
                DataCell(Text('003')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}