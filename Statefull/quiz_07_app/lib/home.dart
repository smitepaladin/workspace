import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // Property

  late String currentDateTime; // 현재시간
  late String currentTimeForAlarm;
  late String chosenDateTime1;
  DateTime? chosenDateTime;    // 선택시간 , 선택전에는(=초기값) null이므로 null safety를 사용
  late bool isRunning;         // Timer
  late Color color;


  @override
  void initState() {
    super.initState();
    currentDateTime = "";
    chosenDateTime1 = "";
    isRunning = true;
    color = Colors.white;
    Timer.periodic(Duration(seconds: 1), (timer) { // import 'dart:async';가 뜨는지 확인

      if(!isRunning){ // Timer는 async가 기본이라서, addItem이 작동하기 전에 이미 build로 body를 그려놓은 상태라 null값이 뜨게 된다. 그래서 setState를 해줘야한다.
        timer.cancel(); // 타이머가 움직이지 않으면 타이머를 죽여준다.
      }
      addItem(); // 현재시간을 만들어 줄 함수

    },
    );
  }




  addItem(){
    final DateTime now = DateTime.now(); // final 안 쓰면 now데이터 값을 바꿀 수 있게 되므로 조심해야한다.final을 쓰면 한번 들어가면 못 바꾼다.
    String year = now.year.toString();
    String month = now.month.toString().padLeft(2,'0');
    String day = now.day.toString().padLeft(2,'0');
    int weekday = now.weekday;
    String hour = now.hour.toString();
    String min = now.minute.toString();
    String seconds = now.second.toString().padLeft(2,'0');
    currentDateTime = "$year-$month-$day ${weekdayToString(weekday)} $hour:$min:$seconds";
    currentTimeForAlarm = "$year-$month-$day ${weekdayToString(weekday)} $hour:$min";
    if(currentTimeForAlarm == chosenDateTime1){
      if(DateTime.now().second % 2 == 0){
        color = Colors.red;
      }else{
        color = Colors.amber;
      }
    }else{
      color = Colors.white;
    }

    setState(() {});
    
  }





  String weekdayToString(int weekday){
    String dateName = "";
    switch(weekday){
      case 1:
      dateName = "월";
      case 2:
      dateName = "화";
      case 3:
      dateName = "수";
      case 4:
      dateName = "목";
      case 5:
      dateName = "금";
      case 6:
      dateName = "토";
      case 7:
      dateName = "일";
    }
    return dateName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        title: Text('알람 정하기'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '현재 시간 : $currentDateTime',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 300,
              height: 200,
              child: CupertinoDatePicker( // sized box로 감싸지 않으면 나오지 않는다.
                initialDateTime: DateTime.now(),
                use24hFormat: false,
                onDateTimeChanged: (value) {
                  chosenDateTime = value;
                  setState(() {});
                },
              ),
            ),
            Text(
              '선택시간 : ${chosenDateTime != null ? chosenItem(chosenDateTime!) : '시간을 선택 하세요!'}', // chosenDateTime을 nullsafety로 받았기 때문에 !로 써야한다.
                style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  } // build


  // functions//

  String chosenItem(DateTime now){
    String year = now.year.toString();
    String month = now.month.toString().padLeft(2,'0');
    String day = now.day.toString().padLeft(2,'0');
    int weekday = now.weekday;
    String hour = now.hour.toString();
    String min = now.minute.toString();
    chosenDateTime1 = "$year-$month-$day ${weekdayToString(weekday)} $hour:$min"; 
    return chosenDateTime1;
  }



} // Class