import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // Property
  List<Map<String, dynamic>> _items = []; // nosql이니까 Map형식
  final _shoppingBox = Hive.box('shopping_box'); // Hive 데이터 들고오자. _는 private니까 해당클래스에서만 쓸 수 있다.

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();


@override
  void initState() {
    super.initState();
    _refreshItems();// 화면띄우기전에 DB에서 불러와서 _items에 넣어줘야지
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hive CRUD"),
      ),
      body: _items.isEmpty
      ? Center(
        child: Text(
          'No Data',
          style: TextStyle(fontSize: 30),
        ),
      )
      : ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final currentItem = _items[index];
          return Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: ListTile(
              title: Text(currentItem['name']),
              subtitle: Text(currentItem['quantity'].toString()),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Edit Button
                  IconButton(
                    onPressed: () => _showForm(context, currentItem['key']),
                    icon: Icon(Icons.edit),
                  ),
                  // Delete button
                  IconButton(
                    onPressed: () => _deleteItem(currentItem['key']),
                    icon: Icon(Icons.delete)
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(context, null),
        child: Icon(Icons.add),
      ),
    );
  } // Build

  // functions //

  _refreshItems(){
    final data  = _shoppingBox.keys.map((key) {
      final value = _shoppingBox.get(key); // key해당하는 value값을 가져와서
      return {"key": key, "name": value["name"], "quantity": value["quantity"]};
    }).toList();
    _items = data.reversed.toList(); // 역순으로 넣어주겠다. 최근게 가장 위로
    setState(() {});
  }

  _showForm(BuildContext ctx, int? itemKey)async{ // itemKey값은 없을수도 있으니까
    // 두가지 개념 데이터를 처음 넣을떄, 그 다음일 때
    // itemKey == null -> create이다
    // itemKey != update an existing item
    if(itemKey != null){
      final existingItem = _items.firstWhere((element) => element['key'] == itemKey);
      _nameController.text = existingItem['name'];
      _quantityController.text = existingItem['quantity'];
    }

    showModalBottomSheet(
      context: ctx, // ctx는 bottomsheet
      elevation: 5,
      isScrollControlled: true, // 공사장표시 방지
      builder: (context) => Container( // Container에는 자체 패딩이 있다.
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, // context는 전체
          top: 15,
          left: 15,
          right: 15,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(hintText: 'Name'),
            ),
            TextField(
              controller: _quantityController,
              decoration: InputDecoration(hintText: 'Quantity'),
            ),
            ElevatedButton(
              onPressed: () async{
                if(itemKey == null){
                  _createItem(
                    {
                    "name" : _nameController.text,
                    "quantity" : _quantityController.text
                    }
                  );
                }
                if(itemKey != null){
                  _updateItem(itemKey, {
                    "name" : _nameController.text.trim(),
                    "quantity" : _quantityController.text.trim()
                    }
                  );
                }
                //textfield 정리
                _nameController.text = "";
                _quantityController.text = "";

                Get.back();
              },
              child: Text(itemKey == null ? "Create New" : "Update"),
            ),
          ],
        ),
      ),
    );
  }
  // 삭제
  _deleteItem(int itemKey)async{ // 지우려는데 key값이 없을리가 없으니까
    await _shoppingBox.delete(itemKey);
    _refreshItems(); // 화면재구성
    _snackBar();
  }

  // 입력
  _createItem(Map<String, dynamic> newItem)async{
    await _shoppingBox.add(newItem);
    _refreshItems();
  }
  
  // 수정
  _updateItem(int itemKey,Map<String, dynamic> item)async{
    await _shoppingBox.put(itemKey, item);
    _refreshItems();
  }

  // snackBar
  _snackBar(){
    Get.snackbar(
      "Message",
      "삭제되었습니다.",
      duration: Duration(seconds: 2),
      colorText: Theme.of(context).colorScheme.onError,
      backgroundColor: Theme.of(context).colorScheme.error
    );
  }

}//Class