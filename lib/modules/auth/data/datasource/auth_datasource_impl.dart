import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../dtos/auth_dto.dart';
import '../dtos/user_info_dto.dart';
import '../mappers/login_user_mapper.dart';
import '../mappers/user_info_mapper.dart';
import 'auth_datasource.dart';

@LazySingleton(as: AuthDataSource)
class AuthDataSourceImpl extends AuthDataSource {
  final Dio _dio;

  AuthDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<Either<DataError, UserInfo>> login() async {
    try {
      // Call login API
      final resp = await _dio.post(
        'https://api.escuelajs.co/api/v1/auth/login',
        data: {"email": "john@mail.com", "password": "changeme"},
      );

      // Check response
      // If login success, return user info with token
      if (resp.isCreated || resp.isSuccess) {
        final loginUserDto = AuthDto.fromJson(resp.data);
        final mapper = AuthDtoToUserInfoMapper();
        final userInfo = mapper(loginUserDto);
        return Right(userInfo);
      }

      // Return error
      return const Left(
        DataError(
          code: ErrorCodes.loginError,
          message: 'Login failed',
        ),
      );
    } catch (e) {
      return DataError.handleException(e);
    }
  }

  @override
  Future<Either<DataError, UserInfo>> getUserInfo() async {
    try {
      // Call get profile API
      final resp = await _dio.get(
        'https://api.escuelajs.co/api/v1/auth/profile',
      );

      // Check response
      // If get user info success, return user info
      if (resp.isSuccess) {
        final userInfoDto = UserInfoDto.fromJson(resp.data);
        final mapper = UserInfoDtoToUserInfoMapper();
        return Right(mapper(userInfoDto));
      }

      // Return error
      return const Left(
        DataError(
          code: ErrorCodes.getUserInfoError,
          message: 'Get user info failed',
        ),
      );
    } catch (e) {
      return DataError.handleException(e);
    }
  }
}
