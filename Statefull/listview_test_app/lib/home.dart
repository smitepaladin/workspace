import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // Property
  // late List<String> todoList;
  late List<int> todoList;

  @override
  void initState() {
    super.initState();
    todoList = [];
    addData(); // todoList에 값을넣는 함수
  }

  addData(){
    // todoList.add('James');
    // todoList.add('Cathy');
    // todoList.add('Martin');
    // todoList.add('유비');
    // todoList.add('관우');
    // todoList.add('장비');
    // todoList.add('피카츄');
    // todoList.add('라이츄');
    // todoList.add('파이리');
    // todoList.add('꼬부기');
    // todoList.add('조조');
    // todoList.add('여포');
    // todoList.add('동탁');


    for(int i = 1; i<1000; i++){
      todoList.add(i);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main View"),
      ),
      body: Center(
        child: ListView.builder( // 플로터에서 ListView는 자동으로 메모리를 재활용 해준다.
          itemCount: todoList.length, // 만들어낼 것이 몇개인가?
          itemBuilder: (context, index) { // Card가 만들어내면 index가 인덱스 번호 배치
            return SizedBox( // 카드에 height를 줄 수 없으므로 SizedBox로 감싸서 준다.
              height: 100,
              child: Card( // 자동적으로 스크롤 된다.
                color: Colors.amber,
                child: Center(
                  child: Text(
                    todoList[index].toString(), // 화면에 보이는것은 모두 String이기에 타입을 바꿔줘야한다.
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}