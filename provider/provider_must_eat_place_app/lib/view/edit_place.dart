import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:provider_must_eat_place_app/model/address.dart';
import 'package:provider_must_eat_place_app/vm/image_handler.dart';
import 'package:provider_must_eat_place_app/vm/vm_handler.dart';

class EditPlace extends StatelessWidget {
  EditPlace({super.key});

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final estimateController = TextEditingController();
  final latController = TextEditingController();
  final lngController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {

    final imageModel = context.watch<ImageModel>();
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
        title: Text('맛집 수정'),
      ),
      body: Column(
        children: [
          _buildImagePicker(context, originalImage),
          _buildLatLngFields(),
          _buildTextField("이름", nameController),
          _buildTextField("전화", phoneController, keyboardType : TextInputType.phone),
          _buildTextField("평가", estimateController, maxLines : 3, maxLength : 50),
          ElevatedButton(
            onPressed: () => _update(context, imageModel, id, originalImage),
            child: Text("수정"),
          )
        ],
      )
    );
  }//build
  // Widget //

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
              child: Text('갤러리'),
            ),
            ElevatedButton(
              onPressed: () => imageModel.getImageFromGallery(ImageSource.camera),
              child: Text('카메라'),
            ),
          ],
        ),
        Container(
          width: double.infinity, //최대크기
          height: 200,
          color: Colors.grey[300],
          child: image == null
          ? Image.memory(originalImage)
          : Image.file(File(image.path))
        )
      ],
    );

  }

  Widget _buildLatLngFields() => 
    Row(
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
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            maxLength: maxLength,
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(),
            ),
          ),
        );
  }


  // -- functions -- //

  Future<void> _update(BuildContext context, ImageModel imageModel, int id, Uint8List originalImage)async{
    final vmModel = context.read<VMMODEL>();

    Uint8List imageBytes = originalImage;

    if(imageModel.imageFile != null){
      imageBytes = await File(imageModel.imageFile!.path).readAsBytes();
    }

    final address = Address(
      id: id,
      name: nameController.text.trim(),
      phone: phoneController.text.trim(),
      estimate: estimateController.text.trim(),
      lat: double.parse(latController.text),
      lng: double.parse(lngController.text),
      image: imageBytes
    );

    if(imageModel.imageFile != null){
      await vmModel.updateAddressAll(address);
    }else{
      await vmModel.updateAddress(address);
    }

    Get.defaultDialog(
      title: "수정 완료",
      middleText: "수정이 완료 되었습니다.",
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text("확인"),
        )
      ]
    ).then((_) => Get.back());
  }
}//class