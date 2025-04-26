import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

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


    scrollController.addListener((){
     // 리스트의 마지막일 경우
      if(scrollController.offset >= scrollController.position.maxScrollExtent && !scrollController.position.outOfRange){
        page++;
        getJSONData();
      }
  });
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: textEditingController,
        ),
      ),
      body: Center(
        child: data.isEmpty
        ? Text(
          '데이터가 없습니다.',
          style: TextStyle(fontSize: 20),
        )
        : ListView.builder(
          controller: scrollController,
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Card(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: 
                    data[index]['thumbnail'].isEmpty
                    ? Text('이미지가 \n없습니다.')
                    : 
                    Image.network(
                      data[index]['thumbnail'],
                      width: 100,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        data[index]['title'].length < 12
                        ? Text(
                          data[index]['title'],
                        )
                        : Text(
                          data[index]['title'].replaceRange(
                            12,
                            data[index]['title'].length,
                            '...'
                          )
                        ),

                        data[index]['authors'].toString().length < 12
                        ? Text(
                          data[index]['authors'].toString(),
                        )
                        : Text(
                          data[index]['authors'].toString().replaceRange(
                            12,
                            data[index]['authors'].toString().length,
                            '...'
                          )
                        ),


                        Text(
                          data[index]['price'].toString(),
                        ),
                        Text(
                          data[index]['status']
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(textEditingController.text.trim().isNotEmpty){
            data.clear();
            page = 1;
            getJSONData();
          }
        },
        child: Icon(Icons.file_download),
      ),
    );
  }// build


  // functions //

  getJSONData()async{
    var url = Uri.parse('https://dapi.kakao.com/v3/search/book?target=title&page=$page&query=${textEditingController.text}');
    var response = await http.get(url, headers: {"Authorization" : "KakaoAK eb71a887d20a94f7c693311e95bf407b"});
    // print(response.body); // --1
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    List result = dataConvertedJSON['documents'];
    data.addAll(result);
    setState(() {});

  }


}//Class