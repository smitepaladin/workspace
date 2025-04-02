import 'package:flutter/material.dart';
import 'package:listview_insert_app/model/animal.dart';

class FirstTab extends StatefulWidget {
  // Property
  final List<Animal> list; // Home과 연결시킨다.
  const FirstTab({super.key, required this.list}); // Home과 연결시키기 위해 list추가

  @override
  State<FirstTab> createState() => _FirstTabState();
}

class _FirstTabState extends State<FirstTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: widget.list.length, //내 위에 있는 Class의 데이터를 가져오는 Class widget
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => _showDialog(index),// 터치한 index를 가져가야한다.
              child: Card(
                child: Row(
                  children: [
                    Image.asset(
                      widget.list[index].imagePath,
                      width: 50,
                    ),
                    Text(
                      "    ${widget.list[index].animalName}"
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }//Build

  // ==Functions== //

  _showDialog(int index){ //index는 정수값이니까
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(
            widget.list[index].animalName,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
          content: Row(
            children: [
              Image.asset(
                widget.list[index].imagePath,
                width: 50,
              ),
              Text(
                '     이 동물은 ${widget.list[index].order} 입니다.\n'
                '     ${widget.list[index].flyAble ? "날 수 있습니다.":"날 수 없습니다"}'
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('종료')
            ),
          ],
        );
      },
    );
  }
}//Class