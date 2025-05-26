import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:provider_must_eat_place_app/view/edit_place.dart';
import 'package:provider_must_eat_place_app/view/insert_place.dart';
import 'package:provider_must_eat_place_app/view/map_place.dart';
import 'package:provider_must_eat_place_app/vm/image_handler.dart';
import 'package:provider_must_eat_place_app/vm/vm_handler.dart';

class QueryPlace extends StatelessWidget {
  const QueryPlace({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<VMMODEL>();
    final addressList = vm.address;

    return Scaffold(
      appBar: AppBar(
        title: Text("내가 경험한 맛집 리스트"),
        actions: [
          IconButton(
            onPressed: () {
              context.read<ImageModel>().clearImage(); // read는 실행개념이라 watch와 관련이 없다.
              Get.to(() => InsertPlace())!.then((_) => vm.loadAddress());
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: addressList.isEmpty
      ? Center(child: Text('등록된 자료가 없습니다.'))
      : ListView.builder(
        itemCount: addressList.length,
        itemBuilder: (context, index) {
          final address = addressList[index];
          return GestureDetector(
            onTap: () => Get.to(() => MapPlace(), arguments: [address.lat, address.lng]),
            child: Slidable(
              startActionPane: ActionPane(
                motion: BehindMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      Get.to(() => EditPlace(), arguments: [
                        address.id,
                        address.name,
                        address.phone,
                        address.estimate,
                        address.lat,
                        address.lng,
                        address.image
                        ]
                      )!.then((_) => vm.loadAddress());
                    },
                    backgroundColor: Colors.green,
                    icon: Icons.edit,
                    label: "수정",
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
                      await context.read<VMMODEL>().deleteAddress(address.id!);
                    },
                  )
                ]
              ),
              child: Card(
                child: Row(
                  children: [
                    Image.memory(address.image, width: 100, height: 80),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('명칭: ${address.name}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("전화번호 : ${address.phone}")
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}