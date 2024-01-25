import 'package:workout_app/model/memo/memo_state.dart';

abstract class MemoRepository {

  Future<void> createMemo({
    required Memo memo,
  });


}
