import 'package:freezed_annotation/freezed_annotation.dart';

import '../component/datetime_json_converter.dart';

part 'book_model.freezed.dart';
part 'book_model.g.dart';

@freezed
class Book with _$Book {
  @JsonSerializable(includeIfNull: false)
  const factory Book({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'title') required String title,
    @DatetimeJsonConverter()
    @JsonKey(name: 'created_at')
    required DateTime createdAt,
    @JsonKey(name: 'amount') required int amount,
    @JsonKey(name: 'unit_name') required String unitName,
    @JsonKey(name: 'user') required int userId,
    @JsonKey(name: 'image') String? imageUrl,
  }) = _Book;

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
}
