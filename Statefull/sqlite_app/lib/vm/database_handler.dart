import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_app/model/students.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async{
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'student.db'),
      onCreate: (db, version) async{
        await db.execute(
          "create table students (id integer primary key autoincrement, code text, name text, dept text, phone text)"
        );
      },
      version: 1
    );
  }

  Future<List<Students>> quewryStudents() async{
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResults = await db.rawQuery('select * from students');
    return queryResults.map((e) => Students.fromMap(e)).toList();
  }
  Future<int> insertStudents(Students student) async{
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawInsert('insert into students(code, name, dept, phone) values (?,?,?,?)',
            [student.code, student.name, student.dept, student.phone]
    );
    print("Insert return value : $result");
    return result;
  }

    Future<int> updateStudents(Students student) async{
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawUpdate('update students set name=?, dept=?, phone=? where code=?',
            [student.name, student.dept, student.phone, student.code]
    );
    print("update return value : $result");
    return result;
    }

    Future<void> deleteStudents(int id) async{
      final Database db = await initializeDB();
      await db.rawDelete('delete from students where id = ?',
            [id]
    );
    }
}