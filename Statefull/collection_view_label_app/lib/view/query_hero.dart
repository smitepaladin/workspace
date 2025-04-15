import 'package:collection_view_label_app/view/detail_hero.dart';
import 'package:collection_view_label_app/view/insert_hero.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QueryHero extends StatefulWidget {
  const QueryHero({super.key});

  @override
  State<QueryHero> createState() => _QueryHeroState();
}

class _QueryHeroState extends State<QueryHero> {

  //Property

  late List<String> heroList;

  @override
  void initState() {
    super.initState();
    heroList = ['유비','관우','장비','조조','여포','초선','손견','장양','손책'];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('삼국지 인물'),
        actions: [
          IconButton(
            onPressed: () => Get.to(InsertHero())!.then((value) => rebuildData(value),), // !는 null값이라도 상관없이 받겠다는 뜻
            icon: Icon(
              Icons.add_outlined
            ),
          ),
        ],
      ),
      body: GridView.builder(
        itemCount: heroList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10, // 한줄 당 cell끼리의 간격
          mainAxisSpacing: 10, // 한줄과 다음줄과의 간격
        ), // 한줄에  몇개 쓸 것인가
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(
                DetailHero(),
                arguments: heroList[index]
              );
            },
            child: Card(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Center(
                child: Text(
                  heroList[index],
                ),
              ),
            ),
          );
        },
      ),
    );
  }//build

  //functions//

  rebuildData(value){ // 넘겨줄 때 T타입으로 들어온거라 무엇으로 바꾸든 상관이 없다. 지금은 타입을 안 줘서 dynamic이다.
    if(value != '' && value != null){ // value != ''는 빈값일 경우, value != null은 뒤로 가기를 통해 null값이 넘어온 경우를 걸러낸다.
      heroList.add(value);
    }
    setState(() {});
  }


}// Class