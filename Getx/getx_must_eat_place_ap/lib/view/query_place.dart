import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:getx_must_eat_place_app/view/edit_place.dart';
import 'package:getx_must_eat_place_app/view/insert_place.dart';
import 'package:getx_must_eat_place_app/view/map_place.dart';
import 'package:getx_must_eat_place_app/vm/vm_handler_temp.dart';

class QueryPlace extends StatelessWidget {
  QueryPlace({super.key});
    final vmHandler = Get.find<VmHandlerTemp>();

  @override
  Widget build(BuildContext context) {
    vmHandler.queryAddress();

    return Scaffold(
      appBar: AppBar(
        title: Text('내가 경험한 맛집 리스트'),
        actions: [
          IconButton(
            onPressed: () async{
              await Get.to(()=> InsertPlace());
              vmHandler.queryAddress();
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: vmHandler.hasListeners
      ? Center(child: Text('등록된 자료가 없습니다.'),)
      : Obx( () {
        return ListView.builder(
          itemCount: vmHandler.addresses.length,
          itemBuilder: (context, index) {
            final address = vmHandler.addresses[index];
            return GestureDetector(
              onTap: () => Get.to(()=> MapPlace(), arguments: [address.lat, address.lng]),
              child: Slidable(
                startActionPane: ActionPane(
                  motion: BehindMotion(), 
                  children: [
                    SlidableAction(
                      onPressed: (context) async{
                        await Get.to(()=> EditPlace(), arguments: [
                          address.id,
                          address.name,
                          address.phone,
                          address.estimate,
                          address.lat,
                          address.lng,
                          address.image
                        ]);
                        vmHandler.queryAddress();
                      },
                      backgroundColor: Colors.greenAccent,
                      icon: Icons.edit,
                      label: '수정',
                    ),
                  ],
                ),
                endActionPane: ActionPane(
                  motion: BehindMotion(), 
                  children: [
                    SlidableAction(
                      backgroundColor: Colors.red,
                      icon: Icons.delete,
                      label: "삭제",
                      onPressed: (context) async{
                        int? idNum = address.id;
                        await vmHandler.deleteAddress(idNum!);
                      },
                    ),
                  ],
                ),
                child: Card(
                  child: Row(
                    children: [
                      Image.memory(address.image, width: 100, height: 80,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('명칭: ${address.name}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('전화번호 : ${address.phone}')
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }
    )
    );
  }
}