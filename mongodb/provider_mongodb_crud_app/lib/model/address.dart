class Address {
  final String code;
  final String name;
  final String dept;
  final String phone;
  final String image;


  Address(
    {
      required this.code,
      required this.name,
      required this.dept,
      required this.phone,
      required this.image,
    }
  );

  // 서버에서 받은 JSON을 Student 객체로 변환

  factory Address.fromJson(Map<String,dynamic> json){
    return Address(
      code: json['code'] ?? "",
      name: json['name'] ?? "",
      dept: json['dept'] ?? "",
      phone: json['phone'] ?? "",
      image: json['image'] ?? ""
    );
  }

}