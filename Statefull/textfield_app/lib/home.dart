import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //property
  late TextEditingController textEditingController;


  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController(); // 구글에서 클라스로 제공한다. 생성자를 생성했다.
  }



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:() => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Single Textfield'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  labelText: '내용을 입력하세요',
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  )
                ),
                keyboardType: TextInputType.text,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: () => checkData(),
                  child: Text('출력'),
                ),
              )
            ],
          ),
        )
      ),
    );
  }//build

// --Functions-- //

  checkData(){
    if(textEditingController.text.trim().isEmpty){
    // Error Message
    showSnackBar("내용을 입력해주세요.", Colors.red, 2);


  }else{
    showSnackBar("입력하신 내용은 ${textEditingController.text}", Colors.blue, 3);
    // Display
  }
  }

  // errorSnackBar(){
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text("내용을 입력하세요!"),
  //       duration: Duration(seconds: 2),
  //       backgroundColor: Colors.red,
  //     ),
  //   );
  // }

  showSnackBar(String snackBarContents, Color backgroundColor, int time){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(snackBarContents),
        duration: Duration(seconds: time),
        backgroundColor: backgroundColor,
      ),
    );
  }


}//Class