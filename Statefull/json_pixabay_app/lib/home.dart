import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:json_pixabay_app/second.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  //Property
  late List data;
  late TextEditingController textEditingController;

  


  @override
  void initState() {
    super.initState();
    data = [];
    textEditingController = TextEditingController();







  }


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Column(
          children: [
            Text('PixaBay Images 검색'),
            Row(
              children: [
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: textEditingController,
                  ),
                ),
                
              ],
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              if(textEditingController.text.trim().isNotEmpty){
              data.clear();
              getJSONData();  
              }else{
                errorSnackBar();
              }
            },
            icon: Icon(Icons.search)
          )
        ],
        
        
      ),
      body: GridView.builder(
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10, // 한줄 당 cell끼리의 간격
          mainAxisSpacing: 10, // 한줄과 다음줄과의 간격        
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Get.to(() => const Second(), arguments: [data[index], textEditingController.text]),
            child: Card(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: Image.network(
                            data[index],
                            width: 180,
                            height: 180,
                          ),
                        ),
                      ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  } // build


    getJSONData()async{
    var url = Uri.parse('https://pixabay.com/api/?key=49770210-ba2802d9fb2b21437ff8ed796&q=${textEditingController.text}&image_type=photo');
    var response = await http.get(url);
    // print(response.body); // --1
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    // print(dataConvertedJSON);
    List result = dataConvertedJSON['hits'];
    data.clear();
    for(int i=0; i < result.length; i++){
      data.add(result[i]['webformatURL']);
    }
    // print(result);
    setState(() {});

  }

    errorSnackBar() {
    Get.snackbar(
      '경고',
      '검색어를 입력하세요',
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 2),
      colorText: Colors.white,
      backgroundColor: Colors.red,
    );
  }

}//Class