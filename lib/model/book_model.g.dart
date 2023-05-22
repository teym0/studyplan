// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Book _$$_BookFromJson(Map<String, dynamic> json) => _$_Book(
      id: json['id'] as int?,
      title: json['title'] as String,
      createdAt:
          const DatetimeJsonConverter().fromJson(json['created_at'] as String),
      amount: json['amount'] as int,
      working: json['working'] as bool,
      unitName: json['unit_name'] as String,
      userId: json['user_id'] as String,
      imageUrl: json['image_url'] as String?,
      level: json['level'] as int?,
    );

Map<String, dynamic> _$$_BookToJson(_$_Book instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['title'] = instance.title;
  val['created_at'] = const DatetimeJsonConverter().toJson(instance.createdAt);
  val['amount'] = instance.amount;
  val['working'] = instance.working;
  val['unit_name'] = instance.unitName;
  val['user_id'] = instance.userId;
  writeNotNull('image_url', instance.imageUrl);
  writeNotNull('level', instance.level);
  return val;
}
