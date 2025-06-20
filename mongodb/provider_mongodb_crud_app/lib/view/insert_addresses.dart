import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:provider_mongodb_crud_app/model/address.dart';
import 'package:provider_mongodb_crud_app/vm/address_provider.dart';
import 'package:provider_mongodb_crud_app/vm/image_provider.dart';

class InsertAddresses extends StatelessWidget {
  InsertAddresses({super.key});

  final codeController = TextEditingController();
  final nameController = TextEditingController();
  final deptController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final imageModel = context.read<ImageModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text('주소록 입력'),
      ),
      body: Column(
        children: [
          _buildTextField("학번", codeController),
          _buildTextField("이름", nameController),
          _buildTextField("전공", deptController),
          _buildTextField("전화번호", phoneController),
          _buildImagePicker(context),
          ElevatedButton(
            onPressed: () => insert(context, imageModel),
            child: Text("입력"),
          ),
        ],
      )
    );
  }//build


  // Widget //

  Widget _buildTextField(String label, TextEditingController controller){
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder()
      ),
    );
  }

  Widget _buildImagePicker(BuildContext context){
    final imageModel = context.read<ImageModel>();
    final image = context.watch<ImageModel>().imageFile;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => imageModel.getImageFromGallery(ImageSource.gallery),
              child: Text("갤러리"),
            ),
            ElevatedButton(
              onPressed: () => imageModel.getImageFromGallery(ImageSource.camera),
              child: Text("카메라"),
            ),
          ],
        ),
        Container(
          width: double.infinity,
          height: 200,
          color: Colors.grey[300],
          child: image == null
            ? Center(child: Text("이미지를 선택해주세요"),)
            : Image.file(File(image.path)),
        )
      ],
    );
  }

  // functions //

  Future<void> insert(BuildContext context, ImageModel imageModel)async{
    final addressModel = context.read<AddressModel>();

    if(imageModel.imageFile == null){
      Get.snackbar("오류", "이미지를 선택해주세요");
      return;
    }

    final bytes = await File(imageModel.imageFile!.path).readAsBytes();
    String base64Image = base64Encode(bytes);

    final address = Address(
      code: codeController.text.trim(),
      name: nameController.text.trim(),
      dept: deptController.text.trim(),
      phone: phoneController.text.trim(),
      image: base64Image
    );

    await addressModel.insertAddress(address);

    Get.defaultDialog(
      title: "입력완료",
      middleText: "주소가 등록되었습니다.",
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text("확인"),
        )
      ]
    ).then((_) => Get.back());
  }

}//class