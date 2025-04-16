import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class Detail extends StatefulWidget {
  const Detail({super.key});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  //Property
  late String image;
  late String title;

  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    image = "";
    title = "";
    initStorage();
  }

  initStorage(){
    image = box.read('image');
    title = box.read('title');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('영화상세'),
      ),
      body: Center(
        child: Column(
          children: [
            Image.network(
              image
            ),
            Text(title)
          ],
        ),
      ),
    );
  }
}