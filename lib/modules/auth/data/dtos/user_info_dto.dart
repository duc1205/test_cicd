import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_info_dto.freezed.dart';
part 'user_info_dto.g.dart';

@freezed
class UserInfoDto with _$UserInfoDto {
  const factory UserInfoDto({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'password') String? password,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'role') String? role,
    @JsonKey(name: 'avatar') String? avatar,
  }) = _UserInfoDto;

  factory UserInfoDto.fromJson(Map<String, dynamic> json) =>
      _$UserInfoDtoFromJson(json);
}
