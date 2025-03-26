import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late bool buttonCheck;
  late Color buttonColor;
  
  @override
  void initState() {
    super.initState();
    buttonCheck = false;
    buttonColor = Colors.blue;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Changed Button color on Switch'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
            onPressed:() {
              changeColor();
            } ,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                )
              ),               
                child: Text('Flutter'),
            ),
            Switch(
              value: buttonCheck,
                onChanged: (value) {
                buttonCheck = value;
                changeSwitch();
              },
        ),
          ],
        ),
      ),
    );
  }//build

  // --Function-- //

  changeSwitch(){
    (buttonCheck == true)
    ?(
    buttonCheck = true,
    buttonColor = Colors.red
    )
  : (
    buttonCheck = false,
    buttonColor = Colors.blue
    );
    setState(() {});
  }

  changeColor(){
    (buttonCheck == false)
    ?(
    buttonCheck = true,
    buttonColor = Colors.red
    )
  : (
    buttonCheck = false,
    buttonColor = Colors.blue
    );
    setState(() {});
  }


}//Class