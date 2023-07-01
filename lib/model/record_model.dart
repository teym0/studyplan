import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:leadstudy/component/datetime_json_converter.dart';

part 'record_model.freezed.dart';
part 'record_model.g.dart';

@freezed
class Record with _$Record {
  @JsonSerializable(includeIfNull: false)
  const factory Record({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'start') required int start,
    @JsonKey(name: 'last') required int last,
    @JsonKey(name: 'duration') required int duration,
    @DatetimeJsonConverter()
    @JsonKey(name: 'recorded_at')
    required DateTime recordedAt,
    @DatetimeJsonConverter()
    @JsonKey(name: 'started_at')
    required DateTime startedAt,
    @JsonKey(name: 'book_id') required int bookId,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'goal_id') int? goalId,
  }) = _Record;

  factory Record.fromJson(Map<String, dynamic> json) => _$RecordFromJson(json);
}
