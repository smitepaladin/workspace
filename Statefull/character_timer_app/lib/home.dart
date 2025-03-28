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
  



  @override
  void initState() {
    super.initState();
    String data = "대한민국";
    str = data.split(''); // data에서 한글자씩 자른다. ['대','한','민','국']
    currentPage = 0;
    character = str[currentPage];
    

    Timer.periodic(Duration(seconds: 1), (timer){
      changePage();
    });


  } // initState

  changePage(){
    currentPage++;
    if(currentPage >= str.length){
      currentPage = 0;
      character = str[currentPage];
    }else{
      character += str[currentPage];
    }

    setState(() {});
  }



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
    );
  }
}