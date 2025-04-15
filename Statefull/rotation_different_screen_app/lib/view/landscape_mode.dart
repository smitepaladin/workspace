import 'package:flutter/material.dart';

class LandscapeMode extends StatefulWidget {
  const LandscapeMode({super.key});

  @override
  State<LandscapeMode> createState() => _LandscapeModeState();
}

class _LandscapeModeState extends State<LandscapeMode> {
  //Property

  late String portButtonText;
  late Color portColor;
  late bool swichValue;

  @override
  void initState() {
    super.initState();
    portButtonText = "Hello";
    portColor = Colors.blue;
    swichValue = false;
  }
 // Home에서 이미 Scaffold가 만들어져 있다. 그러니 여기서는 쓰지 않는다. Stack로 덮어씌운다.
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  if(portColor == Colors.blue){
                    portButtonText = 'Flutter';
                    portColor = Colors.red;
                    swichValue = true;
                  }else{
                    portButtonText = 'Hello';
                    portColor = Colors.blue;
                    swichValue = false;
                  }
                  setState(() {});
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: portColor,
                  foregroundColor: Colors.black
                ),
                child: Text(portButtonText),
              ),
              Switch(
                value: swichValue,
                onChanged: (value) {
                  swichValue = value;
                  portButtonText = 
                  swichValue == true
                  ? 'Flutter'
                  : 'Hello';
                  portColor =
                  swichValue == true
                  ? Colors.red
                  : Colors.blue;
                  setState(() {});
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}