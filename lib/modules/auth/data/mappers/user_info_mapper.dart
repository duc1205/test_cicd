import '../../../../core/core.dart';
import '../dtos/user_info_dto.dart';

class UserInfoDtoToUserInfoMapper extends BaseMapper<UserInfoDto, UserInfo> {
  @override
  UserInfo call(UserInfoDto obj) {
    return UserInfo(
      id: obj.id,
      name: obj.name,
      email: obj.email,
      avatar: obj.avatar,
    );
  }
}
