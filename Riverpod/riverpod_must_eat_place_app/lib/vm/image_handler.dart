import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ImageState{ // 여기는 이미지만 넘겨주면 된다.
  XFile? imageFile; // 경로만 계속 지켜보고 있으면 된다.
  ImageState({
    this.imageFile
  });
}


class ImageHandler extends StateNotifier<ImageState>{
  final ImagePicker picker = ImagePicker();
  ImageHandler() : super(ImageState());

  Future<void> getImageFromGallery(ImageSource source) async{
    final pickedFile = await picker.pickImage(source: source);
    if(pickedFile != null){
      state = ImageState(imageFile: pickedFile);
    }
  }
  void clearImage(){
    state = ImageState();
  }
}

final imageHandlerProvider = StateNotifierProvider<ImageHandler, ImageState>(
  (ref) => ImageHandler(),
);