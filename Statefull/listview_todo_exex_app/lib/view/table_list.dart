import 'package:flutter/material.dart';
import 'package:listview_todo_exex_app/model/message.dart';
import 'package:listview_todo_exex_app/model/todo_list.dart';

class TableList extends StatefulWidget {
  const TableList({super.key});

  @override
  State<TableList> createState() => _TableListState();
}

class _TableListState extends State<TableList> {
  // Property

  late List<TodoList> todoList;



  @override
  void initState() {
    super.initState();
    todoList = [];
    addData();
  }


  addData(){
    todoList.add(TodoList(imagePath: 'images/cart.png', workList: '책구매'));
    todoList.add(TodoList(imagePath: 'images/clock.png', workList: '철수와 약속'));
    todoList.add(TodoList(imagePath: 'images/pencil.png', workList: '스터디 준비하기'));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main View'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/insert').then((value) => rebuildData());
            },
            icon: Icon(Icons.add_outlined)
          ),
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context, index){
            return GestureDetector(
              onTap: () {
                Message.imagePath = todoList[index].imagePath;
                Message.workList = todoList[index].workList;
                Navigator.pushNamed(context, '/detail');
              },
              child: Card(
                child: Row(
                  children: [
                    Image.asset(
                      todoList[index].imagePath,
                    ),
                    Text(
                      todoList[index].imagePath,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      )
    );
  }//build

  // ===Functions ===

  rebuildData(){
    
  }
}//Class