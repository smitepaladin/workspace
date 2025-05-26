import 'package:get/get.dart';
import 'package:getx_must_eat_place_app/model/address.dart';
import 'package:getx_must_eat_place_app/vm/vm_image_handler.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class VmDatabaseHandler extends VmImageHandler{
  // 주소 데이터 리스트
  final addresses = <Address>[].obs;

  // SQLite
  // DB 생성
  Future<Database> initializedDB()async{
    String path = join(await getDatabasesPath(), "address.db");
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async{
        await db.execute(
          '''
            CREATE TABLE address(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT,
              phone TEXT,
              estimate TEXT,
              lat REAL,
              lng REAL,
              image BLOB,
              actiondate TEXT
            )
          '''
        );
      },
    );
  }

  // 입력
  // datetime은 SQLite 함수 MySQL에서는 now()로 쓰면 됨
  Future<void> insertAddress(Address address)async{
    final db = await initializedDB();
    await db.rawInsert(
      '''
        INSERT INTO address(name, phone, estimate, lat, lng, image, actiondate)
        VALUES (?,?,?,?,?,?,datetime('now', 'localtime'))
      ''',
      [
        address.name,
        address.phone,
        address.estimate,
        address.lat,
        address.lng,
        address.image
      ]
    );
    await queryAddress();
  }

  // 주소 전체 조회
  Future<void> queryAddress()async{
    final db = await initializedDB();
    final result = await db.rawQuery('SELECT * FROM address');
    addresses.value = result.map((data) => Address.fromMap(data)).toList();
  }

  // 주소 삭제
  Future<void> deleteAddress(int id) async{
    final db = await initializedDB();
    await db.rawDelete('DELETE FROM address WHERE id = ?', [id]);
    await queryAddress();
  }

  // 이미지 제외 수정
  Future<void> updateAddress(Address address)async{
    final db = await initializedDB();
    await db.rawUpdate(
      '''
        UPDATE address
        set name = ?, phone = ?, estimate = ?, lat = ?, lng = ?, actiondate=datetime('now', 'localtime')
        WHERE id = ?
      ''',
      [
        address.name,
        address.phone,
        address.estimate,
        address.lat,
        address.lng,
        address.id
      ]
    );
    await queryAddress();
  }

  // 이미지 포함 수정
  Future<void> updateAddressAll(Address address)async{
    final db = await initializedDB();
    await db.rawUpdate(
      '''
        UPDATE address
        set name = ?, phone = ?, estimate = ?, lat = ?, lng = ?, image = ?, actiondate=datetime('now', 'localtime')
        WHERE id = ?
      ''',
      [
        address.name,
        address.phone,
        address.estimate,
        address.lat,
        address.lng,
        address.image,
        address.id
      ]
    );
    await queryAddress();
  }

}