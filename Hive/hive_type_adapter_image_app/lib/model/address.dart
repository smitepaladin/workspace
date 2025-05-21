import 'dart:typed_data';
import 'package:hive_flutter/hive_flutter.dart';


// Code 생성

part 'address.g.dart';

@HiveType(typeId: 1) // HiveType이 테이블을 뜻 한다.
class Address {
  @HiveField(0)
  String name;

  @HiveField(1)
  String phone;

  @HiveField(2)
  String address;

  @HiveField(3)
  String relation;

  @HiveField(4)
  Uint8List image;


  Address(
    {
      required this.name,
      required this.phone,
      required this.address,
      required this.relation,
      required this.image
    }
  );


}