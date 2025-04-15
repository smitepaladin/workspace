import 'package:flutter/material.dart';
import 'package:rotation_different_screen_app/view/landscape_mode.dart';
import 'package:rotation_different_screen_app/view/portrait_mode.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}
// Home에서 landscape와 portrait를 판별한다.
class _HomeState extends State<Home> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rotation Screen'),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if(orientation == Orientation.portrait){ // Orientation.portrait 가 알아서 사용자의 상황을 알아낸다.
            return PortraitMode();
          }else{
            return LandscapeMode();
          }
        },
      ),
    );
  }
}