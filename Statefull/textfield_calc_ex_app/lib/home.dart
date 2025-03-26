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
                TextField(
                  controller: addController,
                  decoration: InputDecoration(
                    labelText: '덧셈 결과',
                  ),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: subController,
                  decoration: InputDecoration(
                    labelText: '뺄셈 결과',
                  ),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: mulController,
                  decoration: InputDecoration(
                    labelText: '곱셈 결과',
                  ),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: divController,
                  decoration: InputDecoration(
                    labelText: '나눗셈 결과',
                  ),
                  keyboardType: TextInputType.number,
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
      calcadd();
      calcsub();
      calcmul();
      calcdiv();
    }

    setState(() {});
  }

  calcadd(){
      int num1 = int.parse(num1Controller.text);
      int num2 = int.parse(num2Controller.text);
      int sum = num1 + num2;
      addController.text = "$sum";
      
  }

  calcsub(){
      int num1 = int.parse(num1Controller.text);
      int num2 = int.parse(num2Controller.text);
      int sub = num1 - num2;
      subController.text = "$sub";
    
  }

  calcmul(){
      int num1 = int.parse(num1Controller.text);
      int num2 = int.parse(num2Controller.text);
      int mul = num1 * num2;
      mulController.text = "$mul";
    
  }

  calcdiv(){
      double num1 = double.parse(num1Controller.text);
      double num2 = double.parse(num2Controller.text);
      double div = num1 / num2;
      divController.text = "$div";
    
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