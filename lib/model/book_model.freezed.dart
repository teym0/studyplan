// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Book _$BookFromJson(Map<String, dynamic> json) {
  return _Book.fromJson(json);
}

/// @nodoc
mixin _$Book {
  @JsonKey(name: 'id')
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'title')
  String get title => throw _privateConstructorUsedError;
  @DatetimeJsonConverter()
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'amount')
  int get amount => throw _privateConstructorUsedError;
  @JsonKey(name: 'unit_name')
  String get unitName => throw _privateConstructorUsedError;
  @JsonKey(name: 'user')
  int? get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'image')
  String? get imageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BookCopyWith<Book> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookCopyWith<$Res> {
  factory $BookCopyWith(Book value, $Res Function(Book) then) =
      _$BookCopyWithImpl<$Res, Book>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int? id,
      @JsonKey(name: 'title') String title,
      @DatetimeJsonConverter() @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'amount') int amount,
      @JsonKey(name: 'unit_name') String unitName,
      @JsonKey(name: 'user') int? userId,
      @JsonKey(name: 'image') String? imageUrl});
}

/// @nodoc
class _$BookCopyWithImpl<$Res, $Val extends Book>
    implements $BookCopyWith<$Res> {
  _$BookCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? createdAt = null,
    Object? amount = null,
    Object? unitName = null,
    Object? userId = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      unitName: null == unitName
          ? _value.unitName
          : unitName // ignore: cast_nullable_to_non_nullable
              as String,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BookCopyWith<$Res> implements $BookCopyWith<$Res> {
  factory _$$_BookCopyWith(_$_Book value, $Res Function(_$_Book) then) =
      __$$_BookCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int? id,
      @JsonKey(name: 'title') String title,
      @DatetimeJsonConverter() @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'amount') int amount,
      @JsonKey(name: 'unit_name') String unitName,
      @JsonKey(name: 'user') int? userId,
      @JsonKey(name: 'image') String? imageUrl});
}

/// @nodoc
class __$$_BookCopyWithImpl<$Res> extends _$BookCopyWithImpl<$Res, _$_Book>
    implements _$$_BookCopyWith<$Res> {
  __$$_BookCopyWithImpl(_$_Book _value, $Res Function(_$_Book) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? createdAt = null,
    Object? amount = null,
    Object? unitName = null,
    Object? userId = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_$_Book(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      unitName: null == unitName
          ? _value.unitName
          : unitName // ignore: cast_nullable_to_non_nullable
              as String,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$_Book implements _Book {
  const _$_Book(
      {@JsonKey(name: 'id')
          this.id,
      @JsonKey(name: 'title')
          required this.title,
      @DatetimeJsonConverter()
      @JsonKey(name: 'created_at')
          required this.createdAt,
      @JsonKey(name: 'amount')
          required this.amount,
      @JsonKey(name: 'unit_name')
          required this.unitName,
      @JsonKey(name: 'user')
          this.userId,
      @JsonKey(name: 'image')
          this.imageUrl});

  factory _$_Book.fromJson(Map<String, dynamic> json) => _$$_BookFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int? id;
  @override
  @JsonKey(name: 'title')
  final String title;
  @override
  @DatetimeJsonConverter()
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'amount')
  final int amount;
  @override
  @JsonKey(name: 'unit_name')
  final String unitName;
  @override
  @JsonKey(name: 'user')
  final int? userId;
  @override
  @JsonKey(name: 'image')
  final String? imageUrl;

  @override
  String toString() {
    return 'Book(id: $id, title: $title, createdAt: $createdAt, amount: $amount, unitName: $unitName, userId: $userId, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Book &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.unitName, unitName) ||
                other.unitName == unitName) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, title, createdAt, amount, unitName, userId, imageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BookCopyWith<_$_Book> get copyWith =>
      __$$_BookCopyWithImpl<_$_Book>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BookToJson(
      this,
    );
  }
}

abstract class _Book implements Book {
  const factory _Book(
      {@JsonKey(name: 'id')
          final int? id,
      @JsonKey(name: 'title')
          required final String title,
      @DatetimeJsonConverter()
      @JsonKey(name: 'created_at')
          required final DateTime createdAt,
      @JsonKey(name: 'amount')
          required final int amount,
      @JsonKey(name: 'unit_name')
          required final String unitName,
      @JsonKey(name: 'user')
          final int? userId,
      @JsonKey(name: 'image')
          final String? imageUrl}) = _$_Book;

  factory _Book.fromJson(Map<String, dynamic> json) = _$_Book.fromJson;

  @override
  @JsonKey(name: 'id')
  int? get id;
  @override
  @JsonKey(name: 'title')
  String get title;
  @override
  @DatetimeJsonConverter()
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'amount')
  int get amount;
  @override
  @JsonKey(name: 'unit_name')
  String get unitName;
  @override
  @JsonKey(name: 'user')
  int? get userId;
  @override
  @JsonKey(name: 'image')
  String? get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$_BookCopyWith<_$_Book> get copyWith => throw _privateConstructorUsedError;
}
