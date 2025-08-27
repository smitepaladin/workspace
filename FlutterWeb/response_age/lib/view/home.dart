import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // Property
  late TextEditingController ageController;
  late bool result;
  late int age;

  @override
  void initState() {
    super.initState();
    ageController = TextEditingController();
    result = false;
    age = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('주류 구매 가능'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("당신의 나이는 ?"),
                Flexible(
                  child: SizedBox(
                    height: 20,
                    width: 100,
                    child: TextField(
                      controller: ageController,
                      decoration: InputDecoration(
                        hintText: '나이를 입력 하세요',
                        border: InputBorder.none
                      ),
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => checkAge(),
                  child: Text('계산하기'),
                ),
              ],
            ),
            Visibility(
              visible: result,
              child: Column(
                children: [
                  age >= 19
                  ? Text('귀하의 나이는 $age세 이므로 주류 구매가 가능합니다.')
                  : Text('귀하의 나이는 $age세 이므로 주류 구매가 불가능합니다.')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }// build


  // -- fuctinos --

  checkAge(){
    age = int.parse(ageController.text);
    result = true;
    setState(() {});
  }


}// class