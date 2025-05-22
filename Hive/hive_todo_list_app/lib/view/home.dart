import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_todo_list_app/model/todo_list.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Property
  Box todoListBox = Hive.box('todo_list');
  late TextEditingController worklistController;
  late String date;
  



  @override
  void initState() {
    super.initState();
    worklistController = TextEditingController();
    date = DateTime.now().toString().substring(0,10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo Lists"),
        actions: [
          IconButton(
            onPressed: () {
              worklistController.clear();              
              showInsertDialog();
            },
            icon: Icon(Icons.add_outlined),
          )
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: todoListBox.listenable(), // 바뀌었는지 계속 체크하고 있다. 추가, 수정, 삭제되면 바로 받아온다. setstate가 필요없다.
        builder: (context, Box todoListBox, widget) => todoListBox.isEmpty
        ? Center(child: Text('Empty'),)
        : ListView.builder(
          itemCount: todoListBox.length,
          itemBuilder: (context, index) {
            var todoListData = todoListBox.getAt(index);
            return GestureDetector(
              onTap: () => _updateDialog(index),
              child: Slidable(
                endActionPane: ActionPane(
                  motion: BehindMotion(),
                  children: [
                    SlidableAction(
                      backgroundColor: Colors.red,
                      icon: Icons.delete,
                      label: "Delete",
                      onPressed: (context) => selectDelete(index),
                    )
                  ],
                ),
                child: Card(
                  child: Row(
                    children: [
                      Icon(Icons.calendar_month_outlined),
                      Text("  ${todoListData.work}"),
                      Text("  ${todoListData.date}"),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  } // build

  showInsertDialog(){
    Get.defaultDialog(
      title: 'Todo List',
      content: TextField(
        controller: worklistController,
        decoration: InputDecoration(
          labelText: '추가할 내용'
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      barrierDismissible: false,
      actions: [
        TextButton(
          onPressed: () {
            _insertAction();
          }, 
          child: Text('추가하기'),
        ),
      ]
    );
  }


  _insertAction()async{

    TodoList todoList = TodoList(
      work: worklistController.text.trim(),
      date: DateTime.now().toString().substring(0,10)
    );

    todoListBox.add(todoList);
    Get.back();
  }

    selectDelete(int index){
    showCupertinoModalPopup(
      context: context,
      barrierDismissible: false,
      builder: (context) => CupertinoActionSheet(
        title: Text("경고"),
        message: Text("선택한 항목을 삭제 하시겠습니까?"),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              todoListBox.deleteAt(index);
              Get.back();
            },
            child: Text("삭제"),
          )
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Get.back(),
          child: Text("Cancel"),
        ),
      ),
    );
  }


  _updateDialog(index){
    worklistController.text = todoListBox.getAt(index).work;
    Get.defaultDialog(
      title: 'Todo List',
      content: TextField(
        controller: worklistController,
        decoration: InputDecoration(
          labelText: '수정할 내용'
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      barrierDismissible: false,
      actions: [
        TextButton(
          onPressed: () {
            _updateAction(index);
          }, 
          child: Text('추가하기'),
        ),
      ]
    );
  }

  _updateAction(index) {
    TodoList todolist = TodoList(
      work: worklistController.text.trim(), 
      date: DateTime.now().toString().substring(0,10)
    );

    todoListBox.putAt(index, todolist);
    Get.back();
  }



} // class