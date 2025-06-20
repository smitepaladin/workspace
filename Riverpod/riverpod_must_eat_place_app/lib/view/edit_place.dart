import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_must_eat_place_app/model/address.dart';
import 'package:riverpod_must_eat_place_app/vm/image_handler.dart';
import 'package:riverpod_must_eat_place_app/vm/vm_handler.dart';

class EditPlace extends ConsumerWidget {
  EditPlace({super.key});

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final estimateController = TextEditingController();
  final latController = TextEditingController();
  final lngController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vmHandler = ref.watch(vmHandlerProvider.notifier);
    final args = Get.arguments ?? "__";

    final int id = args[0];
    nameController.text = args[1];
    phoneController.text = args[2];
    estimateController.text = args[3];
    latController.text = args[4].toString();
    lngController.text = args[5].toString();
    Uint8List originalImage = args[6];

    return Scaffold(
      appBar: AppBar(title: Text('맛집 수정')),
      body: Column(
        children: [
          _buildImagePicker(context, originalImage, ref),
          _buildLatLngFields(),
          _buildTextField("이름", nameController),
          _buildTextField(
            "전화",
            phoneController,
            keyboardType: TextInputType.phone,
          ),
          _buildTextField("평가", estimateController, maxLines: 3, maxLength: 50),
          ElevatedButton(
            onPressed:
                () => _update(vmHandler, ref, id, originalImage),
            child: Text("수정"),
          ),
        ],
      ),
    );
  } //build
  // Widget //

  Widget _buildImagePicker(
    BuildContext context,
    Uint8List originalImage,
    WidgetRef ref,
  ) {
    final imageModel = ref.read(imageHandlerProvider.notifier);
    final imageState = ref.watch(imageHandlerProvider);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed:
                  () => imageModel.getImageFromGallery(ImageSource.gallery),
              child: Text('갤러리'),
            ),
            ElevatedButton(
              onPressed:
                  () => imageModel.getImageFromGallery(ImageSource.camera),
              child: Text('카메라'),
            ),
          ],
        ),
        Container(
          width: double.infinity, //최대크기
          height: 200,
          color: Colors.grey[300],
          child:
              imageState.imageFile == null
                  ? Image.memory(originalImage)
                  : Image.file(File(imageState.imageFile!.path)),
        ),
      ],
    );
  }

  Widget _buildLatLngFields() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _coordField("위도", latController),
      _coordField("경도", lngController),
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

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    TextInputType? keyboardType,
    int maxLines = 1,
    int? maxLength,
  }) {
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

  Future<void> _update(
    VMHandler vmHandler,
    WidgetRef ref,
    int id,
    Uint8List originalImage,
  ) async {
    // 선택된 이미지가 null이 아닌 경우 새 이미지로 바이트 읽기
    final imageState = ref.watch(imageHandlerProvider);
    Uint8List imageBytes = originalImage;
    if (imageState.imageFile != null) {
      imageBytes = await File(imageState.imageFile!.path).readAsBytes();
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

    // 이미지 변경 여부에 따라 분기
    if (imageState.imageFile != null) {
      await vmHandler.updateAddressAll(address);
    } else {
      await vmHandler.updateAddress(address);
    }

    Get.defaultDialog(
      title: "수정 완료",
      middleText: "수정이 완료 되었습니다.",
      actions: [TextButton(onPressed: () => Get.back(), child: Text("확인"))],
    ).then((_) => Get.back());
  }
}//class