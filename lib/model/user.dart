import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class UserToken with _$UserToken {
  // ignore: invalid_annotation_target
  const factory UserToken({
    required String refresh,
    required String access,
  }) = _User;

  factory UserToken.fromJson(Map<String, dynamic> json) =>
      _$UserTokenFromJson(json);
}
