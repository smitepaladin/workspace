import 'package:flutter/material.dart';
import 'package:listview_todo_ex_app/model/message.dart';

class InsertList extends StatefulWidget {
  const InsertList({super.key});

  @override
  State<InsertList> createState() => _InsertListState();
}

class _InsertListState extends State<InsertList> {

  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add View'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('구매'),
                  Switch(
                    value: Message.switchBuy,
                    onChanged: (value) {
                      Message.switchBuy = value;
                      addViewSwitchBuy();
                    },
                  ),
                  Image.asset(
                    'images/cart.png',
                    height: 30,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('약속'),
                  Switch(
                    value: Message.switchPromise,
                    onChanged: (value) {
                      Message.switchPromise = value;
                      addViewSwitchPromise();
                    },
                  ),
                  Image.asset(
                    'images/clock.png',
                    height: 30,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('스터디'),
                  Switch(
                    value: Message.switchStudy,
                    onChanged: (value) {
                      Message.switchStudy = value;
                      addViewSwitchStudy();
                    },
                  ),
                  Image.asset(
                    'images/pencil.png',
                    height: 30,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                    labelText: '목록을 입력하세요',
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)
                    )
                  ),
                  onPressed: () {
                    if(textEditingController.text.trim().isNotEmpty){
                      addList();
                    }
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }//build
  // -- functions --


  addViewSwitchBuy(){
    if(Message.switchBuy == true){
      Message.switchPromise = false;
      Message.switchStudy = false;
      Message.imagePath = 'images/cart.png';
      setState(() {});
    }    
  }
  addViewSwitchPromise(){
    if(Message.switchPromise == true){
      Message.switchBuy = false;
      Message.switchStudy = false;
      Message.imagePath = 'images/clock.png';
      setState(() {});
    }    
  }
  addViewSwitchStudy(){
    if(Message.switchStudy == true){
      Message.switchBuy = false;
      Message.switchPromise = false;
      Message.imagePath = 'images/pencil.png';
      setState(() {});
    }    
  }





  addList(){
    Message.workList = textEditingController.text;
    Message.imagePath;
    Message.action = true;

  
  }


}//class