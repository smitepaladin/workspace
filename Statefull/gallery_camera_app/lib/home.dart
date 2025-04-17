import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  XFile? imageFile;
  final ImagePicker picker = ImagePicker(); // state관련된 것이 없으므로 initstate안 쓴다.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gallery & Camera')),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 200, // 위에 범위를 주기 위해, 색을 준다면 Container를 쓰면 된다.
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        getImageFromDevice(ImageSource.gallery);
                      },
                      child: Text('Gallery'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        getImageFromDevice(ImageSource.camera);
                      },
                      child: Text('Camera'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7, // 가져온 이미지 크기를
              child: Center(
                child:
                    imageFile == null
                        ? Text('Image is not seleted.')
                        : Image.file(File(imageFile!.path)),
              ),
            ),
          ],
        ),
      ),
    );
  } // build

  // Functions //
  getImageFromDevice(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile == null) {
      imageFile = null;
    } else {
      imageFile = XFile(pickedFile.path);
    }
    setState(() {});
  }
} //Class
