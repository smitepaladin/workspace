import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: Text(
          '영웅 Card'),
          backgroundColor: const Color.fromARGB(255, 215, 81, 14),
          foregroundColor: Colors.white,
          centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(
                'images/Lee.jpg',
              ),
              radius: 60,
            ),
            Row(
              children: [
                Text('성웅',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),),
              ],
            ),
            Row(
              children: [
                Text('이순신장군',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold
                ),),
              ],
            ),
            Row(
              children: [
                Text('전적'),
              ],
            ),
            Row(
              children: [
                Text('62전 62승'),
              ],
            ),
            Row(
              children: [
                Icon(Icons.check_circle_outline),
                Text('옥포해전'),
              ],
            ),
            Row(
              children: [
                Icon(Icons.check_circle_outline),
                Text('사천포해전'),
              ],
            ),
            Row(
              children: [
                Icon(Icons.check_circle_outline),
                Text('당포해전'),
              ],
            ),
            Row(
              children: [
                Icon(Icons.check_circle_outline),
                Text('한산도대첩'),
              ],
            ),
            Row(
              children: [
                Icon(Icons.check_circle_outline),
                Text('부산포해전'),
              ],
            ),
            Row(
              children: [
                Icon(Icons.check_circle_outline),
                Text('명랑해전'),
              ],
            ),
            Row(
              children: [
                Icon(Icons.check_circle_outline),
                Text('노량해전'),
              ],
            ),
                      CircleAvatar(
              backgroundImage: AssetImage(
                'images/turtle.gif',
              ),
              radius: 60,
            ),
          ],
        ),
      )
    );
  }
}