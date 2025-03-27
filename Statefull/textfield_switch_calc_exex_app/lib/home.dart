import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Property

  late TextEditingController num1Controller;
  late TextEditingController num2Controller;
  late TextEditingController addController;
  late TextEditingController subController;
  late TextEditingController mulController;
  late TextEditingController divController;
  late bool addSwitch;
  late bool subSwitch;
  late bool mulSwitch;
  late bool divSwitch;




  @override
  void initState() {
    super.initState();
    num1Controller = TextEditingController();
    num2Controller = TextEditingController();
    addController = TextEditingController();
    subController = TextEditingController();
    mulController = TextEditingController();
    divController = TextEditingController();
    addSwitch = true;
    subSwitch = true;
    mulSwitch = true;
    divSwitch = true;

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('간단한 계산기'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,5,0,10),
                  child: TextField(
                    controller: num1Controller,
                    decoration: InputDecoration(
                      labelText: '첫번재 숫자를 입력 하세요',
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      )                  
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                TextField(
                  controller: num2Controller,
                  decoration: InputDecoration(
                    labelText: '두번재 숫자를 입력 하세요',
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    )                  
                  ),
                  keyboardType: TextInputType.number,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          calcCheck();
                        },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)
                        )
                      ),   
                        child: Text('계산 하기'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          erase();
                        },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)
                        )
                      ),                       
                        child: Text('지우기'),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('덧셈'),
                    Switch(
                      value: addSwitch,
                        onChanged: (value) {
                        addSwitch = value;
                        changeSwitch();
                        },
                    ),
                    Text('뺄셈'),
                    Switch(
                      value: subSwitch,
                        onChanged: (value) {
                        subSwitch = value;
                        changeSwitch();
                        },
                    ),
                    Text('곱셈'),
                    Switch(
                      value: mulSwitch,
                        onChanged: (value) {
                        mulSwitch = value;
                        changeSwitch();
                        },
                    ),
                    Text('나눗셈'),
                    Switch(
                      value: divSwitch,
                        onChanged: (value) {
                        divSwitch = value;
                        changeSwitch();
                        },
                    ),
                  ],
                ),
                TextField(
                  controller: addController,
                  decoration: InputDecoration(
                    labelText: '덧셈 결과',
                  ),
                  readOnly: true,
                ),
                TextField(
                  controller: subController,
                  decoration: InputDecoration(
                    labelText: '뺄셈 결과',
                  ),
                  readOnly: true,
                ),
                TextField(
                  controller: mulController,
                  decoration: InputDecoration(
                    labelText: '곱셈 결과',
                  ),
                  readOnly: true,
                ),
                TextField(
                  controller: divController,
                  decoration: InputDecoration(
                    labelText: '나눗셈 결과',
                  ),
                  readOnly: true,
                ),
              ],
            ),
          ),
        )
      ),
    );
  }//build

  // -- function --





  calcCheck(){
    if(num1Controller.text.trim().isEmpty || num2Controller.text.trim().isEmpty){
      showSnackBar("내용을 입력해주세요.", Colors.red, 2);
    }else{
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

    setState(() {});
  }


    changeSwitch(){
    if(addSwitch == false){
      addController.text = "";
    }else if(subSwitch == false){
      subController.text = "";
    }else if(mulSwitch == false){
      mulController.text == "";
    }else if(divSwitch == false){
      divController.text == "";
    }else{
      calcCheck();
    }
    setState(() {});
  }



  erase(){
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


}// Class