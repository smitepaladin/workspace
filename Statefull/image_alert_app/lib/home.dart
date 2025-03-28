import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Property
  late String _lampImage; // Image File Name


  @override
  void initState() {
    super.initState();
    _lampImage = "images/lamp_on.png";





  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Alert를 이용한 메시지 출력',
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Image.asset(
                  _lampImage,
                  width: 300,
                  height: 400,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      onSwitch();
                    },
                  style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                  )
                                ),    
                    child: Text('켜기'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      offSwitch();
                    },
                  style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                  )
                                ),                      
                    child: Text('끄기'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }//build


  onSwitch(){
    if(_lampImage == "images/lamp_on.png"){
      _showOnWarning(context);
    }else{
      _showOn(context);
    }

    setState(() {});
  }

  _showOnWarning(BuildContext context){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context){
        return AlertDialog(
          title: Text('경고'),
          content: Text('현재 램프가 켜진 상태입니다.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // of(context) 를 통해서 바로 만든 context만 지우겠다
              child: Text('네. 알겠습니다.'),
            ),
          ],
        );
      },
    );
  }


  _showOn(BuildContext context){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context){
        return AlertDialog(
          title: Text('램프 켜기'),
          content: Text('램프를 켜시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                _lampImage = "images/lamp_on.png";
                setState(() {});
                Navigator.of(context).pop();
              },
              child: Text('네'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // of(context) 를 통해서 바로 만든 context만 지우겠다
              child: Text('아니오'),
            ),
          ],
        );
      },
    );
  }



  offSwitch(){
    if(_lampImage == "images/lamp_off.png"){
      _showOffWarning(context);
    }else{
      _showOff(context);
    }

    setState(() {});
  }


    _showOffWarning(BuildContext context){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context){
        return AlertDialog(
          title: Text('경고'),
          content: Text('현재 램프가 꺼진 상태입니다.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // of(context) 를 통해서 바로 만든 context만 지우겠다
              child: Text('네. 알겠습니다.'),
            ),
          ],
        );
      },
    );
  }

  _showOff(BuildContext context){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context){
        return AlertDialog(
          title: Text('램프 끄기'),
          content: Text('램프를 끄시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                _lampImage = "images/lamp_off.png";
                setState(() {});
                Navigator.of(context).pop();
              },
              child: Text('네'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // of(context) 를 통해서 바로 만든 context만 지우겠다
              child: Text('아니오'),
            ),
          ],
        );
      },
    );
  }

}//Class