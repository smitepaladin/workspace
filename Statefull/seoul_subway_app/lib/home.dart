import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Property
  late List data;
  late TextEditingController textEditingController;
  late int page;
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    data = [];
    textEditingController = TextEditingController();
    page = 1;
    scrollController = ScrollController();

    scrollController.addListener(() {
      // 리스트의 마지막일 경우
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        page++;
        getJSONData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Column(
          children: [
            Text('Seoul Subway'),
            Row(
              children: [
                SizedBox(
                  width: 300,
                  child: TextField(controller: textEditingController),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (textEditingController.text.trim().isNotEmpty) {
                // 1. 처음 한 번 바로 불러오기
                data.clear();
                page = 1;
                getJSONData();

                // 2. 이후 10초마다 자동 새로고침
                Timer.periodic(Duration(seconds: 10), (timer) {
                  data.clear();
                  page = 1;
                  getJSONData();
                });
              }
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Center(
        child:
            data.isEmpty
                ? Text('데이터가 없습니다.', style: TextStyle(fontSize: 20))
                : ListView.builder(
                  controller: scrollController,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color:
                          index % 2 == 0
                              ? Theme.of(context).colorScheme.secondaryContainer
                              : Theme.of(context).colorScheme.tertiaryContainer,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('열차 구분 : ${data[index]['updnLine']}'),
                          Text('열차 방면 : ${data[index]['trainLineNm']}'),
                          Text('현재 위치 : ${data[index]['arvlMsg3']}'),
                          Text('도착 시간 : ${data[index]['arvlMsg2']}'),
                        ],
                      ),
                    );
                  },
                ),
      ),
    );
  } // build

  getJSONData() async {
    var url = Uri.parse(
      'http://swopenapi.seoul.go.kr/api/subway/6d41624f7263616e35364a51567344/json/realtimeStationArrival/1/5/${textEditingController.text}',
    );
    var response = await http.get(url);
    // print(response.body); // --1
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    //print(dataConvertedJSON);
    List result = dataConvertedJSON['realtimeArrivalList'];
    // print(result);
    data.addAll(result);
    setState(() {});
  }
}//Class