import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_image_app/model/address.dart';
import 'package:firebase_image_app/view/insert_address.dart';
import 'package:firebase_image_app/view/update_address.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('주소록 검색'),
        actions: [
          IconButton(
            onPressed: () => Get.to(() => InsertAddress()),
            icon: Icon(Icons.add_outlined),
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(  // firebase 제공
        stream: FirebaseFirestore.instance
                  .collection("students")
                  .orderBy("name")
                  .snapshots(),
        builder: (context, snapshot) {
          if(!snapshot.hasData){ // 데이터가 없으면
            return Center(child: CircularProgressIndicator()); // return이니까 else안써도 된다.아래로 안 흘러가니까
          }
          final documents = snapshot.data!.docs; // docs에 list로 들어있다. 파이어베이스에서 문서
          return ListView(
            children: documents.map((doc) => _buildItemWidget(doc)).toList(),
          );
        },
      ),
    );
  }//build


  // Widgets//
  Widget _buildItemWidget(DocumentSnapshot doc){
    final address = Address(
      name: doc['name'],
      phone: doc['phone'],
      address: doc['address'],
      relation: doc['relation'],
      image: doc['image']);

    return GestureDetector(
      onTap: () {
        Get.to(() => UpdateAddress(),
          arguments: [
            doc.id,
            doc['name'],
            doc['phone'],
            doc['address'],
            doc['relation'],
            doc['image']
          ]
        );
      },
      child: Slidable(
        endActionPane: ActionPane(
          motion: BehindMotion(),
          children: [
            SlidableAction(
              backgroundColor: Colors.red,
              icon: Icons.delete_forever,
              onPressed: (context) => deleteAction(doc.id, doc['name']),
            ),
          ],
        ),
        child: Card(
          child: ListTile(
            title: Row(
              children: [
                Image.network(// image를 주소값으로 가지고 있으니까.
                  address.image, 
                  width: 70,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("이름       : ${address.name}"),
                    Text("전화번호 : ${address.phone}")
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  // function //

  deleteAction(String id, String name)async{
    await FirebaseFirestore.instance
                  .collection('students')
                  .doc(id)
                  .delete();
    await FirebaseStorage.instance
                  .ref()
                  .child('images')
                  .child('${name}.png')
                  .delete();
  }

}//class