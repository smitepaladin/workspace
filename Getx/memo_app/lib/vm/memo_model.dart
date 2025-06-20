import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:memo_app/model/memo.dart';

class MemoController extends GetxController{
  final RxList<Memo> memos = <Memo>[].obs;
  final CollectionReference _memos = FirebaseFirestore.instance.collection("memos");
  
  @override
  void onInit() {
    super.onInit();
    _bindMemosStream();
  }

  void _bindMemosStream(){
    _memos.snapshots().listen((snapshot) {
      final List<Memo> loaded = snapshot.docs
                  .map((doc) => Memo.fromMap(doc.data() as Map<String, dynamic>, doc.id))
                  .toList();
      memos.assignAll(loaded); // Memo는 Rx고, loaded는 list인데 assignAll이 알아서 바꿔준다.
    });
  }

  Future<void> addMemo(String title, String content) async{
    await _memos.add(
      {
        'title' : title,
        'content' : content,
      }
    );
  }

  Future<void> deleteMemo(String id) async{
    await _memos.doc(id).delete();
  }

  

}