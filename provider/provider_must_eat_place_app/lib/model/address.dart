import 'dart:typed_data';

class Address {
  final int? id; // autoincrement
  final String name; // 가게이름
  final String phone; // 전화번호
  final String estimate; // 평가점수
  final double lat; // 위도
  final double lng; // 경도
  final Uint8List image; // 이미지

  Address(
    {
      this.id,
      required this.name,
      required this.phone,
      required this.estimate,
      required this.lat,
      required this.lng,
      required this.image
    }
  );

  // Map -> Address 로 변환 (DB 조회), JSON형식으로 온 데이터를 받아서 위에 생성자형태로 바꿔준다.
  factory Address.fromMap(Map<String, dynamic> map){
    return Address(
      id: map['id'] as int?,
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      estimate: map['estimate'] ?? '',
      lat: map['lat'] ?? 0.0,
      lng: map['lng'] ?? 0.0,
      image: map['image'],
    );
  }

  // Address 생성자 -> Map(DB 저장시)

  Map<String, dynamic> toMap (){
    return{
      'id' : id,
      'name' : name,
      'phone' : phone,
      'estimate' : estimate,
      'lat' : lat,
      'lng' : lng,
      'image' : image,
    };
  }


}