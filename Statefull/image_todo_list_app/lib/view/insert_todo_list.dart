import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_todo_list_app/model/image_todo_list.dart';
import 'package:http/http.dart' as http;

class InsertTodoList extends StatefulWidget {
  const InsertTodoList({super.key});

  @override
  State<InsertTodoList> createState() => _InsertTodoListState();
}

class _InsertTodoListState extends State<InsertTodoList> {

  late TextEditingController textEditingController;
  late List<String> imagePath;
  late int selectedItem;


  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    imagePath = [
      'pencil.png',
      'clock.png',
      'cart.png'
    ];
    selectedItem = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add View'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
            Row(
              children: [
                Image.asset(
                  'images/${imagePath[selectedItem]}',
                  width: 150,
                ),
              SizedBox(
              width: 200,
              height: 100,
              child: CupertinoPicker( // Sized Box없으면 안 보인다.
                itemExtent: 50, // 바 크기
                scrollController: FixedExtentScrollController(initialItem: 0),
                onSelectedItemChanged: (value) {
                  selectedItem = value; // 선택한 번호가 selectedItem으로 들어간다.
                  setState(() {});
                },
                children: List.generate(
                  3,
                  (index) => Center( // index는 for문의 i값과 같은 역할을 한다.
                    child: Image.asset(
                      'images/${imagePath[index]}',
                      width: 50,
                    ),
                  )
                ),
              ),
            ),              
              ],
            ),
              TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  labelText: '목록을 입력하세요',
                ),
                keyboardType: TextInputType.text,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: () {
                    if(textEditingController.text.trim().isNotEmpty){
                      insertTodoList();
                    }
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }//build
  // -- functions --

  insertTodoList()async{
    try{
      final imagetodolist = ImageTodoList( // insertTodoList라는 객채로 받았다.
        contents: textEditingController.text,
        image: imagePath[selectedItem],
        insertdate: DateTime.now().toString()
      );


      
      final url = Uri.parse('http://127.0.0.1:8000/insert'); //Get방식이 아니라서.
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(imagetodolist.toJSON()),
      );


      final data = json.decode(utf8.decode(response.bodyBytes));
      final result = data['result'];


      if(result == "OK"){
        _showDialog();
      }else{
        errorSnackBar();
      }
    }catch(e){    
      errorSnackBar();
    }
  }

  _showDialog(){
    Get.defaultDialog(
      title: "입력 결과",
      middleText: "입력이 완료 되었습니다",
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      barrierDismissible: false,
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            Get.back();
          },
          child: Text('OK')
        )
      ]
    );
  }

  errorSnackBar(){
    Get.snackbar(
      'Error',
      '입력시 문제가 발생했습니다.',
      duration: Duration(seconds: 2)
    );
  }
}//class