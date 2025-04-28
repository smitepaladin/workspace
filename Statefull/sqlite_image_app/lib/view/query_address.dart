import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqlite_image_app/view/insert_address.dart';
import 'package:sqlite_image_app/view/update_address.dart';
import 'package:sqlite_image_app/vm/database_handler.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_picker/image_picker.dart';

class QueryAddress extends StatefulWidget {
  const QueryAddress({super.key});

  @override
  State<QueryAddress> createState() => _QueryAddressState();
}

class _QueryAddressState extends State<QueryAddress> {
  //Property

  late DatabaseHandler handler;
  XFile? imageFile;
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('주소록 검색'),
        actions: [
          IconButton(
            onPressed: () => Get.to(InsertAddress())!.then((value) => reloadData()),
            icon: Icon(Icons.add_outlined),
          ),
        ],
      ),
      body: FutureBuilder(
        future: handler.queryAddress(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(
                      UpdateAddress(),
                      arguments: [
                        snapshot.data![index].id,
                        snapshot.data![index].name,
                        snapshot.data![index].phone,
                        snapshot.data![index].address,
                        snapshot.data![index].relation,
                        snapshot.data![index].image,
                      ],
                    )!.then((value) => reloadData());
                  },
                  child: Slidable(
                    endActionPane: ActionPane(
                      motion: BehindMotion(),
                      children: [
                        SlidableAction(
                          backgroundColor: Colors.red,
                          icon: Icons.delete,
                          label: '삭제',
                          onPressed: (context) async {
                            await handler.deleteAddress(
                              snapshot.data![index].id!,
                            );
                            snapshot.data!.remove(snapshot.data![index]);
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    child: Card(
                      child: Row(
                        children: [
                          Image.memory(
                            snapshot.data![index].image,
                            fit: BoxFit.cover,
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text('이름 : '),
                                  Text(snapshot.data![index].name)
                                ],
                              ),
                              Row(
                                children: [
                                  Text('전화번호 : '),
                                  Text(snapshot.data![index].phone)
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              // snapshot에 데이터 없으면 로딩 출력
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  reloadData() {
    handler.queryAddress();
    setState(() {});
  }
}
