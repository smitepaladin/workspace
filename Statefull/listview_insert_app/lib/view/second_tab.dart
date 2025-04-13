import 'package:flutter/material.dart';
import 'package:listview_insert_app/model/animal.dart';

class SecondTab extends StatefulWidget {
  final List<Animal> list; // Home과 연결
  const SecondTab({super.key, required this.list}); // Home과 연결

  @override
  State<SecondTab> createState() => _SecondTabState();
}

class _SecondTabState extends State<SecondTab> {
  late TextEditingController nameController; // 동물이름
  late int radioValue; // Radio Button
  late bool flyAble; // check Box
  late String imagePath; // 이미지 선택
  late String imageName; // 이미지 이름

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    radioValue = 0;
    flyAble = false;
    imagePath = "";
    imageName = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: '동물이름을 입력하세요'),
              keyboardType: TextInputType.text,
              maxLines: 1, // 한줄이상 못쓴다.
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  value: 0,
                  groupValue: radioValue,
                  onChanged: (value) => radioChange(value), // value값이 ? 상태이다
                ),
                Text('양서류'),

                Radio(
                  value: 1,
                  groupValue: radioValue,
                  onChanged: (value) => radioChange(value), // value값이 ? 상태이다
                ),
                Text('파충류'),

                Radio(
                  value: 2,
                  groupValue: radioValue, // radioValue는 groupValue가 알고있다.
                  onChanged: (value) => radioChange(value), // value값이 ? 상태이다
                ),
                Text('포유류'),
              ],
            ),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceAround, // 간격을 주변에 똑같게 맞춰준다.
              children: [
                Text('날 수 있나요?'),
                Checkbox(
                  value: flyAble,
                  onChanged: (value) {
                    flyAble = value!;
                    setState(() {});
                  },
                ),
              ],
            ),
            SizedBox( // ListView 크기를 제한하기 위해 SizeBox를 씌운다.
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  GestureDetector( // 그림 클릭하면 선택하기 위해 제스처디텍터
                    onTap: () {
                      imagePath = 'images/cow.png';
                      imageName = "젖소";
                      setState(() {});
                    },
                    child: Image.asset('images/cow.png', width: 80),
                  ),

                  GestureDetector(
                    onTap: () {
                      imagePath = 'images/pig.png';
                      imageName = "돼지";
                      setState(() {});
                    },
                    child: Image.asset('images/pig.png', width: 80),
                  ),

                  GestureDetector(
                    onTap: () {
                      imagePath = 'images/bee.png';
                      imageName = "벌";
                      setState(() {});
                    },
                    child: Image.asset('images/bee.png', width: 80),
                  ),

                  GestureDetector(
                    onTap: () {
                      imagePath = 'images/fox.png';
                      imageName = "여우";
                      setState(() {});
                    },
                    child: Image.asset('images/fox.png', width: 80),
                  ),

                  GestureDetector(
                    onTap: () {
                      imagePath = 'images/cat.png';
                      imageName = "고양이";
                      setState(() {});
                    },
                    child: Image.asset('images/cat.png', width: 80),
                  ),

                  GestureDetector(
                    onTap: () {
                      imagePath = 'images/wolf.png';
                      imageName = "늑대";
                      setState(() {});
                    },
                    child: Image.asset('images/wolf.png', width: 80),
                  ),

                  GestureDetector(
                    onTap: () {
                      imagePath = 'images/monkey.png';
                      imageName = "원숭이";
                      setState(() {});
                    },
                    child: Image.asset('images/monkey.png', width: 80),
                  ),
                  GestureDetector(
                    onTap: () {
                      imagePath = 'images/dog.png';
                      imageName = "개";
                      setState(() {});
                    },
                    child: Image.asset('images/dog.png', width: 80),
                  ),
                ],
              ),
            ),
            Text(imageName),
            ElevatedButton(
              onPressed: () => _showDialog(),
              child: Text('동물 추가히기'),
            ),
          ],
        ),
      ),
    );
  } //build

  // == functions ==

  radioChange(int? value) {
    // value값이 위에서 ? 상태여서 ? 로 받았다
    radioValue = value!; // !는 ? 를 해제한다
    setState(() {});
  }

  _showDialog() {
    var animal = Animal(
      imagePath: imagePath,
      animalName: nameController.text,
      order: getOrder(radioValue),
      flyAble: flyAble,
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            '동물 추가하기',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: Text(
            '이 동물은 ${animal.animalName} 입니다. \n'
            '또 동물의 종류는 ${animal.order} 입니다. \n'
            '이 동물은 ${animal.flyAble ? "날 수 있습니다" : "날 수 없습니다"} \n'
            '이 동물을 추가 하시겠습니까?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                widget.list.add(animal);
                Navigator.of(context).pop();
              },
              child: Text('예'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('아니오'),
            ),
          ],
        );
      },
    );
  }

  String getOrder(int radioValue) {
    String returnValue = "";
    switch (radioValue) {
      case 0:
        returnValue = "양서류";
      case 1:
        returnValue = "파충류";
      case 2:
        returnValue = "포유류";
    }
    return returnValue;
  }
}
