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
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('memos')
        .doc()
        .set(Memo(
                id: memo.id,
                title: memo.title,
                part: memo.part,
                type: memo.type)
            .toJson());
  }

  @override
  Future<void> deleteMemo({required Memo memo}) async {
    final uid = currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('memos')
        .doc(memo.id)
        .delete();
  }

  @override
  Future<List<Memo>> fetchMemo() async {
    final uid = currentUser!.uid;

    final memosSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('memos')
        .get();

    final list = <Memo>[];
    for (final document in memosSnapshot.docs) {
      final data = Memo.fromJson(document.data());
      list.add(data);
    }
    return list;
  }
}
