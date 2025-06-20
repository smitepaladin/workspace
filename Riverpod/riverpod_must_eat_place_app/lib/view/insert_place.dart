import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_must_eat_place_app/model/address.dart';
import 'package:riverpod_must_eat_place_app/vm/gps_handler.dart';
import 'package:riverpod_must_eat_place_app/vm/image_handler.dart';
import 'package:riverpod_must_eat_place_app/vm/vm_handler.dart';


class InsertPlace extends ConsumerWidget {
  InsertPlace({super.key}); // const삭제


  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final estimateController = TextEditingController();
  final latController = TextEditingController();
  final lngController = TextEditingController();
  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gpsState = ref.watch(gpsHandlerProvider);
    final imageState = ref.watch(imageHandlerProvider);
    final vmHandler = ref.watch(vmHandlerProvider.notifier);

    // 위치데이터가 비어있으면 위치를 요청한다.
    ref.read(gpsHandlerProvider.notifier).checkLocationPermission();

    latController.text = gpsState.latitude;
    lngController.text = gpsState.longitude;

    return Scaffold(
      appBar: AppBar(
        title: Text('맛집 추가'),
      ),
      body: gpsState.latitude.isEmpty
      ? Center(child: Text("GPS 데이터를 수입 중 입니다."))
      : Column(
        children: [
          _buildImagePicker(context, ref),
          _buildLatLngFields(),
          _buildTextField("이름", nameController),
          _buildTextField("전화", phoneController, keyboardType : TextInputType.phone),
          _buildTextField("평가", estimateController, maxLines : 3, maxLength : 50),
          ElevatedButton(
            onPressed: () => _insert(vmHandler, imageState.imageFile!),
            child: Text("입력"),
          )
        ],
      )
    );
  }//build
  // Widget //

  Widget _buildImagePicker(BuildContext context, WidgetRef ref){
    final imageModel = ref.read(imageHandlerProvider.notifier);
    final imageState = ref.watch(imageHandlerProvider);
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
          child: imageState.imageFile == null
          ? Center(child: Text('이미지를 선택해 주세요'))
          : Image.file(File(imageState.imageFile!.path))
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

  Future<void> _insert(VMHandler vmHandler, XFile imageFile)async{
    Uint8List imageBytes = await File(imageFile.path).readAsBytes();

    final address = Address(
      name: nameController.text.trim(),
      phone: phoneController.text.trim(),
      estimate: estimateController.text.trim(),
      lat: double.parse(latController.text),
      lng: double.parse(lngController.text),
      image: imageBytes
    );

    await vmHandler.insertAddress(address);

    Get.defaultDialog(
      title: "입력 완료",
      middleText: "맛집이 등록 되었습니다.",
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text("확인"),
        )
      ]
    ).then((_) => Get.back());
  }
}//class