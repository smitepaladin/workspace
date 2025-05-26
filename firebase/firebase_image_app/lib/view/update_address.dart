import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UpdateAddress extends StatefulWidget {
  const UpdateAddress({super.key});

  @override
  State<UpdateAddress> createState() => _UpdateAddressState();
}

class _UpdateAddressState extends State<UpdateAddress> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController relationController = TextEditingController();

  var value = Get.arguments ?? "__";
  int firstDisp = 0;

  XFile? imageFile;
  final ImagePicker picker = ImagePicker();
  File? imgFile;

  @override
  void initState() {
    super.initState();
    nameController.text = value[1];
    phoneController.text = value[2];
    addressController.text = value[3];
    relationController.text = value[4];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("주소록 수정"),
      ),
      body: Center(
        child: Column(
          children: [
            _buildTextField(nameController, "이름을 수정하세요"),  
            _buildTextField(phoneController, "전화번호를 수정하세요"),  
            _buildTextField(addressController, "주소를 수정하세요"),  
            _buildTextField(relationController, "관계를 수정하세요"),  

            ElevatedButton(
              onPressed: () => getImageFromGallery(ImageSource.gallery), 
              child: Text('Gallery')
              ),

            firstDisp == 0
            ? Container(
              height: 200,
              color: Colors.grey,
              child: Center(
                child: Image.network(value[5]),
              ),
            )

            : Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              color: Colors.grey,
              child: Center(
                child: imageFile == null
                ? Text("Image is not selected")
                : Image.file(imgFile!),
                
              ),
            ),
            ElevatedButton(
              onPressed: () {
                firstDisp == 0 ? updateAction() : updateActionAll();
              }, 
              child: Text('수정')
              ),
          ],
        ),
      )
    );
  } // build

  // --- Widgets ---
  _buildTextField(TextEditingController controller, String labelText){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: labelText),
      ),
    );
  }

  // --- Functions ---
  getImageFromGallery(ImageSource imageSource)async{
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    imageFile = XFile(pickedFile!.path); // Android와 iOS가 파일 타입이 달라서 XFile로 통일
    imgFile = File(imageFile!.path);
    firstDisp += 1;
    setState(() {});
  }


  updateAction()async{
    String name = nameController.text.trim();
    String phone = phoneController.text.trim();
    String address = addressController.text.trim();
    String relation = relationController.text.trim();

    FirebaseFirestore.instance
            .collection('students')
            .doc(value[0])
            .update(
              {
                'name' : name,
                'phone' : phone,
                'address' : address,
                'relation' : relation,
              }
            );
    _showDialog();
  }

  updateActionAll()async{
    String name = nameController.text.trim();
    String phone = phoneController.text.trim();
    String address = addressController.text.trim();
    String relation = relationController.text.trim();
    await deleteImage(); // storage에 있는것은 수정이 안되기에 지우고 다시 넣어야한다.
    String image = await preparingImage();

    FirebaseFirestore.instance
                  .collection('students')
                  .doc(value[0])
                  .update(
                    {
                      "name" : name,
                      "phone" : phone,
                      "address" : address,
                      "relation" : relation,
                      "image" : image,
                    }
    );
    _showDialog();


    
  }

  Future<String> preparingImage() async{ // async 때문에 퓨쳐를 써야 한다.
    final firebaseStorage = FirebaseStorage.instance
                                .ref()
                                .child('images')
                                .child('${nameController.text}.png');
    // await firebaseStorage.putFile(imgFile!);
    final bytes = await imageFile!.readAsBytes();
    await firebaseStorage.putData(bytes);
    String downloadURL = await firebaseStorage.getDownloadURL();
    return downloadURL;
  }

  deleteImage()async{
    final firebaseStorage = FirebaseStorage.instance
                                .ref()
                                .child('images')
                                .child('${value[1]}.png');
    await firebaseStorage.delete();
  }

  _showDialog(){
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
      ]
    );
  }


} // class