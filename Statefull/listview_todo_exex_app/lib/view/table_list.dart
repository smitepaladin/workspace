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

  late List<TodoList> todoList; // 제너릭은 모델인 TodoList

  @override
  void initState() {
    super.initState();
    todoList = [];
    addData();
  }

  addData() {
    todoList.add(TodoList(imagePath: 'images/cart.png', workList: '책구매'));
    todoList.add(TodoList(imagePath: 'images/clock.png', workList: '철수와 약속'));
    todoList.add(
      TodoList(imagePath: 'images/pencil.png', workList: '스터디 준비하기'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text('Main View'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/insert',
              ).then((value) => rebuildData());
            },
            icon: Icon(Icons.add_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: ListView.builder(
            itemCount: todoList.length,
            itemBuilder: (context, index) {
              // context는 메모리에 등록을 시켜준다. index번호만큼 만들어주기 때문에 알아서 for문 기능이 있다.
              return Dismissible(
                direction: DismissDirection.endToStart,
                key: ValueKey(todoList[index]),
                onDismissed: (direction) {
                  todoList.remove(todoList[index]);
                  setState(() {});
                },

                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(Icons.delete_forever, size: 50),
                ),

                child: GestureDetector(
                  onTap: () {
                    Message.imagePath = todoList[index].imagePath;
                    Message.workList = todoList[index].workList;
                    Navigator.pushNamed(context, '/detail');
                  },
                  child: SizedBox(
                    height: 60,
                    child: Card(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              todoList[index].imagePath,
                            ), // 모델을 통한 리스트 데이터 불로오는 양식
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(todoList[index].workList),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  } //build

  // ===Functions ===

  rebuildData() {
    if (Message.action == true) {
      todoList.add(
        TodoList(imagePath: Message.imagePath, workList: Message.workList),
      );
      Message.action = false;
    }
    setState(() {});
  }
}//Class