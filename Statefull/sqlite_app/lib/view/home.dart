import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:sqlite_app/view/insert_students.dart';
import 'package:sqlite_app/view/update_students.dart';
import 'package:sqlite_app/vm/database_handler.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  DatabaseHandler handler = DatabaseHandler();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQLite for Students'),
        actions: [
          IconButton(
            onPressed: () => Get.to(InsertStudents())!.then((value) => reloadData(),), 
            icon: Icon(Icons.add_outlined),
          ),
        ],
      ),
      body: FutureBuilder(
        future: handler.queryStudents(), 
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(UpdateStudents(),
                    arguments: [
                      snapshot.data![index].code,
                      snapshot.data![index].name,
                      snapshot.data![index].dept,
                      snapshot.data![index].phone,
                    ]
                    )!.then((value) => reloadData());
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
                            await handler.deleteStudents(snapshot.data![index].id!);
                            snapshot.data!.remove(snapshot.data![index]);
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    child: Card(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Code : ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                snapshot.data![index].code
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Name : ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                snapshot.data![index].name
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Dept : ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                snapshot.data![index].dept
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Phone : ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                snapshot.data![index].phone
                              ),
                            ],
                          ),
                        ],
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
  } // build

  reloadData(){
    handler.queryStudents();
    setState(() {});
  }
} // class
