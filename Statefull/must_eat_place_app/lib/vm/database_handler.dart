import 'package:must_eat_place_app/model/eatplace.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


  // final int? id;
  // final String name;
  // final String phone;
  // final String detail;
  // final String category;
  // final bool favor;
  // final Uint8List image;
  // final double latData; // 위도
  // final double longData; // 경도  

class DatabaseHandler {
  Future<Database> initializeDB()async{
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'eatplace.db'),
      onCreate: (db, version) async{
        await db.execute(
        "create table eatplace(id integer primary key autoincrement, name text, phone text, detail text, category text, favor integer, image blob, latData real, longData real)"
        );
      },
      version: 1,
    );
  }

    Future<List<Eatplace>> queryEatplace() async{
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResults = await db.rawQuery('select * from eatplace order by name'); // 이름별로 정렬해서 넘겨주자
    return queryResults.map((e) => Eatplace.fromMap(e)).toList();
  }

  Future<int> insertEatplace(Eatplace eatplace) async{
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawInsert(
      'insert into eatplace(name, phone, detail, category, favor, image, latData, longData) values (?,?,?,?,?,?,?,?)',
      [eatplace.name, eatplace.phone, eatplace.detail, eatplace.category, eatplace.favor, eatplace.image, eatplace.latData, eatplace.longData]
    );
    return result;
  }

    Future<int> updateEatplace(Eatplace eatplace) async{
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawUpdate('update eatplace set name=?, phone=?, detail=?, category=?, favor=?, latData=?, longData=? where id=?',
            [eatplace.name, eatplace.phone, eatplace.detail, eatplace.category, eatplace.favor, eatplace.latData, eatplace.longData, eatplace.id]
    );
    return result;
    }

    Future<int> updateAllEatplace(Eatplace eatplace) async{
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawUpdate('update eatplace set name=?, phone=?, detail=?, category=?, favor=?, image=?, latData=?, longData=? where id=?',
            [eatplace.name, eatplace.phone, eatplace.detail, eatplace.category, eatplace.favor, eatplace.image, eatplace.latData, eatplace.longData, eatplace.id]
    );
    return result;
    }

    Future<void> deleteEatplace(int id) async{
      final Database db = await initializeDB();
      await db.rawDelete('delete from eatplace where id = ?',
            [id]
    );
    }


}