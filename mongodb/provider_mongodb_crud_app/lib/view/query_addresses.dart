import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:provider_mongodb_crud_app/view/insert_addresses.dart';
import 'package:provider_mongodb_crud_app/view/update_addresses.dart';
import 'package:provider_mongodb_crud_app/vm/address_provider.dart';
import 'package:provider_mongodb_crud_app/vm/image_provider.dart';


class QueryAddresses extends StatelessWidget {
  const QueryAddresses({super.key});

  @override
  Widget build(BuildContext context) {
    final addressModel = context.watch<AddressModel>();
    final imageModel = context.watch<ImageModel>();
    final addresses = addressModel.addresses;

    return Scaffold(
      appBar: AppBar(
        title: Text('주소록 검색'),
        actions: [
          IconButton(
            onPressed: () {
              imageModel.clearImage();
              Get.to(() => InsertAddresses());
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: addressModel.isLoading
        ? Center(child: CircularProgressIndicator())
        : addresses.isEmpty
          ? Center(child: Text('주소정보가 없습니다.'))
          : ListView.builder(
            itemCount: addresses.length,
            itemBuilder: (context, index) {
              final address = addresses[index];
              Uint8List? imageBytes = address.image.isNotEmpty
                ? base64Decode(address.image)
                : null;
              return Slidable(
                endActionPane: ActionPane(
                  motion: ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) async{
                        await addressModel.deleteAddress(address.code);
                      },
                      backgroundColor: Colors.red,
                      icon: Icons.delete,
                      label : "삭제"
                    )
                  ],
                ),
                child: GestureDetector(
                  onTap: () {
                    imageModel.clearImage();
                    Get.to(() => UpdateAddresses(),
                    arguments: [
                      address.code,
                      address.name,
                      address.dept,
                      address.phone,
                      address.image,
                    ]);
                  },
                  child: Card(
                    child: Row(
                      children: [
                        imageBytes != null
                        ? Image.memory(
                          imageBytes,
                          width: 100,
                          height: 100,
                        )
                        : Icon(Icons.image_not_supported, size: 100,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("이름    : ${address.name}"),
                            Text("전화번호 : ${address.phone}"),
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