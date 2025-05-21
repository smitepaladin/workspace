class Student {
  final String code;
  final String name;
  final String dept;
  final String phone;
  final String address;

  Student(
    {
      required this.code,
      required this.name,
      required this.dept,
      required this.phone,
      required this.address
    }
  );


  factory Student.fromJson(Map<String, dynamic> json){
    return Student(
      code: json['code'],
      name: json['name'],
      dept: json['dept'],
      phone: json['phone'],
      address: json['address'],
    );
  }

  // 여기까지는 가져오는 애들
  // Post를 쓰기 때문에 아래가 필요
  Map<String, dynamic> toJSON(){
  return {
    'code': code,
    'name': name,
    'dept': dept,
    'phone': phone,
    'address': address,
    };
  }

}