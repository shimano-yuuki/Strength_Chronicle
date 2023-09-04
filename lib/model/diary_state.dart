import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../datetime_converter.dart';

part 'diary_state.freezed.dart';
part 'diary_state.g.dart';

@freezed
class Diary with _$Diary {
  const Diary._();
  const factory Diary({
  @JsonKey(name: 'chronicleContents') required String chronicleContents,
  @JsonKey(name: 'createdAt') @DateTimeConverter() required DateTime? createdAt,
  }) = _Diary;

  factory Diary.fromJson(Map<String, dynamic> json) => _$DiaryFromJson(json);
}
