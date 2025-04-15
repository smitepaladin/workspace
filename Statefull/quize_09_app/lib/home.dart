import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  //Property

  late List<int> _dan;
  late int selectedItem;
  late TextEditingController _guguDan;
  late String result;



  @override
  void initState() {
    super.initState();
    _dan = List.generate(8, (index) => index + 2);
    // _dan = [
    //   2,
    //   3,
    //   4,
    //   5,
    //   6,
    //   7,
    //   8,
    //   9
    // ];
    selectedItem = 0;
    _guguDan = TextEditingController();
    result = "";
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_dan[selectedItem]}단'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              height: 250,
              child: CupertinoPicker( // Sized Box없으면 안 보인다.
                itemExtent: 50, // 바 크기
                scrollController: FixedExtentScrollController(initialItem: 0),
                onSelectedItemChanged: (value) {
                  selectedItem = value; // 선택한 번호가 selectedItem으로 들어간다.
                  _insertLines(selectedItem);
                  setState(() {});
                },
                children: List.generate(
                  8,
                  (index) => Center( // index는 for문의 i값과 같은 역할을 한다.
                    child: Text('${index+2}단')
                  ),
                ),
              ),
            ),
              Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: SizedBox(
                width: 200,
                child: CupertinoTextField(
                  controller: _guguDan,
                  maxLines: 10,
                  textAlign: TextAlign.left,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.inversePrimary),
                  readOnly: true,
                ),
              ),
            ),                   
          ],
        ),
      ),
    );
  }// build


  // functions //
  _insertLines(int selectedItem){
    _guguDan.text = "";
    for (int i = 1; i<=9; i++){
      _guguDan.text +=
        "${_dan[selectedItem]} X $i = ${(_dan[selectedItem] * i).toString()} \n";
    }
    setState(() {});
  }
  
}// Class