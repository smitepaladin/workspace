import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:must_eat_place_app/view/gps_eatplace.dart';
import 'package:must_eat_place_app/view/insert_eatplace.dart';
import 'package:must_eat_place_app/view/update_eatplace.dart';
import 'package:must_eat_place_app/vm/database_handler.dart';

class QueryEatplace extends StatefulWidget {
  const QueryEatplace({super.key});

  @override
  State<QueryEatplace> createState() => _QueryEatplaceState();
}

class _QueryEatplaceState extends State<QueryEatplace> {
  // Property
  late DatabaseHandler handler;
  XFile? imageFile;
  final ImagePicker picker = ImagePicker();

  // 필터 상태
  bool showFavor = false;
  String selectedCategory = '전체';
  List<String> categoryList = ['전체', '기타', '한식', '중식', '일식', '양식'];

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('맛집'),
        actions: [
          // 카테고리 드롭다운
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedCategory,
              icon: Icon(Icons.arrow_drop_down_outlined, color: Colors.black),
              dropdownColor: Colors.white,
              style: TextStyle(color: Colors.black),
              items:
                  categoryList.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
            ),
          ),
          // 즐겨찾기 필터 버튼
          IconButton(
            icon: Icon(
              showFavor ? Icons.star : Icons.star_border,
              color: showFavor ? Colors.amber : Colors.grey,
            ),
            tooltip: '즐겨찾기만 보기',
            onPressed: () {
              setState(() {
                showFavor = !showFavor;
              });
            },
          ),

          // 추가 버튼
          IconButton(
            onPressed:
                () => Get.to(InsertEatplace())!.then((value) => reloadData()),
            icon: Icon(Icons.add_outlined),
          ),
        ],
      ),
      body: FutureBuilder(
        future: handler.queryEatplace(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // 필터 적용
            List filteredData =
                snapshot.data!
                    .where(
                      (item) =>
                          (selectedCategory == '전체' ||
                              item.category == selectedCategory) &&
                          (!showFavor || item.favor == true),
                    ).toList();

            if (filteredData.isEmpty) {
              return Center(
                child: Text(
                  '해당 카테고리에 추가한 맛집이 없습니다.',
                  style: TextStyle(fontSize: 16),
                ),
              );
            }

            return ListView.builder(
              itemCount: filteredData.length,
              itemBuilder: (context, index) {
                final item = filteredData[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(
                      GpsEatplace(),
                      arguments: [
                        item.id!,
                        item.name,
                        item.latData,
                        item.longData,
                      ],
                    )!.then((value) => reloadData());
                  },
                  child: Slidable(
                    startActionPane: ActionPane(
                      motion: BehindMotion(),
                      children: [
                        SlidableAction(
                          backgroundColor: Colors.green,
                          icon: Icons.update,
                          label: '수정',
                          onPressed: (context) {
                            Get.to(
                              UpdateEatplace(),
                              arguments: [
                                item.id!,
                                item.name,
                                item.phone,
                                item.detail,
                                item.category,
                                item.favor,
                                item.image,
                                item.latData,
                                item.longData,
                              ],
                            )!.then((value) => reloadData());
                          },
                        ),
                      ],
                    ),
                    endActionPane: ActionPane(
                      motion: BehindMotion(),
                      children: [
                        SlidableAction(
                          backgroundColor: Colors.red,
                          icon: Icons.delete,
                          label: '삭제',
                          onPressed: (context) async {
                            await handler.deleteEatplace(item.id!);
                            snapshot.data!.remove(item);
                            setState(() {});
                          },
                        ),
                      ],
                    ),
child: Card(
  color: item.favor ? Colors.yellow : const Color.fromARGB(255, 233, 233, 233),
  child: Row(
    children: [
      Image.memory(
        item.image,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
      SizedBox(width: 10),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('명칭 : ${item.name}'),
          Text('전화번호 : ${item.phone}'),
        ],
      ),
    ],
  ),
),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  // functions
  reloadData() {
    handler.queryEatplace();
    setState(() {});
  }
}