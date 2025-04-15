import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Property

  late List<String> items;
  late String dropDownValue;
  late String imageName;

  @override
  void initState() {
    super.initState();
    items = ['Apple','Banana','Grape','Orange','Watermelon','Pineapple'];
    dropDownValue = items[0];
    imageName = 'Apple';
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drop Down Button'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton(
              dropdownColor: Colors.amber, // 드랍다운 메뉴 전체 바탕 색
              iconEnabledColor: Colors.green, // 화살표시 아이콘 색
              value: dropDownValue,
              icon: Icon(Icons.keyboard_arrow_down),
              items: items.map((String items){
                return DropdownMenuItem(
                  value: items,
                  child: Text(
                    items,
                    style: TextStyle(
                      color: Colors.red
                    ),
                  ),
                );
              }).toList(), // DropdownMenuItem의 items는 Map type으로만 받을 수 있다.
              onChanged: (value) {
                dropDownValue = value!;
                imageName = value;
                setState(() {});
              },
            ),
            Image.asset(
              'images/$imageName.png',
              width: 200,
            ),
          ],
        ),
      ),
    );
  }
}