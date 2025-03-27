import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property 꼭 코멘트 달자
  late TextEditingController num1Controller; // 숫자 1 입력 (키보드는 숫자)
  late TextEditingController num2Controller; // 숫자 2 입력 (키보드는 숫자)
  late TextEditingController addController; // 덧셈 결과 (읽기 가능만 하자)
  late TextEditingController subController; // 뺄셈 결과 (읽기 가능만 하자)
  late TextEditingController mulController; // 곱셈 결과 (읽기 가능만 하자)
  late TextEditingController divController; // 나눗셈 결과 (읽기 가능만 하자)


  @override
  void initState() {
    super.initState();
    num1Controller = TextEditingController();
    num2Controller = TextEditingController();
    addController = TextEditingController();
    subController = TextEditingController();
    mulController = TextEditingController();
    divController = TextEditingController();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('간단한 계산기'),
      ),
      body: Column(
        children: [
          TextField(
            controller: num1Controller, // TextFiled는 controller만 잡아둬도 돌아간다.
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '첫번째 숫자를 입력하세요.'
            ),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: num2Controller, // TextFiled는 controller만 잡아둬도 돌아간다.
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '두번째 숫자를 입력하세요.'
            ),
            keyboardType: TextInputType.number,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  calcAction();
                },
                child: Text('계산하기'),
              ),
              ElevatedButton(
                onPressed: () {
                  removeAll();
                },
                child: Text('지우기'),
              ),
            ],
          ),
          TextField(
            controller: addController, // TextFiled는 controller만 잡아둬도 돌아간다.
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '덧셈결과'
            ),
            readOnly: true,
          ),
          TextField(
            controller: subController, // TextFiled는 controller만 잡아둬도 돌아간다.
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '뺄셈결과'
            ),
            readOnly: true,
          ),
          TextField(
            controller: mulController, // TextFiled는 controller만 잡아둬도 돌아간다.
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '곱셈결과'
            ),
            readOnly: true,
          ),
          TextField(
            controller: divController, // TextFiled는 controller만 잡아둬도 돌아간다.
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '나눗셈결과'
            ),
            readOnly: true,
          ),
        ],
      ),
    );
  } // build

  //-- Functions --//
  calcAction(){
    if(num1Controller.text.trim().isEmpty || num2Controller.text.trim().isEmpty){
      showSnackBar("내용을 입력해주세요.", Colors.red, 2);
    }else{
      calcResult();
    }

  }

  calcResult(){
    int num1 = int.parse(num1Controller.text);
    int num2 = int.parse(num2Controller.text);

    int addResult = num1 + num2;
    int subResult = num1 - num2;
    int mulResult = num1 * num2;
    
    addController.text = addResult.toString();
    subController.text = subResult.toString();
    mulController.text = mulResult.toString();

    // 나눗셈의 경우 분모가 0인 경우에는 계산이 불가
    if(num2 == 0){
      divController.text = "Impossible";
    }else{
      double divResult = num1 / num2;
      divController.text = divResult.toString();
    }
  }

  removeAll(){
    num1Controller.text = "";
    num2Controller.text = "";
    addController.text = "";
    subController.text = "";
    mulController.text = "";
    divController.text = "";

  }


    showSnackBar(String snackBarContents, Color backgroundColor, int time){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(snackBarContents),
        duration: Duration(seconds: time),
        backgroundColor: backgroundColor,
      ),
    );
  }



} // Class