// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Section _$$_SectionFromJson(Map<String, dynamic> json) => _$_Section(
      id: json['id'] as int?,
      name: json['name'] as String,
      start: json['start'] as int,
      last: json['last'] as int,
      bookId: json['book_id'] as int?,
      userId: json['user_id'] as String?,
    );

Map<String, dynamic> _$$_SectionToJson(_$_Section instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['name'] = instance.name;
  val['start'] = instance.start;
  val['last'] = instance.last;
  writeNotNull('book_id', instance.bookId);
  writeNotNull('user_id', instance.userId);
  return val;
}
