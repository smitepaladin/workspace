import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:memo_app/model/memo.dart';

class MemoModel with ChangeNotifier{
  final CollectionReference _memos = FirebaseFirestore.instance.collection("memos");
  List<Memo> _memoList = [];

  List<Memo> get memos => _memoList;

  MemoModel(){
    _listenToMemos();
  }


  void _listenToMemos(){
    _memos.snapshots().listen((snapshot) {
      _memoList = snapshot.docs
                  .map((doc) => Memo.fromMap(doc.data() as Map<String, dynamic>, doc.id))
                  .toList();
      notifyListeners();
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