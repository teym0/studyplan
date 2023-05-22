// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goal_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Goal _$GoalFromJson(Map<String, dynamic> json) {
  return _Goal.fromJson(json);
}

/// @nodoc
mixin _$Goal {
  @JsonKey(name: 'id')
  int? get id => throw _privateConstructorUsedError;
  @DatetimeJsonConverter()
  @JsonKey(name: 'started_at')
  DateTime get startedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'day')
  int get day => throw _privateConstructorUsedError;
  @JsonKey(name: 'reflected')
  bool get reflected => throw _privateConstructorUsedError;
  @JsonKey(name: 'percentage')
  int? get percentage => throw _privateConstructorUsedError;
  @JsonKey(name: 'start')
  int get start => throw _privateConstructorUsedError;
  @JsonKey(name: 'last')
  int get last => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'book_id')
  int get bookId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GoalCopyWith<Goal> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoalCopyWith<$Res> {
  factory $GoalCopyWith(Goal value, $Res Function(Goal) then) =
      _$GoalCopyWithImpl<$Res, Goal>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int? id,
      @DatetimeJsonConverter() @JsonKey(name: 'started_at') DateTime startedAt,
      @JsonKey(name: 'day') int day,
      @JsonKey(name: 'reflected') bool reflected,
      @JsonKey(name: 'percentage') int? percentage,
      @JsonKey(name: 'start') int start,
      @JsonKey(name: 'last') int last,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'book_id') int bookId});
}

/// @nodoc
class _$GoalCopyWithImpl<$Res, $Val extends Goal>
    implements $GoalCopyWith<$Res> {
  _$GoalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? startedAt = null,
    Object? day = null,
    Object? reflected = null,
    Object? percentage = freezed,
    Object? start = null,
    Object? last = null,
    Object? userId = null,
    Object? bookId = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      startedAt: null == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as int,
      reflected: null == reflected
          ? _value.reflected
          : reflected // ignore: cast_nullable_to_non_nullable
              as bool,
      percentage: freezed == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as int?,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as int,
      last: null == last
          ? _value.last
          : last // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      bookId: null == bookId
          ? _value.bookId
          : bookId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GoalCopyWith<$Res> implements $GoalCopyWith<$Res> {
  factory _$$_GoalCopyWith(_$_Goal value, $Res Function(_$_Goal) then) =
      __$$_GoalCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int? id,
      @DatetimeJsonConverter() @JsonKey(name: 'started_at') DateTime startedAt,
      @JsonKey(name: 'day') int day,
      @JsonKey(name: 'reflected') bool reflected,
      @JsonKey(name: 'percentage') int? percentage,
      @JsonKey(name: 'start') int start,
      @JsonKey(name: 'last') int last,
      @JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'book_id') int bookId});
}

/// @nodoc
class __$$_GoalCopyWithImpl<$Res> extends _$GoalCopyWithImpl<$Res, _$_Goal>
    implements _$$_GoalCopyWith<$Res> {
  __$$_GoalCopyWithImpl(_$_Goal _value, $Res Function(_$_Goal) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? startedAt = null,
    Object? day = null,
    Object? reflected = null,
    Object? percentage = freezed,
    Object? start = null,
    Object? last = null,
    Object? userId = null,
    Object? bookId = null,
  }) {
    return _then(_$_Goal(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      startedAt: null == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as int,
      reflected: null == reflected
          ? _value.reflected
          : reflected // ignore: cast_nullable_to_non_nullable
              as bool,
      percentage: freezed == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as int?,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as int,
      last: null == last
          ? _value.last
          : last // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      bookId: null == bookId
          ? _value.bookId
          : bookId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$_Goal implements _Goal {
  const _$_Goal(
      {@JsonKey(name: 'id')
          this.id,
      @DatetimeJsonConverter()
      @JsonKey(name: 'started_at')
          required this.startedAt,
      @JsonKey(name: 'day')
          required this.day,
      @JsonKey(name: 'reflected')
          required this.reflected,
      @JsonKey(name: 'percentage')
          this.percentage,
      @JsonKey(name: 'start')
          required this.start,
      @JsonKey(name: 'last')
          required this.last,
      @JsonKey(name: 'user_id')
          required this.userId,
      @JsonKey(name: 'book_id')
          required this.bookId});

  factory _$_Goal.fromJson(Map<String, dynamic> json) => _$$_GoalFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int? id;
  @override
  @DatetimeJsonConverter()
  @JsonKey(name: 'started_at')
  final DateTime startedAt;
  @override
  @JsonKey(name: 'day')
  final int day;
  @override
  @JsonKey(name: 'reflected')
  final bool reflected;
  @override
  @JsonKey(name: 'percentage')
  final int? percentage;
  @override
  @JsonKey(name: 'start')
  final int start;
  @override
  @JsonKey(name: 'last')
  final int last;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'book_id')
  final int bookId;

  @override
  String toString() {
    return 'Goal(id: $id, startedAt: $startedAt, day: $day, reflected: $reflected, percentage: $percentage, start: $start, last: $last, userId: $userId, bookId: $bookId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Goal &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.reflected, reflected) ||
                other.reflected == reflected) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.last, last) || other.last == last) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.bookId, bookId) || other.bookId == bookId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, startedAt, day, reflected,
      percentage, start, last, userId, bookId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GoalCopyWith<_$_Goal> get copyWith =>
      __$$_GoalCopyWithImpl<_$_Goal>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GoalToJson(
      this,
    );
  }
}

abstract class _Goal implements Goal {
  const factory _Goal(
      {@JsonKey(name: 'id')
          final int? id,
      @DatetimeJsonConverter()
      @JsonKey(name: 'started_at')
          required final DateTime startedAt,
      @JsonKey(name: 'day')
          required final int day,
      @JsonKey(name: 'reflected')
          required final bool reflected,
      @JsonKey(name: 'percentage')
          final int? percentage,
      @JsonKey(name: 'start')
          required final int start,
      @JsonKey(name: 'last')
          required final int last,
      @JsonKey(name: 'user_id')
          required final String userId,
      @JsonKey(name: 'book_id')
          required final int bookId}) = _$_Goal;

  factory _Goal.fromJson(Map<String, dynamic> json) = _$_Goal.fromJson;

  @override
  @JsonKey(name: 'id')
  int? get id;
  @override
  @DatetimeJsonConverter()
  @JsonKey(name: 'started_at')
  DateTime get startedAt;
  @override
  @JsonKey(name: 'day')
  int get day;
  @override
  @JsonKey(name: 'reflected')
  bool get reflected;
  @override
  @JsonKey(name: 'percentage')
  int? get percentage;
  @override
  @JsonKey(name: 'start')
  int get start;
  @override
  @JsonKey(name: 'last')
  int get last;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'book_id')
  int get bookId;
  @override
  @JsonKey(ignore: true)
  _$$_GoalCopyWith<_$_Goal> get copyWith => throw _privateConstructorUsedError;
}
