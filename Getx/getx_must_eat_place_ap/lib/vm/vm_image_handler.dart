import 'package:get/get.dart';
import 'package:getx_must_eat_place_app/vm/vm_gps_handler.dart';
import 'package:image_picker/image_picker.dart';

class VmImageHandler extends VmGpsHandler{
  // 이미지 파일
  final imageFile = Rx<XFile?>(null); // null을 허용하면 .obs를 못 써서 대신에 Rx를 붙임
  final ImagePicker picker = ImagePicker();

  Future<void> getImageFromGallery(ImageSource source)async{
    final XFile? pickedFile = await picker.pickImage(source: source);
    if(pickedFile != null){
      imageFile.value = pickedFile;
    }
  }
}