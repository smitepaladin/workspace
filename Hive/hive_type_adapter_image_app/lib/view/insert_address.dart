import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_type_adapter_image_app/model/address.dart';
import 'package:image_picker/image_picker.dart';

class InsertAddress extends StatefulWidget {
  const InsertAddress({super.key});

  @override
  State<InsertAddress> createState() => _InsertAddressState();
}

class _InsertAddressState extends State<InsertAddress> {
  // Property

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController relationController = TextEditingController();

  Box addressBox = Hive.box('address');

  XFile? imageFile;
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('주소록 입력'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTextField(nameController, "이릅을 입력하세요."),
            _buildTextField(phoneController, "전화번호를 입력하세요."),
            _buildTextField(addressController, "주소를 입력하세요."),
            _buildTextField(relationController, "관계를 입력하세요."),
            ElevatedButton(
              onPressed: () => getImageFromGallery(ImageSource.gallery),
              child: Text("Gallary"),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              color: Colors.grey,
              child: Center(
                child: imageFile == null
                ? Text("Image in not selected")
                : Image.file(File(imageFile!.path)),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                _insertAction();
                _showDialog();
              },
              child: Text("입력"),
            )
          ],
        ),
      ),
    );
  }//build


  // -- Widget --

  Widget _buildTextField(TextEditingController controller, String labelText){
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: labelText),
      keyboardType: TextInputType.text,
    );
  }


  // Functions //

  getImageFromGallery(ImageSource imageSource)async{
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    imageFile = XFile(pickedFile!.path);
    setState(() {});
  }

  _insertAction()async{
    File imageFile1 = File(imageFile!.path);
    Uint8List getImage = await imageFile1.readAsBytes();

    Address address = Address(
      name: nameController.text.trim(),
      phone: phoneController.text.trim(),
      address: addressController.text.trim(),
      relation: relationController.text.trim(),
      image: getImage
    );

    addressBox.add(address);

  }




  _showDialog(){
    Get.defaultDialog(
      title: "입력결과",
      middleText: "입력이 완료 되었습니다.",
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      barrierDismissible: false,
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            Get.back();
          },
          child: Text("OK"),
        )
      ]
    );
  }
}// Class