import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:json_movie_github_silder_app/view/edit.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List data;


  @override
  void initState() {
    super.initState();
    data = [];
    getJSONData();
  }


  getJSONData()async{
    var url = Uri.parse('https://zeushahn.github.io/Test/movies.json');
    var response = await http.get(url); // import 'package:http/http.dart' as http; 추가
    // print(response.body); // 여기가 첫번째 단계. 들어온 데이터 확인. --1로 표현하자.
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    List result = dataConvertedJSON['results'];
    data.addAll(result);
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('JSON & Slider Test'),
        ),
        body: Center(
            child: data.isEmpty
            ? Text('Data를 받고 있는 중입니다.')
            : ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Slidable(
                  startActionPane: ActionPane(
                    motion: BehindMotion(),
                    children: [
                      SlidableAction(
                        backgroundColor: Colors.green,
                        icon: Icons.edit,
                        label: 'Edit',
                        onPressed: (context) {
                          Get.to(
                            Edit(),
                            arguments: [
                              data[index]['image'],
                              data[index]['title'],
                            ]
                          )!.then((value) => rebuildData(index, value),); // ListBuilder에서 빠져나오면 여기 정보는 하나도 모른다. 그래서 index와 value값을 넘겨줘야 한다.
                        },
                      )
                    ],
                  ),
                  endActionPane: ActionPane(
                    motion: BehindMotion(),
                    children: [
                      SlidableAction(
                        backgroundColor: Colors.red,
                        icon: Icons.delete,
                        label: 'Delete',
                        onPressed: (context) {
                          selectDelete(index);
                        },
                      )
                    ],
                  ),
                  child: Card(
                    color: index % 2 == 0
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.tertiary,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            data[index]['image'],
                            width: 100,
                          ),
                        ),
                        Text(
                          "     ${data[index]['title']}",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ), // --2 카드  출력 확인
                  ),
                );
              },
            )
            ,
        ),
    );
  }//build


  // functions //

  selectDelete(index){
    showCupertinoModalPopup(
      context: context,
      barrierDismissible: false,
      builder: (context) => CupertinoActionSheet(
        title: Text('경고'),
        message: Text('선택한 항목을 삭제 하시겠습니까?'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              data.removeAt(index);
              setState(() {});
              Get.back(); // Dialog없애기
            },
            child: Text('삭제'),
          )
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Get.back(),
          child: Text('Cancle'),
        ),
      ),
    );
  }

  rebuildData(int index, String str){ // index는 숫자일거고, value값(str)은 문자열일테니
    if(str.isNotEmpty){
      data[index]['title'] = str;
      setState(() {});
    }
  }

}// Class