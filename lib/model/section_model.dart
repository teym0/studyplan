import 'package:freezed_annotation/freezed_annotation.dart';

part 'section_model.freezed.dart';
part 'section_model.g.dart';

@freezed
class Section with _$Section {
  @JsonSerializable(includeIfNull: false)
  const factory Section({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'start') required int start,
    @JsonKey(name: 'last') required int last,
    @JsonKey(name: 'book_id') int? bookId,
    @JsonKey(name: 'user_id') String? userId,
  }) = _Section;

  factory Section.fromJson(Map<String, dynamic> json) =>
      _$SectionFromJson(json);
}
