import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:json_movie_github_app/detail.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Property

  late List data;
  final box = GetStorage();


  @override
  void initState() {
    super.initState();
    data = [];
    getJSONData();
    initStorage();
  }


  getJSONData()async{
    var url = Uri.parse('https://zeushahn.github.io/Test/movies.json'); // 데이터 다운로드, 타입이 뭐가 들어올지 모르니까 var타입, 주소는 URL, URL에는 이미 URI가 구성되어 있다. URI는 보내는 사람 받는사람 주소. url은 보내는 사람 받는 사람이 셋팅된 주소.
    var response = await http.get(url); // http를 이용해서 가져온다.
    // print(response.body); // 데이터 가져온것 확인
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes)); // decode가 중괄호를 벗겨주고 result부터 받아온다.
    List result = dataConvertedJSON['results']; // Map형식이 되었다.
    // print(result);
    data.addAll(result); // 리스트 전체에 확 넣어준다.
    setState(() {}); // 늦게 가져왔을 수도 있으니 화면에 반영해주기
  } 


  initStorage(){
    box.write('image', "");
    box.write('title', "");
  }

  @override
  void dispose() {
    disposeStorage(); // 앱 종료할 때 지우기
    super.dispose();
  }

  disposeStorage(){
    box.erase();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('JSON Test'),// Dart는 JSON을 모른다. 그래서 리스트로 바꿔줘야한다.
      ),
      body: Center(
      child: data.isEmpty
      ? CircularProgressIndicator()
      : ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
            return SizedBox(
              height: 150,
              child: GestureDetector(
                onTap: () {
                  saveStorage(index);
                  Get.to(Detail()); // 화면 이동
                },
                child: Card(
                    color: index % 2 == 0
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.tertiary
                    ,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          data[index]['image'],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(data[index]['title'],
                        style: TextStyle(
                          color: Colors.white
                        ),),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }// build

  // functions///

  saveStorage(index){
    box.write('image', data[index]['image']);
    box.write('title', data[index]['title']);
  }
}// Class