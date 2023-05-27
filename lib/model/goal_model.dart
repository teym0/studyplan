import 'package:freezed_annotation/freezed_annotation.dart';

import '../component/datetime_json_converter.dart';

part 'goal_model.freezed.dart';
part 'goal_model.g.dart';

@freezed
class Goal with _$Goal {
  @JsonSerializable(includeIfNull: false)
  const factory Goal({
    @JsonKey(name: 'id') int? id,
    @DatetimeJsonConverter()
    @JsonKey(name: 'started_at')
    required DateTime startedAt,
    @JsonKey(name: 'day') required int day,
    @JsonKey(name: 'reflected') required bool reflected,
    @JsonKey(name: 'percentage') int? percentage,
    @JsonKey(name: 'start') required int start,
    @JsonKey(name: 'last') required int last,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'book_id') required int bookId,
    @JsonKey(name: 'dayratio') required int dayratio,
  }) = _Goal;

  factory Goal.fromJson(Map<String, dynamic> json) => _$GoalFromJson(json);
}
