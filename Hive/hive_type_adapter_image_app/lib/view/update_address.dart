import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_type_adapter_image_app/model/address.dart';
import 'package:image_picker/image_picker.dart';

class UpdateAddress extends StatefulWidget {
  const UpdateAddress({super.key});

  @override
  State<UpdateAddress> createState() => _UpdateAddressState();
}

class _UpdateAddressState extends State<UpdateAddress> {
  // Property

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController relationController = TextEditingController();

  Box addressBox = Hive.box('address');

  int firstDisp = 0;
  var value = Get.arguments ?? "__";
  late int index = 0;

  XFile? imageFile;
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    index = value[0];
    nameController.text = value[1];
    phoneController.text = value[2];
    addressController.text = value[3];
    relationController.text = value[4];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('주소록 수정'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTextField(nameController, "이릅을 수정하세요."),
            _buildTextField(phoneController, "전화번호를 수정하세요."),
            _buildTextField(addressController, "주소를 수정하세요."),
            _buildTextField(relationController, "관계를 수정하세요."),

            ElevatedButton(
              onPressed: () => getImageFromGallery(ImageSource.gallery),
              child: Text("Gallary"),
            ),

            firstDisp == 0
            ? Container(
                height: 200,
                color: Colors.grey,
                child: Center(
                  child: Image.memory(value[5]),
              ),
            )
            : Container(
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
                _updateAction();
                _showDialog();
              },
              child: Text("수정"),
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
    firstDisp += 1;
    setState(() {});
  }


  _updateAction()async{

    Address address;

    if(firstDisp == 0){
      address = Address(
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
        address: addressController.text.trim(),
        relation: relationController.text.trim(),
        image: value[5]
      );
    }else{

    File imageFile1 = File(imageFile!.path);
    Uint8List getImage = await imageFile1.readAsBytes();

    address = Address(
      name: nameController.text.trim(),
      phone: phoneController.text.trim(),
      address: addressController.text.trim(),
      relation: relationController.text.trim(),
      image: getImage
      );
    }
    addressBox.putAt(index, address);

  }




  _showDialog(){
    Get.defaultDialog(
      title: "수정결과",
      middleText: "수정이 완료 되었습니다.",
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