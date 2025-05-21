import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // property
  String result = "_____"; // 초기데이터가 있으니까 late안줘도 된다.
  late TextEditingController itemController;

  @override
  void initState() {
    super.initState();
    itemController = TextEditingController();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter with Python'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              result
            ),
            TextButton(
              onPressed: () => getJSONData(),
              child: Text('Connect'),
            ),
            TextField(
              controller: itemController,
            ),
            TextButton(
              onPressed: () => getJSONitemData(),
              child: Text('Connect2'),
            ),
          ],
        ),
      )
    );
  }//build

  // --- Fuctions ---
  getJSONData()async{
    var url = Uri.parse('http://127.0.0.1:8000'); // 브라우저에서 위에 쓰는 글자
    var response = await http.get(url);
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    result = dataConvertedJSON['message'];
    setState(() {});
  }

  getJSONitemData()async{
    var url = Uri.parse('http://127.0.0.1:8000/items/${itemController.text}'); // 브라우저에서 위에 쓰는 글자
    var response = await http.get(url);
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    result = dataConvertedJSON["item_id"].toString();
    setState(() {});
  }

}//Class