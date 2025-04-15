import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_17_app/model/message.dart';

class InsertList extends StatefulWidget {
  const InsertList({super.key});

  @override
  State<InsertList> createState() => _InsertListState();
}

class _InsertListState extends State<InsertList> {

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
                      addList();
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

  addList(){
    Message.workList = textEditingController.text;
    Message.imagePath = 'images/${imagePath[selectedItem]}';
    Message.action = true;
  }
}//class