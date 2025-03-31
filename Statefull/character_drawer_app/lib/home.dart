import 'dart:async';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Property
  late List str;
  late int currentPage;
  late String character;
  late TextEditingController num1Controller;
  



  @override
  void initState() {
    super.initState();
    num1Controller = TextEditingController();
    character = "";
    str = [];
    currentPage = 0;

  } // initState




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LED 광고',
        style: TextStyle(
          fontWeight: FontWeight.bold
        ),),
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              character,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('광고문구를 입력하세요'),
              accountEmail: Text(''),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                )
              ),
            ),
            TextField(
              controller: num1Controller,
              decoration: InputDecoration(
                labelText: '글자를 입력하세요',
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                )                 
              ),
              keyboardType: TextInputType.text,
            ),
            ElevatedButton(
              onPressed:() {
                buttonAction();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                )
              ),
              child: Text('광고문구 생성'),
              ),
          ],
        )
      )      
    );
  }// Build

  buttonAction(){
    character = num1Controller.text;
    str = character.split('');
    Timer.periodic(Duration(seconds: 1), (timer){
    changePage();
    });

  }



    changePage(){


    
    currentPage++;

    if(currentPage >= str.length && character != ''){
      currentPage = 0;
      character = str[currentPage];
    }else{
      character += str[currentPage];
    }

    setState(() {});
  }

}// Class