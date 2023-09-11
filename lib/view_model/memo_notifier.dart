import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:workout_app/model/memo/memo_state.dart';
part 'memo_notifier.g.dart';

@riverpod
class Visible extends _$Visible {
  @override
  bool build() {
    return true;
  }
  void changeVisible(bool bool ){
    state = bool;
  }
}

@riverpod
class TextFromField extends _$TextFromField {
  @override
   String build() {
    return '';
  }
  void changeText(String text){
    state = text;
  }
  void clearText(){
    state = '';
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
    state.removeWhere((memo) => memo.id == memoId);
  }
}

@riverpod
  class DropDownButton extends _$DropDownButton {
  @override
  DropDownButtonState build() {
  return DropDownButtonState(part: '',type: '');
  }

  void selected({
    String? part,
    String? type
  }){
    state = state.copyWith(part: part,type: type);
  }
}

class DropDownButtonState{
  DropDownButtonState({required this.part, required this.type});

  final String part;
  final String type;

  DropDownButtonState copyWith({
    String? part,
    String? type,
}){
    return DropDownButtonState(
      part: part ?? this.part,
      type: type ?? this.type,
    );
  }

}