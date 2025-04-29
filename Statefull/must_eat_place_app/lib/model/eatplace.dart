import 'dart:typed_data';

class Eatplace {
  final int? id;
  final String name;
  final String phone;
  final String detail;
  final String category;
  final bool favor;
  final Uint8List image;
  final double latData;
  final double longData;

  Eatplace({
    this.id,
    required this.name,
    required this.phone,
    required this.detail,
    required this.category,
    required this.favor,
    required this.image,
    required this.latData,
    required this.longData,
  });

  Eatplace.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        name = res['name'],
        phone = res['phone'],
        detail = res['detail'],
        category = res['category'],
        favor = res['favor'] == 1, 
        image = res['image'],
        latData = res['latData'],
        longData = res['longData'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'detail': detail,
      'category': category,
      'favor': favor ? 1 : 0,
      'image': image,
      'latData': latData,
      'longData': longData,
    };
  }
}
