import 'package:flutter/material.dart';
import 'dart:math';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Property
  late TextEditingController num1Controller;
  late TextEditingController num2Controller;
  late String firstLine;
  late String picName;



  @override
  void initState() {
    super.initState();
    num1Controller = TextEditingController();
    num2Controller = TextEditingController();    
    firstLine = "";
    picName = "bmi";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('BMI 계산기'),
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
                      labelText: '신장을 입력하세요 (단위 :cm)',
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
                    labelText: '체중을 입력하세요 (단위 :kg)',
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      bmiShow();
                    },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)
                    )
                  ),   
                    child: Text('BMI 계산'),
                  ),
                ),
                Text(firstLine),
                Image.asset(
                    'images/$picName.png',
                  ),
              ],
            ),
          ),
        )
      ),
    );
  }//build

  // -- function --


  bmiShow(){
  if(num1Controller.text.trim().isEmpty || num2Controller.text.trim().isEmpty){
    showSnackBar("내용을 입력해주세요.", Colors.red, 2);
  }else{

  int height = int.parse(num1Controller.text);
  int weight = int.parse(num2Controller.text);
  double bmi = weight / pow(height/100,2);
  String cat = "";


  if(weight / pow(height/100,2) >= 30){
    cat = "고도비만";
    picName = "obese";
  }else if(weight / pow(height/100,2) >= 25){
    cat = "비만";
    picName = "overweight";
  }else if(weight / pow(height/100,2) >= 23){
    cat = "과체중";
    picName = "risk";
  }else if(weight / pow(height/100,2) >= 18.5){
    cat = "정상체중";
    picName = "normal";
  }else{
    cat = "저체중";
    picName = "underweight";
  }

  firstLine = '귀하의 bmi 지수는 ${bmi.toStringAsFixed(1)}이고 $cat 입니다.';
  }

  setState(() {});
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