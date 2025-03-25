import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drawer'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              //
            },
            icon: Icon(Icons.shopping_cart),
          ),
          IconButton(
            onPressed: () {
              //
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),

      body: Center(
        child: Text('Drawer'),
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('images/pikachu-1.jpg'),
              ),
              otherAccountsPictures: [
              CircleAvatar(
                backgroundImage: AssetImage('images/pikachu-2.jpg'),
              ),
              CircleAvatar(
                backgroundImage: AssetImage('images/pikachu-2.jpg'),
              ),
              ],
              accountName: Text('Pikachu'),
              accountEmail: Text('Pickachu@naver.com'),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                )
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home
              ),
              title: Text('Home'),
              onTap:() {
                print("Home");
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings
              ),
              title: Text('설정'),
              onTap:() {
                print("설정");
              },
            ),
            ListTile(
              leading: Icon(
                Icons.question_answer,
                color: Colors.red,
              ),
              title: Text('자주 묻는 질문'),
              onTap:() {
                print("자주 묻는 질문");
              },
            ),
          ],
        )
      )
    );
  }
}