import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:workout_app/model/memo_state.dart';
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
   String build() {
  return '';
  }
  void selectedPart(String? value){
    state = value!;
  }
  void selectedType(String? value){
    state = value!;
  }
  String? stringSelectPart(String? value){
    final part  = value;
    return part;
  }
  String? stringSelectType(String? value){
    final type  = value;
    return type;
  }
}
