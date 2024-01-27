import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:workout_app/model/memo/memo_state.dart';
import 'package:workout_app/repository/memo_repository_impl.dart';
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
class Memos extends _$Memos {
  @override
  List<Memo> build() {
    return [];
  }
  void addMemo(Memo memo) {

    state = [...state, memo];
    MemoRepositoryImpl().createMemo(memo: memo);
  }
  void removeMemo(String memoId){
    print(state);
    state.removeWhere((memo) => memo.id == memoId);
    print(state);
  }
}
// @riverpod
@Riverpod(keepAlive: true)
class TrainingNameController extends _$TrainingNameController {
  @override
  TextEditingController build() {
    return TextEditingController();
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