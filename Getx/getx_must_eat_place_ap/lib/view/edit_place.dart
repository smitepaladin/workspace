import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getx_must_eat_place_app/model/address.dart';
import 'package:getx_must_eat_place_app/vm/vm_handler_temp.dart';
import 'package:image_picker/image_picker.dart';

class EditPlace extends StatelessWidget {
  EditPlace({super.key});

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final estimateController = TextEditingController();
  final latController = TextEditingController();
  final lngController = TextEditingController();
  final vmHandler = Get.find<VmHandlerTemp>();
  
  @override
  Widget build(BuildContext context) {
    final args = Get.arguments ?? "__";

    final int id = args[0];
    nameController.text = args[1];
    phoneController.text = args[2];
    estimateController.text = args[3];
    latController.text = args[4].toString();
    lngController.text = args[5].toString();
    Uint8List originalImage = args[6];


    return Scaffold(
      appBar: AppBar(
        title: Text("맛집 수정"),
      ),
      body: Obx(() {
      return Column(
        children: [
          _buildImagePicker(context, originalImage),
          _buildLatLngFields(),
          _buildTextField("이름", nameController),
          _buildTextField("전화", phoneController, keyboardType: TextInputType.phone),
          _buildTextField("평가", estimateController, maxLines: 3, maxLength: 50),
          ElevatedButton(
            onPressed: () => _update(context, vmHandler, id, originalImage), 
            child: Text('입력'),
          ),
        ],
      );
      },) 
    );
  } // build

  // --- Widgets ---
  Widget _buildImagePicker(BuildContext context, Uint8List originalImage){
    final image = vmHandler.imageFile.value;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () =>  vmHandler.getImageFromGallery(ImageSource.gallery), 
              child: Text("갤러리"),
            ),
            ElevatedButton(
              onPressed: () =>  vmHandler.getImageFromGallery(ImageSource.camera), 
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

  Widget _buildLatLngFields() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _coordField("위도", latController),
      _coordField("경도", lngController)
    ],
  );

  Widget _coordField(String label, TextEditingController controller) =>
    SizedBox(
      width: 150,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
        readOnly: true,
      ),
    );

  Widget _buildTextField(String label, TextEditingController controller,
          {TextInputType? keyboardType, int maxLines = 1, int? maxLength}){
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      maxLength: maxLength,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }


  // --- Functions ---
  Future<void> _update(BuildContext context, VmHandlerTemp vmHandler, int id, Uint8List originalImage) async{

    Uint8List imageBytes = originalImage;

    if(vmHandler.imageFile.value != null){
      imageBytes = await File(vmHandler.imageFile.value!.path).readAsBytes();
    }

    final address = Address(
      id: id,
      name: nameController.text.trim(), 
      phone: phoneController.text.trim(), 
      estimate: estimateController.text.trim(),
      lat: double.parse(latController.text), 
      lng: double.parse(lngController.text), 
      image: imageBytes,
    );

    if(vmHandler.imageFile.value != null){
      await vmHandler.updateAddressAll(address);
    }else{
      await vmHandler.updateAddress(address);
    }

    // await vmModel.insertAddress(address);

    Get.defaultDialog(
      title: "수정 완료",
      middleText: "맛집이 수정 되었습니다.",
      actions: [
        TextButton(
          onPressed: () => Get.back(), 
          child: Text('확인'),
        ),
      ]
    ).then((_) => Get.back());
  }
} // class