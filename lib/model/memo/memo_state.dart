import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'memo_state.freezed.dart';
part 'memo_state.g.dart';

@freezed
abstract class Memo with _$Memo {
  const factory Memo({
    required String id,
    required String title,
    required String part,
    required String type,
  }) = _Memo;

  factory Memo.fromJson(Map<String, dynamic> json) => _$MemoFromJson(json);
}
