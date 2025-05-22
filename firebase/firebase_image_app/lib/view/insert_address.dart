import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class InsertAddress extends StatefulWidget {
  const InsertAddress({super.key});

  @override
  State<InsertAddress> createState() => _InsertAddressState();
}

class _InsertAddressState extends State<InsertAddress> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController relationController = TextEditingController();

  XFile? imageFile;
  final ImagePicker picker = ImagePicker();
  File? imgFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("주소록 입력"),
        ),
        body: Center(
          child: Column(
            children: [
              _buildTextField(nameController, "이름을 입력하세요"),
              _buildTextField(phoneController, "전화번호를 입력하세요"),
              _buildTextField(addressController, "주소를 입력하세요"),
              _buildTextField(relationController, "관계를 입력하세요"),
              ElevatedButton(
                  onPressed: () => getImageFromGallery(ImageSource.gallery),
                  child: Text('Gallery')),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                color: Colors.grey,
                child: Center(
                  child: imageFile == null
                      ? Text("Image is not selected")
                      : Image.file(imgFile!),
                ),
              ),
              ElevatedButton(onPressed: insertAction, child: Text('입력')),
            ],
          ),
        ));
  } // build

  // --- Widgets ---
  _buildTextField(TextEditingController controller, String labelText) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: labelText),
      ),
    );
  }

  // --- Functions ---
  getImageFromGallery(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    imageFile = XFile(pickedFile!.path);
    imgFile = File(imageFile!.path);
    setState(() {});
  }

  insertAction() async {
    String name = nameController.text.trim();
    String phone = phoneController.text.trim();
    String address = addressController.text.trim();
    String relation = relationController.text.trim();
    String image = await preparingImage();

    FirebaseFirestore.instance.collection('students').add({
      "name": name,
      "phone": phone,
      "address": address,
      "relation": relation,
      "image": image,
    });
    _showDialog();
  }

  Future<String> preparingImage() async {
    final firebaseStorage = FirebaseStorage.instance
        .ref()
        .child('images')
        .child('${nameController.text}.png');

    // putFile → putData만 변경, 나머지 유지
    final bytes = await imageFile!.readAsBytes();
    await firebaseStorage.putData(bytes);

    String downloadURL = await firebaseStorage.getDownloadURL();
    return downloadURL;
  }

  _showDialog() {
    Get.defaultDialog(
        title: "입력 결과",
        middleText: "입력이 완료 되었습니다.",
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              Get.back();
            },
            child: Text("OK"),
          ),
        ]);
  }
}
