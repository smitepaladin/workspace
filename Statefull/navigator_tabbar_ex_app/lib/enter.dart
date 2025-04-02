import 'package:flutter/material.dart';

class Enter extends StatefulWidget {
  const Enter({super.key});

  @override
  State<Enter> createState() => _EnterState();
}

class _EnterState extends State<Enter> {

  late TextEditingController idController;
  late TextEditingController pwController;



  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    pwController = TextEditingController();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log in'),
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset(
              'images/login.png'
            ),

            TextField(
              controller: idController,
              decoration: InputDecoration(
                labelText: '사용자 ID를 입력하세요'
              ),
              keyboardType: TextInputType.text,
              maxLines: 1,
            ),

            TextField(
              controller: pwController,
              decoration: InputDecoration(
                labelText: '패스워드를 입력하세요',
              ),
              obscureText: true,
              keyboardType: TextInputType.text,
              maxLines: 1,
            ),
            ElevatedButton(
              onPressed: () => loginCheck(),
              child: Text('Log in')
            )
          ],
        ),
      ),
    );
  }// build

  /// == functions == ///
  

  loginCheck(){
    if(idController.text == "Admin" && pwController.text == "1234"){
      _showDialog();
    }else{
      Navigator.pushNamed(context, '/');
    }
  }

  _showDialog(){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context){
        return AlertDialog(
          title: Text('환영 합니다!'),
          content: Text('신분이 확인되었습니다.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/1st'),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

}//Class