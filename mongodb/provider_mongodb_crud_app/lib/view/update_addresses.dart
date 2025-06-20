import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:provider_mongodb_crud_app/model/address.dart';
import 'package:provider_mongodb_crud_app/vm/address_provider.dart';
import 'package:provider_mongodb_crud_app/vm/image_provider.dart';

class UpdateAddresses extends StatelessWidget {
  UpdateAddresses({super.key});
  final codeController = TextEditingController();
  final nameController = TextEditingController();
  final deptController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments ?? "__";
    codeController.text = args[0];
    nameController.text = args[1];
    deptController.text = args[2];
    phoneController.text = args[3];
    Uint8List originalImage = base64Decode(args[4]);

    final imageModel = context.read<ImageModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text("주소록 수정"),
      ),
      body: Column(
        children: [
          _buildTextField("학번", codeController, readOnly:true),
          _buildTextField("이름", nameController),
          _buildTextField("전화번호", phoneController),
          _buildTextField("전공", deptController),
          _buildImagePicker(context, originalImage),
          ElevatedButton(
            onPressed: () => update(context, imageModel, originalImage), 
            child: Text("수정"),
          ),
        ],
      ),
    );
  } // build

  // --- Widgets ---
  Widget _buildTextField(String label, TextEditingController controller, {bool readOnly = false}){
    return TextField(
      controller: controller,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder()
      ),
    );
  }

  Widget _buildImagePicker(BuildContext context, Uint8List originalImage){
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
            ? Image.memory(originalImage)
            : Image.file(File(image.path)),
        )
      ],
    );
  }

  // --- Functions ---
  Future<void> update(BuildContext context, ImageModel imageModel, Uint8List originalImage)async{
    final addressModel = context.read<AddressModel>();
    Uint8List imagesBytes = originalImage;
    bool checkGallery = false;

    if(imageModel.imageFile != null){
      imagesBytes = await File(imageModel.imageFile!.path).readAsBytes();
      checkGallery = true;
    }

    String base64Image = base64Encode(imagesBytes);

    final address = Address(
      code: codeController.text.trim(), 
      name: nameController.text.trim(), 
      dept: deptController.text.trim(), 
      phone: phoneController.text.trim(), 
      image: base64Image);

    if(checkGallery == false){
      await addressModel.updateAddress(address);
    }else{
      await addressModel.updateAddressAll(address);
    }

    Get.defaultDialog(
      title: "수정 완료",
      middleText: "주소가 수정 되었습니다.",
      actions: [
        TextButton(
          onPressed: () => Get.back(), 
          child: Text("확인"),
        )
      ]
    ).then((_) => Get.back(),);
  }


} // class