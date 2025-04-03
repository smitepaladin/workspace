import 'package:flutter/material.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  //Property

  late DateTime date; 
  late String selectDateText;


  @override
  void initState() {
    super.initState();
    date = DateTime.now(); // OS에서 시간을 받아온다.
    selectDateText = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Date Picker Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              // '현재 일자는 : ${date.toString()}'
              '현재 일자는 : ${date.year.toString()}-${date.month.toString().padLeft(2,'0')}-${date.day.toString().padLeft(2,'0')} 입니다.'
            ),
            ElevatedButton(
              onPressed: () => dispDatePicker(),
              child: Text('Date Picker'),
            ),
            Text(selectDateText)
          ],
        ),
      ),
    );
  }// build

  // = Fucntion = //


  dispDatePicker() async{ // 기본적으로 async
    // print(date.year);
    int firstYear = date.year - 1;
    int lastYear = firstYear + 5;
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: date, // 오늘날자를 첫화면에 보여줌
      firstDate: DateTime(firstYear),
      lastDate: DateTime(lastYear),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      locale: Locale('ko','KR'), // 메인에 localizationsDelegates 없이 사용 불가능
    );
    if(selectedDate != null){
      selectDateText = "선택하신 일자는 ${selectedDate.toString().substring(0,10)} 입니다.";
      setState(() {});
    }
  }

}//Class