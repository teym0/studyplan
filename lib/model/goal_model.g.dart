// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Goal _$$_GoalFromJson(Map<String, dynamic> json) => _$_Goal(
      id: json['id'] as int?,
      startedAt:
          const DatetimeJsonConverter().fromJson(json['started_at'] as String),
      day: json['day'] as int,
      reflected: json['reflected'] as bool,
      percentage: json['percentage'] as int?,
      start: json['start'] as int,
      last: json['last'] as int,
      userId: json['user_id'] as String,
      bookId: json['book_id'] as int,
    );

Map<String, dynamic> _$$_GoalToJson(_$_Goal instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['started_at'] = const DatetimeJsonConverter().toJson(instance.startedAt);
  val['day'] = instance.day;
  val['reflected'] = instance.reflected;
  writeNotNull('percentage', instance.percentage);
  val['start'] = instance.start;
  val['last'] = instance.last;
  val['user_id'] = instance.userId;
  val['book_id'] = instance.bookId;
  return val;
}
