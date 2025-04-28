import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:simple_todo_list_app/model/todo_list.dart';


class DatabaseHandler {
  Future<Database> initializeDB() async{
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'todolist.db'),
      onCreate: (db, version) async{
        await db.execute(
          "create table todolist (id integer primary key autoincrement, worklist text, date text)"
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

    Future<void> deleteTodolist(int id) async{
      final Database db = await initializeDB();
      await db.rawDelete('delete from todolist where id = ?',
            [id]
    );
    }
}