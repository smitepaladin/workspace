import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqlite_image_app/model/address.dart';
import 'package:sqlite_image_app/vm/database_handler.dart';

class UpdateAddress extends StatefulWidget {
  const UpdateAddress({super.key});

  @override
  State<UpdateAddress> createState() => _UpdateAddressState();
}

class _UpdateAddressState extends State<UpdateAddress> {
  late DatabaseHandler handler;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late TextEditingController relationController;

  XFile? imageFile;
  final ImagePicker picker = ImagePicker();

  var value = Get.arguments ?? ["", "", "", "", "", null];

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    relationController = TextEditingController();

    nameController.text = value[1];
    phoneController.text = value[2];
    addressController.text = value[3];
    relationController.text = value[4];

    if (value[5] != null) {
      imageFile = null;  // XFile은 null, value[5]는 이미지를 Uint8List로 가지고 있음
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('주소록 수정 및 삭제'),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: '이름을 입력하세요'),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: '전화번호를 입력하세요'),
            ),
            TextField(
              controller: addressController,
              decoration: InputDecoration(labelText: '주소를 입력하세요'),
            ),
            TextField(
              controller: relationController,
              decoration: InputDecoration(labelText: '관계를 입력하세요'),
            ),
            ElevatedButton(
              onPressed: () => getImageFromGallery(ImageSource.gallery),
              child: Text('Gallary'),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              color: Colors.grey,
              child: Center(
                child: imageFile == null
                    ? Image.memory(
                            value[5], fit: BoxFit.cover)
                    : Image.file(File(imageFile!.path), fit: BoxFit.cover),
              ),
            ),
            ElevatedButton(
              onPressed: () => updateAction(),
              child: Text('수정'),
            )
          ],
        ),
      ),
    );
  }

  // Function to pick image from gallery
  Future getImageFromGallery(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile == null) {
      return;
    } else {
      imageFile = pickedFile;
      setState(() {});
    }
  }

  updateAction() async {
    Uint8List getImage;

    // 이미지가 바뀌지 않으면 기존 이미지를 그대로 사용
    if (imageFile == null && value[5] != null) {
      getImage = value[5]; // 기존 이미지를 그대로 사용
    } else {
      // 새로운 이미지 선택 시 파일 경로에서 읽어오기
      File imageFile1 = File(imageFile!.path);
      getImage = await imageFile1.readAsBytes();
    }

    var addressUpdate = Address(
      id: value[0],
      name: nameController.text,
      phone: phoneController.text,
      address: addressController.text,
      relation: relationController.text,
      image: getImage,
    );

    int result = await handler.updateAddress(addressUpdate);
    if (result == 0) {
      errorSnackBar();
    } else {
      _showDialog();
    }
  }

  errorSnackBar() {
    Get.snackbar(
      "경고",
      "입력 중 문제가 발생했습니다",
      colorText: Theme.of(context).colorScheme.onError,
      backgroundColor: Theme.of(context).colorScheme.error,
    );
  }

  _showDialog() {
    Get.defaultDialog(
      title: '수정완료',
      middleText: '수정이 완료되었습니다.',
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      barrierDismissible: false,
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            Get.back();
          },
          child: Text('OK'),
        )
      ],
    );
  }
}
