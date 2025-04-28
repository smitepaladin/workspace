import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:delete_todo_list_app/model/delete_todo_list.dart';
import 'package:delete_todo_list_app/vm/database_handler.dart';


class Del extends StatefulWidget {
  const Del({super.key});

  @override
  State<Del> createState() => _DelState();
}

class _DelState extends State<Del> {

  DatabaseHandler handler = DatabaseHandler();
  late TextEditingController worklistController;
  late String date;
  int? id;


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
        title: Text('Delete Lists'),
      ),
      body: FutureBuilder(
        future: handler.queryDeleteTodolist(), 
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    id = snapshot.data![index].id;
                    worklistController.text = snapshot.data![index].worklist;
                    showUpdateDialog();
                    reloadData();
                  },
                  child: Slidable(
                    endActionPane: ActionPane(
                      motion: BehindMotion(), 
                      children: [
                        SlidableAction(
                          backgroundColor: Colors.red,
                          icon: Icons.delete,
                          label: '삭제',
                          onPressed: (context) async{
                            await handler.deleteDeleteTodolist(snapshot.data![index].id!);
                            snapshot.data!.remove(snapshot.data![index]);
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            Icon(Icons.calendar_today),
                            Text('  ${snapshot.data![index].worklist}'),
                            Text(' / '),
                            Text(snapshot.data![index].date)
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }else{
            return Center(
              // snapshot에 데이터 없으면 로딩 출력
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }//build


  // functions //



  showUpdateDialog(){
    Get.defaultDialog(
      title: 'DeleteTodo List',
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
            updateAction();
          }, 
          child: Text('수정하기'),
        ),
      ]
    );
  }


updateAction() async {
  DeleteTodoList deletetodolist = DeleteTodoList(
    id: id,
    worklist: worklistController.text,
    date: DateTime.now().toString().substring(0,10)
  );
  int result = await handler.updateDeleteTodolist(deletetodolist);
  if (result == 0) {
    errorSnackBar();
  } else {
    setState(() {});
    Get.back();
  }
}
  
  errorSnackBar(){
    Get.snackbar(
      "경고", 
      "입력 중 문제가 발생했습니다",
      colorText: Theme.of(context).colorScheme.onError,
      backgroundColor: Theme.of(context).colorScheme.error,
      );
  }


  
  reloadData(){
    handler.queryDeleteTodolist();
    setState(() {});
  }

}//Class