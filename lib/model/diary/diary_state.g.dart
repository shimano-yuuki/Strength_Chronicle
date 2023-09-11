// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Diary _$$_DiaryFromJson(Map<String, dynamic> json) => _$_Diary(
      chronicleContents: json['chronicleContents'] as String,
      createdAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['createdAt'], const DateTimeConverter().fromJson),
    );

Map<String, dynamic> _$$_DiaryToJson(_$_Diary instance) => <String, dynamic>{
      'chronicleContents': instance.chronicleContents,
      'createdAt': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.createdAt, const DateTimeConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
