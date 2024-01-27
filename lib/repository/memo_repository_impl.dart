import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:workout_app/model/auth/firebase_auth.dart';
import 'package:workout_app/model/memo/memo_state.dart';
import 'package:workout_app/repository/memo_repository.dart';

class MemoRepositoryImpl implements MemoRepository {
  @override
  User? get currentUser => AuthService().currentUser;

  @override
  Future<void> createMemo({required Memo memo}) async {
    final uid = currentUser!.uid;
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('memos')
        .add(Memo(
                id: memo.id,
                title: memo.title,
                part: memo.part,
                type: memo.type)
            .toJson());
  }

  // @override
  // Future<void> deleteMemo({required Memo memo}) async{
  //   final uid = currentUser!.uid;
  //   FirebaseFirestore.instance.collection('users').doc(uid).collection('memos').doc()
  // }
}
