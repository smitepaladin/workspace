import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buttons'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            TextButton(
              // onHover: , 커서가 있는 컴퓨터에서만 가능
              onLongPress: () => print("Long"),
              onPressed: () {
                // 함수를 적는 공간
                int intnum1 = 10;
                int intnum2 = 20;
                print("$intnum1 + $intnum2 = ${intnum1 + intnum2}");
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
                backgroundColor: Colors.black
              ),
              child: Text(
                'Text Button',
                style: TextStyle(
                  fontSize: 20
                ), // Button의 글자 모양
              ),
            ),

            ElevatedButton(
              onPressed: () => print("Elevated Buttons"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.yellow,
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
              child: Text('Elevated Buttons'),
              ),

              OutlinedButton(
                onPressed: () => print('Outlined Button'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.green,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                  ),
                  side: BorderSide(
                    color: Colors.black,
                    width: 2.0,
                  )
                ),
                child: Text('Outlined Button')
                ),

                TextButton.icon(
                  onPressed: () => print("text button icon"),
                  icon: Icon(
                    Icons.home,
                    size: 40,
                    color: Colors.red,
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black
                  ),
                  label: Text('Go to home'),
                  ),

                ElevatedButton.icon(
                  onPressed: () => print("text button icon"),
                  icon: Icon(
                    Icons.home,
                    size: 20,
                    color: Colors.white,
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                    minimumSize: Size(150,40),
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                    ),                    
                  ),
                  label: Text('Go to Home'),
                  ),

                  ElevatedButton.icon(
                  onPressed: () => print("text button icon"),
                  icon: Icon(
                    Icons.home,
                    size: 20,
                    color: Colors.black,
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    minimumSize: Size(150, 40),
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                    ),                    
                  ),
                  label: Text('Go to home'),
                  ),
          ],
        ),
      ),
    );
  }
}
