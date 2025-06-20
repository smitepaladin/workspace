import 'dart:async';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_crud_app/model/student.dart';

class StudentNotifier extends AsyncNotifier<List<Student>>{

  @override
  Future<List<Student>> build() async {
    return await fetchStudents();
  }
  final String baseUrl = "http://127.0.0.1:8000";

  Future<List<Student>> fetchStudents()async{
    final res = await http.get(Uri.parse("$baseUrl/select"));
    final data = json.decode(utf8.decode(res.bodyBytes));
    final List<Student> result = 
      (data['results'] as List).map((data) => Student.fromJson(data)).toList();
    return result;
  }

  Future<void> refreshStudent()async{
    state = AsyncLoading();
    state = await AsyncValue.guard(() async => await fetchStudents());
  } // 데이터가 있는지 없는지 체크

  Future<String> insertStudent(Student s)async{
    final uri = Uri.parse("$baseUrl/insert?code=${s.scode}&name=${s.sname}&dept=${s.sdept}&phone=${s.sphone}&address=${s.saddress}");
    final res = await http.get(uri);
    final result = json.decode(utf8.decode(res.bodyBytes))['result'];
    return result;
  } // when을 쓰기 때문에 fetch를 할 필요가 없다.


    Future<String> updateStudent(Student s)async{
    final uri = Uri.parse("$baseUrl/update?name=${s.sname}&dept=${s.sdept}&phone=${s.sphone}&address=${s.saddress}&code=${s.scode}");
    final res = await http.get(uri);
    final result = json.decode(utf8.decode(res.bodyBytes))['result'];
    await fetchStudents();
    return result;
  }

    Future<String> deleteStudent(String scode) async {
    final url = Uri.parse("$baseUrl/delete?code=$scode");

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

final studentProvider = AsyncNotifierProvider<StudentNotifier, List<Student>>(
  () => StudentNotifier(),
);