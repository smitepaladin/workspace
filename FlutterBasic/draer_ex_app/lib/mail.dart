import 'package:flutter/material.dart';

class Mail extends StatelessWidget {
  const Mail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text('Navigator_Appbar',
          style: TextStyle(
          fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () => sendFunction(context),
            icon: Icon(Icons.email),
            color: Colors.white,
          ),
          IconButton(
            onPressed: () => receiveFunction(context),
            icon: Icon(Icons.email_outlined),
            color: Colors.white,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => sendFunction(context),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                )
              ),
              child: Text('보낸편지함'),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
              child: ElevatedButton(
                onPressed: () => receiveFunction(context),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                )
              ),
                child: Text('받은편지함'),
                ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('images/pikachu-1.jpg'),
              ),
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
                Icons.email,
                color: Colors.blue,
              ),
              title: Text('보낸편지함'),
              onTap:() => sendFunction(context),
            ),
            ListTile(
              leading: Icon(
                Icons.email_outlined,
                color: Colors.red,
              ),
              title: Text('받은편지함'),
              onTap:() => receiveFunction(context),
            ),
          ],
        )
      )
    );
  } // build

  /// ---- Functions ---- ///


  sendFunction(BuildContext context){
    Navigator.pushNamed(context, '/send');
  }

  receiveFunction(BuildContext context){
    Navigator.pushNamed(context, '/receive');
  }

  // mailFunction(BuildContext, String part){
  //   if(part == 'send'){
  //     Navigator.pushNamed(context, '/send');
  //   }else{
  //     Navigator.pushNamed(context, '/receive');
  //   }
  // }

}