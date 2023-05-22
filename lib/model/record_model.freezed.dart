// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'record_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Record _$RecordFromJson(Map<String, dynamic> json) {
  return _Record.fromJson(json);
}

/// @nodoc
mixin _$Record {
  @JsonKey(name: 'id')
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'start')
  int get start => throw _privateConstructorUsedError;
  @JsonKey(name: 'last')
  int get last => throw _privateConstructorUsedError;
  @JsonKey(name: 'duration')
  int get duration => throw _privateConstructorUsedError;
  @DatetimeJsonConverter()
  @JsonKey(name: 'recorded_at')
  DateTime get recordedAt => throw _privateConstructorUsedError;
  @DatetimeJsonConverter()
  @JsonKey(name: 'started_at')
  DateTime get startedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'book_id')
  int get bookId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecordCopyWith<Record> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordCopyWith<$Res> {
  factory $RecordCopyWith(Record value, $Res Function(Record) then) =
      _$RecordCopyWithImpl<$Res, Record>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id')
          int? id,
      @JsonKey(name: 'start')
          int start,
      @JsonKey(name: 'last')
          int last,
      @JsonKey(name: 'duration')
          int duration,
      @DatetimeJsonConverter()
      @JsonKey(name: 'recorded_at')
          DateTime recordedAt,
      @DatetimeJsonConverter()
      @JsonKey(name: 'started_at')
          DateTime startedAt,
      @JsonKey(name: 'book_id')
          int bookId,
      @JsonKey(name: 'user_id')
          String userId});
}

/// @nodoc
class _$RecordCopyWithImpl<$Res, $Val extends Record>
    implements $RecordCopyWith<$Res> {
  _$RecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? start = null,
    Object? last = null,
    Object? duration = null,
    Object? recordedAt = null,
    Object? startedAt = null,
    Object? bookId = null,
    Object? userId = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as int,
      last: null == last
          ? _value.last
          : last // ignore: cast_nullable_to_non_nullable
              as int,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      recordedAt: null == recordedAt
          ? _value.recordedAt
          : recordedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startedAt: null == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      bookId: null == bookId
          ? _value.bookId
          : bookId // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RecordCopyWith<$Res> implements $RecordCopyWith<$Res> {
  factory _$$_RecordCopyWith(_$_Record value, $Res Function(_$_Record) then) =
      __$$_RecordCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id')
          int? id,
      @JsonKey(name: 'start')
          int start,
      @JsonKey(name: 'last')
          int last,
      @JsonKey(name: 'duration')
          int duration,
      @DatetimeJsonConverter()
      @JsonKey(name: 'recorded_at')
          DateTime recordedAt,
      @DatetimeJsonConverter()
      @JsonKey(name: 'started_at')
          DateTime startedAt,
      @JsonKey(name: 'book_id')
          int bookId,
      @JsonKey(name: 'user_id')
          String userId});
}

/// @nodoc
class __$$_RecordCopyWithImpl<$Res>
    extends _$RecordCopyWithImpl<$Res, _$_Record>
    implements _$$_RecordCopyWith<$Res> {
  __$$_RecordCopyWithImpl(_$_Record _value, $Res Function(_$_Record) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? start = null,
    Object? last = null,
    Object? duration = null,
    Object? recordedAt = null,
    Object? startedAt = null,
    Object? bookId = null,
    Object? userId = null,
  }) {
    return _then(_$_Record(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as int,
      last: null == last
          ? _value.last
          : last // ignore: cast_nullable_to_non_nullable
              as int,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      recordedAt: null == recordedAt
          ? _value.recordedAt
          : recordedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startedAt: null == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      bookId: null == bookId
          ? _value.bookId
          : bookId // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$_Record implements _Record {
  const _$_Record(
      {@JsonKey(name: 'id')
          this.id,
      @JsonKey(name: 'start')
          required this.start,
      @JsonKey(name: 'last')
          required this.last,
      @JsonKey(name: 'duration')
          required this.duration,
      @DatetimeJsonConverter()
      @JsonKey(name: 'recorded_at')
          required this.recordedAt,
      @DatetimeJsonConverter()
      @JsonKey(name: 'started_at')
          required this.startedAt,
      @JsonKey(name: 'book_id')
          required this.bookId,
      @JsonKey(name: 'user_id')
          required this.userId});

  factory _$_Record.fromJson(Map<String, dynamic> json) =>
      _$$_RecordFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int? id;
  @override
  @JsonKey(name: 'start')
  final int start;
  @override
  @JsonKey(name: 'last')
  final int last;
  @override
  @JsonKey(name: 'duration')
  final int duration;
  @override
  @DatetimeJsonConverter()
  @JsonKey(name: 'recorded_at')
  final DateTime recordedAt;
  @override
  @DatetimeJsonConverter()
  @JsonKey(name: 'started_at')
  final DateTime startedAt;
  @override
  @JsonKey(name: 'book_id')
  final int bookId;
  @override
  @JsonKey(name: 'user_id')
  final String userId;

  @override
  String toString() {
    return 'Record(id: $id, start: $start, last: $last, duration: $duration, recordedAt: $recordedAt, startedAt: $startedAt, bookId: $bookId, userId: $userId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Record &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.last, last) || other.last == last) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.recordedAt, recordedAt) ||
                other.recordedAt == recordedAt) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.bookId, bookId) || other.bookId == bookId) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, start, last, duration,
      recordedAt, startedAt, bookId, userId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RecordCopyWith<_$_Record> get copyWith =>
      __$$_RecordCopyWithImpl<_$_Record>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RecordToJson(
      this,
    );
  }
}

abstract class _Record implements Record {
  const factory _Record(
      {@JsonKey(name: 'id')
          final int? id,
      @JsonKey(name: 'start')
          required final int start,
      @JsonKey(name: 'last')
          required final int last,
      @JsonKey(name: 'duration')
          required final int duration,
      @DatetimeJsonConverter()
      @JsonKey(name: 'recorded_at')
          required final DateTime recordedAt,
      @DatetimeJsonConverter()
      @JsonKey(name: 'started_at')
          required final DateTime startedAt,
      @JsonKey(name: 'book_id')
          required final int bookId,
      @JsonKey(name: 'user_id')
          required final String userId}) = _$_Record;

  factory _Record.fromJson(Map<String, dynamic> json) = _$_Record.fromJson;

  @override
  @JsonKey(name: 'id')
  int? get id;
  @override
  @JsonKey(name: 'start')
  int get start;
  @override
  @JsonKey(name: 'last')
  int get last;
  @override
  @JsonKey(name: 'duration')
  int get duration;
  @override
  @DatetimeJsonConverter()
  @JsonKey(name: 'recorded_at')
  DateTime get recordedAt;
  @override
  @DatetimeJsonConverter()
  @JsonKey(name: 'started_at')
  DateTime get startedAt;
  @override
  @JsonKey(name: 'book_id')
  int get bookId;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(ignore: true)
  _$$_RecordCopyWith<_$_Record> get copyWith =>
      throw _privateConstructorUsedError;
}
