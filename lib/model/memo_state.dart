import 'package:freezed_annotation/freezed_annotation.dart';

part 'memo_state.freezed.dart';

@freezed
class Memo with _$Memo {
  const factory Memo ({
    required String id,
    required String title,
    required String part,
    required String type,
  }) = _Memo;
}



