import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property
  late List<String> animalList;
  late List<Color> animalColor;
  late String selectedName;


  @override
  void initState() {
    super.initState();
    animalList = [
      'bee',
      'cat',
      'cow',
      'dog',
      'cat',
      'fox',
      'monkey',
      'pig',
      'wolf',
    ];
    animalColor = [
      Colors.yellow,
      Colors.yellow,
      Colors.yellow,
      Colors.yellow,
      Colors.yellow,
      Colors.yellow,
      Colors.yellow,
      Colors.yellow,
      Colors.yellow,
    ];

    selectedName  = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scroll & Builder Test'),
      ),
      body: Column(
        children: [
          Text('원하는 동물을 선택 하세요'),
          SizedBox( //Body를 Column으로 나누어사용할 때는 SizedBox나 Container로 감싸지 않으면 화면이 보이지도 않는다.
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: animalList.length,
              itemBuilder: (context,index) {
                return GestureDetector(
                  onTap: () => rebuildBorder(index), // 가지고 갈 때 인덱스값을 가져가야 누굴 선택했는지 안다.
                  child: Container(
                    height: 100,
                    width: 100,
                    padding: EdgeInsets.all(20), // Container와 이미지와의 간격, 하얀부분
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: animalColor[index],
                        width: 2 // 노란색부분
                      )
                    ),
                    child: Image.asset(
                      'images/${animalList[index]}.png'
                    ),
                  ),
                );
              },
            ),
          ),
          Text(selectedName),
        ],
      ),
    );
  }//Build

  // Functions //

  rebuildBorder(int index){
    for(int i = 0; i < animalList.length; i++){
      animalColor[i] = Colors.yellow;

    }
    animalColor[index] = Colors.red;
    selectedName = animalList[index];
    setState(() {});
  }

}// Class