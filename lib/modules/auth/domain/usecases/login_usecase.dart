import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../../../services/auth/auth_service.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class LoginUseCase {
  final AuthRepository _authRepository;
  final AuthService _authService;

  LoginUseCase(
      {required AuthRepository authRepository,
      required AuthService authService})
      : _authRepository = authRepository = authRepository,
        _authService = authService;

  Future<Either<DataError, bool>> login() async {
    final response = await _authRepository.login();
    return response.fold(
      (l) => Left(l),
      (r) {
        _authService.updateUser(r);
        return Right(true);
      },
    );
  }

  Future<Either<DataError, bool>> getUserInfo() async {
    final response = await _authRepository.getUserInfo();
    return response.fold(
      (l) => Left(l),
      (r) {
        final newUserInfo = r.copyWith(
            accessToken: _authService.accessToken,
            refreshToken: _authService.refreshToken);
        _authService.updateUser(newUserInfo);
        return Right(true);
      },
    );
  }
}
