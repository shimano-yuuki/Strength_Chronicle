import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workout_app/model/diary/diary_state.dart';


abstract class UserRepositoryInterface {
  Future<List<Diary>> getDiaryInfo();
}

class DiaryRepository {
  Future<List<Diary>> getDiaryInfo() async {
    final fireStore = FirebaseFirestore.instance;
    try{
      final snapShot = await fireStore.collection('users').doc('rgbjM7FWkwzm0KHURf9N').collection('chronicle').get();
      final userList = <Diary>[];
      snapShot.docs.forEach((content) {
        userList.add(Diary.fromJson(content.data()));
      });
      return userList;
    } on FirebaseException catch(e){
      throw e.toString();
    }
  }
}