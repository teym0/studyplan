// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Record _$$_RecordFromJson(Map<String, dynamic> json) => _$_Record(
      id: json['id'] as int?,
      start: json['start'] as int,
      last: json['last'] as int,
      duration: json['duration'] as int,
      recordedAt:
          const DatetimeJsonConverter().fromJson(json['recorded_at'] as String),
      startedAt:
          const DatetimeJsonConverter().fromJson(json['started_at'] as String),
      bookId: json['book_id'] as int,
      userId: json['user_id'] as String,
    );

Map<String, dynamic> _$$_RecordToJson(_$_Record instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['start'] = instance.start;
  val['last'] = instance.last;
  val['duration'] = instance.duration;
  val['recorded_at'] =
      const DatetimeJsonConverter().toJson(instance.recordedAt);
  val['started_at'] = const DatetimeJsonConverter().toJson(instance.startedAt);
  val['book_id'] = instance.bookId;
  val['user_id'] = instance.userId;
  return val;
}
