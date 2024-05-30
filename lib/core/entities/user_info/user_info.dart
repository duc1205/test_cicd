import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'user_info.freezed.dart';
part 'user_info.g.dart';

@freezed
class UserInfo with _$UserInfo {
  const UserInfo._();

  @HiveType(typeId: 0, adapterName: 'UserInfoAdapter')
  const factory UserInfo({
    @HiveField(0) String? accessToken,
    @HiveField(1) String? refreshToken,
    @HiveField(2) int? id,
    @HiveField(3) String? email,
    @HiveField(4) String? name,
    @HiveField(5) String? avatar,
  }) = _UserInfo;

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
}
