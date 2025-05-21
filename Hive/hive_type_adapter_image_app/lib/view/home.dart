import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_type_adapter_image_app/view/insert_address.dart';
import 'package:hive_type_adapter_image_app/view/update_address.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Property

  Box addressBox = Hive.box('address');



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('주소록'),
        actions: [
          IconButton(
            onPressed: () => Get.to(InsertAddress()),
            icon: Icon(Icons.add_outlined),
          )
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: addressBox.listenable(), // 바뀌었는지 계속 체크하고 있다. 추가, 수정, 삭제되면 바로 받아온다. setstate가 필요없다.
        builder: (context, Box addressBox, widget) => addressBox.isEmpty
        ? Center(child: Text('Empty'),)
        : ListView.builder(
          itemCount: addressBox.length,
          itemBuilder: (context, index) {
            var addressData = addressBox.getAt(index);
            return Slidable(
              endActionPane: ActionPane(
                motion: BehindMotion(),
                children: [
                  SlidableAction(
                    backgroundColor: Colors.red,
                    icon: Icons.delete,
                    label: "Delete",
                    onPressed: (context) => selectDelete(index),
                  )
                ]
              ),
              child: GestureDetector(
                onTap: () {
                  Get.to(() => UpdateAddress(),
                  arguments: [
                    index,
                    addressData.name,
                    addressData.phone,
                    addressData.address,
                    addressData.relation,
                    addressData.image
                  ]
                  );
                },
                child: Card(
                  child: Row(
                    children: [
                      Image.memory(
                        addressData.image,
                        width: 100,
                      ),
                      Column(
                        children: [
                          Text('이름 : ${addressData.name}'),
                          Text('전화번호 : ${addressData.phone}')
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  } // build

  // functions

  selectDelete(int index){
    showCupertinoModalPopup(
      context: context,
      barrierDismissible: false,
      builder: (context) => CupertinoActionSheet(
        title: Text("경고"),
        message: Text("선택한 항목을 삭제 하시겠습니까?"),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              addressBox.deleteAt(index);
              Get.back();
            },
            child: Text("삭제"),
          )
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Get.back(),
          child: Text("Cancel"),
        ),
      ),
    );
  }
}//class