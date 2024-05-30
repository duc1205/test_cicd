import '../../../../core/core.dart';
import '../dtos/auth_dto.dart';

class AuthDtoToUserInfoMapper extends BaseMapper<AuthDto, UserInfo> {
  @override
  UserInfo call(AuthDto obj) {
    return UserInfo(
      accessToken: obj.accessToken,
      refreshToken: obj.refreshToken,
    );
  }
}
