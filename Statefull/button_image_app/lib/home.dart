import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property(Field, Attribute) 바뀌는 것을 정한다.
  late double size;

  
  @override
  void initState() {
    super.initState();
    size = 60;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Image Size'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(
                'images/pikachu-1.jpg',
              ),
              radius: size,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _onClickPlus(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: Text("Plus"),
                ),
                ElevatedButton(
                  onPressed: () => _onClickMinus(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: Text("Minus"),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }  // build

  // ---- function ----
  _onClickPlus(){
    size += 10;
    setState(() {}); // build는 변수가 바뀐것을 알지 못하니 property의 값을 알려줘야한다.
  }
  _onClickMinus(){
    size -= 10;
    setState(() {}); // build는 변수가 바뀐것을 알지 못하니 property의 값을 알려줘야한다.
  }



} // Class