import 'package:hive_flutter/hive_flutter.dart';



// Code 생성

part 'todo_list.g.dart';

@HiveType(typeId: 1) // HiveType이 테이블을 뜻 한다.
class TodoList {
  @HiveField(0)
  String work;

  @HiveField(1)
  String date;


  TodoList(
    {
      required this.work,
      required this.date,
    }
  );


}