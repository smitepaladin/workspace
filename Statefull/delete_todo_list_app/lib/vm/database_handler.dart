import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:delete_todo_list_app/model/todo_list.dart';
import 'package:delete_todo_list_app/model/delete_todo_list.dart';


class DatabaseHandler {
  Future<Database> initializeDB() async{
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'todolist.db'),
      onCreate: (db, version) async{
        await db.execute(
          "create table todolist (id integer primary key autoincrement, worklist text, date text)"
        );
        await db.execute(
          "create table deletetodolist (id integer primary key autoincrement, worklist text, date text)"
        );
      },
      version: 1
    );
  }

  Future<List<Todolist>> queryTodolist() async{
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResults = await db.rawQuery('select * from todolist');
    return queryResults.map((e) => Todolist.fromMap(e)).toList();
  }

  Future<int> insertTodolist(Todolist todolist) async{
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawInsert('insert into todolist(worklist, date) values (?,?)',
            [todolist.worklist, todolist.date]
    );    
    return result;
  }

  Future<int> updateTodolist(Todolist todolist) async{
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawUpdate('update todolist set worklist=?, date=? where id=?',
            [todolist.worklist, todolist.date, todolist.id]
    );    
    return result;
  }


  Future<void> moveToDeleteTable(int id) async {
  final Database db = await initializeDB();

  // 1. 삭제할 데이터 가져오기
  final List<Map<String, Object?>> result = await db.query(
    'todolist',
    where: 'id = ?',
    whereArgs: [id],
  );



  if (result.isNotEmpty) {
    final map = result.first;
    // 2. deletetodolist에 추가
    await db.rawInsert(
      'insert into deletetodolist (worklist, date) values (?, ?)',
      [map['worklist'], map['date']]
    );

    // 3. todolist에서 삭제
    await db.rawDelete(
      'delete from todolist where id = ?',
      [id]
    );
  }
}


    Future<List<DeleteTodoList>> queryDeleteTodolist() async{
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResults = await db.rawQuery('select * from deletetodolist');
    return queryResults.map((e) => DeleteTodoList.fromMap(e)).toList();
  }

    Future<int> updateDeleteTodolist(DeleteTodoList deletetodolist) async{
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawUpdate('update deletetodolist set worklist=?, date=? where id=?',
            [deletetodolist.worklist, deletetodolist.date, deletetodolist.id]
    );    
    return result;
  }

    Future<void> deleteDeleteTodolist(int id) async{
    final Database db = await initializeDB();
    await db.rawDelete('delete from deletetodolist where id = ?',
          [id]
    );
  }
}