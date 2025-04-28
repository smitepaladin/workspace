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

// class _UpdateAddressState extends State<UpdateAddress> {
//   // Property

//   late DatabaseHandler handler;
//   late TextEditingController nameController;
//   late TextEditingController phoneController;
//   late TextEditingController addressController;
//   late TextEditingController relationController;

//   XFile? imageFile;
//   final ImagePicker picker = ImagePicker();

//   var value = Get.arguments ?? ["","", "", "", "", null];

//   @override
//   void initState() {
//     super.initState();
//     handler = DatabaseHandler();
//     nameController = TextEditingController();
//     phoneController = TextEditingController();
//     addressController = TextEditingController();
//     relationController = TextEditingController();


//     nameController.text = value[1];
//     phoneController.text = value[2];
//     addressController.text = value[3];
//     relationController.text = value[4];
//     if (value[5] != null) {
//       imageFile = XFile.fromData(value[5]);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('주소록 수정 및 삭제'),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             TextField(
//               controller: nameController,
//               decoration: InputDecoration(labelText: '이름을 입력하세요'),
//             ),
//             TextField(
//               controller: phoneController,
//               decoration: InputDecoration(labelText: '전화번호를 입력하세요'),
//             ),
//             TextField(
//               controller: addressController,
//               decoration: InputDecoration(labelText: '주소를 입력하세요'),
//             ),
//             TextField(
//               controller: relationController,
//               decoration: InputDecoration(labelText: '관계를 입력하세요'),
//             ),
//             ElevatedButton(
//               onPressed: () => getImageFromGallery(ImageSource.gallery),
//               child: Text('Gallary'),
//             ),
//             Container(
//               width: MediaQuery.of(context).size.width,
//               height: 200,
//               color: Colors.grey,
//               child: Center(
//                 child: imageFile==null
//                 ? Text('Image is not seleted!')
//                 : Image.memory(
//                       value[5], 
//                       fit: BoxFit.cover)
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () => updateAction(),
//               child: Text('수정'),
//             )
//           ],
//         ),
//       ),
//     );
//   }//build



//   //fuctions//

//   Future getImageFromGallery(ImageSource imageSource)async{
//     final XFile? pickedFile = await picker.pickImage(source: imageSource);
//     if(pickedFile == null){
//       return;
//     }else{
//       imageFile = XFile(pickedFile.path);
//       setState(() {});
//     }
//   }

//   updateAction()async{
//     // File Type을 Byte Type으로 변환
//     File imageFile1 = File(imageFile!.path); //경로만 가지고 왔으니 파일을 만들어 줄 것이다.
//     Uint8List getImage = await imageFile1.readAsBytes(); // 이미지 파일을 바이트로 바꾸기, 3차원 이미지를 1차원 바이트로 압축

//     var addressUpdate = Address(
//       name: nameController.text,
//       phone: phoneController.text,
//       address: addressController.text,
//       relation: relationController.text,
//       image: getImage);

//     int result = await handler.updateAddress(addressUpdate);
//     if(result == 0){
//       errorSnackBar();
//     }else{
//       _showDialog();
//     }
//   }


//   errorSnackBar(){
//     Get.snackbar(
//       "경고", 
//       "입력 중 문제가 발생했습니다",
//       colorText: Theme.of(context).colorScheme.onError,
//       backgroundColor: Theme.of(context).colorScheme.error,
//       );
//   }

//   _showDialog(){
//     Get.defaultDialog(
//       title : '수정완료',
//       middleText: '수정이 완료되었습니다.',
//       backgroundColor: Theme.of(context).colorScheme.primaryContainer,
//       barrierDismissible: false,
//       actions: [
//         TextButton(
//           onPressed: () {
//             Get.back();
//             Get.back();
//           },
//           child: Text('OK'),
//         )
//       ]
//     );
//   }
// }//Class

class _UpdateAddressState extends State<UpdateAddress> {
  // Property
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
    // value[5]가 null이 아니면 이미지 데이터를 Uint8List로 사용
    if (value[5] != null) {
      imageFile = XFile.fromData(value[5]); // Uint8List 데이터를 XFile로 변환
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
              child: Text('Gallery'),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              color: Colors.grey,
              child: Center(
                child: imageFile == null
                    ? Text('Image is not selected!')
                    : Image.memory(
                        value[5] as Uint8List,  // value[5]는 Uint8List로 전달
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            ElevatedButton(
              onPressed: () => updateAction(),
              child: Text('수정'),
            ),
          ],
        ),
      ),
    );
  }

  // Image selection from gallery
  Future getImageFromGallery(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile == null) {
      return;
    } else {
      imageFile = XFile(pickedFile.path);
      setState(() {});
    }
  }

  // Update the address
  updateAction() async {
    // File Type을 Byte Type으로 변환
    if (imageFile != null) {
      File imageFile1 = File(imageFile!.path);
      Uint8List getImage = await imageFile1.readAsBytes(); // 이미지를 바이트로 변환

      var addressUpdate = Address(
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
  }

  // Error snackbar
  errorSnackBar() {
    Get.snackbar(
      "경고",
      "입력 중 문제가 발생했습니다",
      colorText: Theme.of(context).colorScheme.onError,
      backgroundColor: Theme.of(context).colorScheme.error,
    );
  }

  // Success dialog
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
        ),
      ],
    );
  }
}