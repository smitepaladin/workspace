import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageModel with ChangeNotifier{ // 여기는 이미지만 넘겨주면 된다.
  final ImagePicker picker = ImagePicker();
  XFile? imageFile; // 경로만 계속 지켜보고 있으면 된다.

  Future<void> getImageFromGallery(ImageSource source) async{
    final pickedFile = await picker.pickImage(source: source);
    if(pickedFile != null){
      imageFile = pickedFile;
      notifyListeners();
    }
  }

  void clearImage(){
    imageFile = null;
    notifyListeners();
  }
}