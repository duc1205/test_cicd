import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasource/auth_datasource.dart';

@LazySingleton(as: AuthRepository)
class AuthRemoteRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource;

  AuthRemoteRepositoryImpl({required AuthDataSource authDataSource})
      : _authDataSource = authDataSource;

  @override
  Future<Either<DataError, UserInfo>> login() async => _authDataSource.login();

  @override
  Future<Either<DataError, UserInfo>> getUserInfo() async =>
      _authDataSource.getUserInfo();
}
