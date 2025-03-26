import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Property
  late bool switchValue; // 스위치 ON, OFF값
  late String appBarTitle; // 앱바 타이틀
  late String imageName; // 이미지 파일명

  @override
  void initState() {
    super.initState();
    switchValue = true;
    appBarTitle = "피카츄";
    imageName = "pikachu-1.jpg";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appBarTitle)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Image.asset(
                'images/$imageName',
                width: 200,
                height: 200,
                ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Switch(
                value: switchValue,
                onChanged: (value) {
                  switchValue = value;
                  onSwich();
                },
              ),
            ),
          ],
        ),
        
      ),
    );
  } // build

  // --funciton--

  onSwich() {
    if(switchValue == true){
      appBarTitle = "피카츄";
      imageName = "pikachu-1.jpg";
    }else{
    appBarTitle = "스마일";
    imageName = "smile.png";
    }
    setState(() {});
  }
}//Class