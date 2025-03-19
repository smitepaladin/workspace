import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 175, 2),
      appBar: AppBar(
        title: Text('영웅 Card',
        style: TextStyle(
          fontWeight: FontWeight.bold
        ),),
        backgroundColor: const Color.fromARGB(255, 233, 90, 14),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(
                'images/Lee.jpg',
              ),
              radius: 60,
            ),
            Divider(height: 30, color: Colors.red, thickness: 1),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("성웅",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("이순신 장군",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold
                  )),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("전적",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("62전 62승",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  )),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10,0,0,0),
                  child: Icon(Icons.check_circle_outline),
                ),
                Row(
                  children: [
                    Text("  옥포해전"),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10,0,0,0),
                  child: Icon(Icons.check_circle_outline),
                ),
                Text("  사천포해전"),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10,0,0,0),
                  child: Icon(Icons.check_circle_outline),
                ),
                Text("  당포해전"),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10,0,0,0),
                  child: Icon(Icons.check_circle_outline),
                ),
                Text("  한산도대첩"),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10,0,0,0),
                  child: Icon(Icons.check_circle_outline),
                ),
                Text("  부산포해전"),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10,0,0,0),
                  child: Icon(Icons.check_circle_outline),
                ),
                Text("  명량해전"),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10,0,0,0),
                  child: Icon(Icons.check_circle_outline),
                ),
                Text("  노량해전"),
              ],
            ),
            CircleAvatar(
              backgroundImage: AssetImage(
                'images/turtle.gif',
              ),
              radius: 50,
            ),
          ],
        )
      )
    );
  }
}