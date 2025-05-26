import 'dart:convert';
import 'package:get/get.dart';
import 'package:getx_crud_app/model/student.dart';
import 'package:http/http.dart' as http;

class VmHandler extends GetxController{
  final String baseUrl = "http://127.0.0.1:8000";
  final RxList<Student> students = <Student>[].obs;

  Future<void> fetchStudents()async{
    try{
      students.clear();
      final res = await http.get(Uri.parse("$baseUrl/select"));
      final data = json.decode(utf8.decode(res.bodyBytes));
      final List results = data['results'];

      final List<Student> returnResult =
        results.map((data) {
          return Student(
            scode: data[0],
            sname: data[1],
            sdept: data[2],
            sphone: data[3],
            saddress: data[4] ?? '__'
          );
        }).toList();

        students.value = returnResult;

    }catch(e){
      // error = "불러오기 실패 : $e";
    }
  }


  Future<String> insertStudent(
    String code,
    String name,
    String dept,
    String phone,
    String address,
  )async{
    
    final uri = Uri.parse("$baseUrl/insert?code=$code&name=$name&dept=$dept&phone=$phone&address=$address");
    final res = await http.get(uri);
    final result = json.decode(utf8.decode(res.bodyBytes))['result'];
    return result;
  }


    Future<String> updateStudent(
      String code,
      String name,
      String dept,
      String phone,
      String address,
    )async{
    final uri = Uri.parse("$baseUrl/update?name=$name&dept=$dept&phone=$phone&address=$address&code=$code");
    final res = await http.get(uri);
    final result = json.decode(utf8.decode(res.bodyBytes))['result'];
    await fetchStudents();
    return result;
  }

    Future<String> deleteStudent(
      String code,
    ) async {
    final url = Uri.parse("$baseUrl/delete?code=$code");

    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        await fetchStudents(); 
        return "삭제 성공";
      } else {
        return "삭제 실패: ${res.statusCode}";
      }
    } catch (e) {
      return "오류 발생: $e";
    }
  }

}