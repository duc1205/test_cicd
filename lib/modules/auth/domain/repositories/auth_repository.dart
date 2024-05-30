import 'package:fpdart/fpdart.dart';

import '../../../../core/core.dart';

abstract class AuthRepository {
  Future<Either<DataError, UserInfo>> login();

  Future<Either<DataError, UserInfo>> getUserInfo();
}
