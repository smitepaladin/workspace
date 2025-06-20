import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memo_app/model/memo.dart';

class MemoNotifier extends StateNotifier<List<Memo>>{
  MemoNotifier() : super([]){
    _listenToMemos(); // 초기화 시켜놓고 생성하는 것 부른다.
  }

  final CollectionReference _memos = FirebaseFirestore.instance.collection("memos");



  void _listenToMemos(){
    _memos.snapshots().listen((snapshot) {
      state = snapshot.docs
                  .map((doc) => Memo.fromMap(doc.data() as Map<String, dynamic>, doc.id))
                  .toList();
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

final memoProvider  = StateNotifierProvider<MemoNotifier, List<Memo>>(
  (ref) => MemoNotifier(),
);