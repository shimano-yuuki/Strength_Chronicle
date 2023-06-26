import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:workout_app/model/memo_state.dart';
part 'memo_notifier.g.dart';

@riverpod
class TextFromField extends _$TextFromField {
  @override
   String build() {
    return '';
  }
  void changeText(String text){
    state = text;
  }
}


@riverpod
class Memos extends _$Memos {
  @override
  List<Memo> build() {
    return [];
  }
  void addMemo(Memo memo) {
    state = [...state, memo];
  }
  void removeMemo(String memoId){
    state = [
      for (final memo in state)
        if (memo.id == memoId) memo
    ];
  }
}


