import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_must_eat_place_app/model/address.dart';
import 'package:getx_must_eat_place_app/vm/vm_handler_temp.dart';
import 'package:image_picker/image_picker.dart';

class InsertPlace extends StatelessWidget {
  InsertPlace({super.key});

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final estimateController = TextEditingController();
  final latController = TextEditingController();
  final lngController = TextEditingController();
  final vmHandler = Get.find<VmHandlerTemp>();

  @override
  Widget build(BuildContext context) {
    vmHandler.checkLocationPermission();

    latController.text = vmHandler.latitude.value;
    lngController.text = vmHandler.longitude.value;

    return Scaffold(
      appBar: AppBar(
        title: Text("맛집 추가"),
      ),
      body: Obx(() => vmHandler.latitude.value.isEmpty
      ? Center(child: CircularProgressIndicator())
      : Column(
        children: [
          _buildImagePicker(context),
          _buildLatLngFields(),
          _buildTextField("이름", nameController),
          _buildTextField("전화", phoneController, keyboardType: TextInputType.phone),
          _buildTextField("평가", estimateController, maxLines: 3, maxLength: 50),
          ElevatedButton(
            onPressed: _insert, 
            child: Text('입력'),
          ),
        ],
      ),) 
    );
  } // build

  // --- Widgets ---
  Widget _buildImagePicker(BuildContext context){
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
          ? Center(child: Text('이미지를 선택해 주세요'),)
          : Image.file(File(image.path)),
        )
      ],
    );
  }

  Widget _buildLatLngFields(){
    latController.text = vmHandler.latitude.value;
    lngController.text = vmHandler.longitude.value;
    return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _coordField("위도", latController),
      _coordField("경도", lngController)
    ],
  );
  }

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
  Future<void> _insert() async{
    if(vmHandler.imageFile.value == null){
      Get.snackbar('오류', '이미지를 선택해 주세요');
      return;
    }

    final bytes = await File(vmHandler.imageFile.value!.path).readAsBytes();
    final address = Address(
      name: nameController.text.trim(), 
      phone: phoneController.text.trim(), 
      estimate: estimateController.text.trim(),
      lat: double.parse(latController.text), 
      lng: double.parse(lngController.text), 
      image: bytes
    );

    await vmHandler.insertAddress(address);

    Get.defaultDialog(
      title: "입력 완료",
      middleText: "맛집이 등록 되었습니다.",
      actions: [
        TextButton(
          onPressed: () => Get.back(), 
          child: Text('확인'),
        ),
      ]
    ).then((_) => Get.back());
  }
} // class