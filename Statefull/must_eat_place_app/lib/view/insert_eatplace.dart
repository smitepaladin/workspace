import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:must_eat_place_app/model/eatplace.dart';
import 'package:must_eat_place_app/view/insert_gps.dart';
import 'package:must_eat_place_app/vm/database_handler.dart';

class InsertEatplace extends StatefulWidget {
  const InsertEatplace({super.key});

  @override
  State<InsertEatplace> createState() => _InsertEatplaceState();
}

class _InsertEatplaceState extends State<InsertEatplace> {
  late DatabaseHandler handler;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController detailController;
  double? latData;
  double? longData;
  late List<String> categoryList;
  late String category;
  bool favor = false;

  XFile? imageFile;
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    detailController = TextEditingController();
    categoryList = ['기타', '한식', '중식', '일식', '양식'];
    category = categoryList[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('맛집 추가')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => getImageFromGallery(ImageSource.gallery),
              child: Text('이미지'),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              color: Colors.grey,
              child: Center(
                child: imageFile == null
                    ? Text('Image is not seleted!')
                    : Image.file(File(imageFile!.path)),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final result = await Get.to(InsertGps());
                if (result != null) {
                  setState(() {
                    latData = result['lat'];
                    longData = result['long'];
                  });
                }
              },
              child: Text('위치설정'),
            ),

            // 위치 출력 줄맞춤
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 80, child: Text('위치')),
                  Expanded(
                    child: latData == null || longData == null
                        ? Text('위치가 선택되지 않았습니다.')
                        : Text(
                            '위도  ${latData!.toStringAsFixed(4)}  /  경도  ${longData!.toStringAsFixed(4)}',
                          ),
                  ),
                ],
              ),
            ),

            // 이름
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                children: [
                  SizedBox(width: 80, child: Text('이름')),
                  Expanded(
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(labelText: '이름을 입력하세요'),
                    ),
                  ),
                ],
              ),
            ),

            // 전화번호
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                children: [
                  SizedBox(width: 80, child: Text('전화번호')),
                  Expanded(
                    child: TextField(
                      controller: phoneController,
                      decoration: InputDecoration(labelText: '전화번호를 입력하세요'),
                    ),
                  ),
                ],
              ),
            ),

            // 종류
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                children: [
                  SizedBox(width: 80, child: Text('종류')),
                  Expanded(
                    child: DropdownButton<String>(
                      value: category,
                      isExpanded: true,
                      items: categoryList.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        category = value!;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),

            // 평가
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 80, child: Text('평가')),
                  Expanded(
                    child: TextField(
                      controller: detailController,
                      maxLines: 2,
                      decoration: InputDecoration(labelText: '평가를 입력하세요'),
                    ),
                  ),
                ],
              ),
            ),

            // 즐겨찾기
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                children: [
                  SizedBox(width: 80, child: Text('즐겨찾기')),
                  Checkbox(
                    value: favor,
                    onChanged: (value) {
                      favor = value!;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => insertAction(),
              child: Text('입력'),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Future getImageFromGallery(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile == null) {
      return;
    } else {
      imageFile = XFile(pickedFile.path);
      setState(() {});
    }
  }

  insertAction() async {
    File imageFile1 = File(imageFile!.path);
    Uint8List getImage = await imageFile1.readAsBytes();

    var eatplaceInsert = Eatplace(
      name: nameController.text,
      phone: phoneController.text,
      detail: detailController.text,
      category: category,
      favor: favor,
      latData: latData!,
      longData: longData!,
      image: getImage,
    );

    int result = await handler.insertEatplace(eatplaceInsert);
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
      title: '입력완료',
      middleText: '입력이 완료되었습니다.',
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

