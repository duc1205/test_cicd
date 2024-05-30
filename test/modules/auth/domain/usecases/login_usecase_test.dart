import 'package:app_user/core/core.dart';
import 'package:app_user/modules/auth/domain/repositories/auth_repository.dart';
import 'package:app_user/modules/auth/domain/usecases/login_usecase.dart';
import 'package:app_user/services/auth/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockAuthService extends Mock implements AuthService {}

void main() {
  group('LoginUseCase', () {
    late LoginUseCase loginUseCase;
    late MockAuthRepository mockAuthRepository;
    late MockAuthService mockAuthService;
    const String aToken = 'aToken';
    const String rToken = 'rToken';

    setUpAll(() {
      mockAuthRepository = MockAuthRepository();
      mockAuthService = MockAuthService();
      loginUseCase = LoginUseCase(
        authRepository: mockAuthRepository,
        authService: mockAuthService,
      );

      when(() => mockAuthService.accessToken).thenAnswer((_) => aToken);
      when(() => mockAuthService.refreshToken).thenAnswer((_) => rToken);
    });

    test('login() should return Right(true) when successful', () async {
      // Arrange
      final Either<DataError, bool> expectedResponse = Right(true);
      final UserInfo repoResponseData = UserInfo();
      final Either<DataError, UserInfo> repoResponse = Right(repoResponseData);
      when(() => mockAuthRepository.login())
          .thenAnswer((_) async => repoResponse);
      when(() => mockAuthService.updateUser(repoResponseData))
          .thenAnswer((_) async => true);

      // Act
      final result = await loginUseCase.login();

      // Assert
      expect(result, expectedResponse);
      verify(() => mockAuthRepository.login()).called(1);
      verify(() => mockAuthService.updateUser(UserInfo())).called(1);
    });

    test('login() should return Left with DataError when unsuccessful',
        () async {
      // Arrange
      final Either<DataError, bool> expectedError = Left(DataError());
      final Either<DataError, UserInfo> repoResponse = Left(DataError());
      when(() => mockAuthRepository.login())
          .thenAnswer((_) async => repoResponse);

      // Act
      final result = await loginUseCase.login();

      // Assert
      expect(result, expectedError);
      verifyNever(() => mockAuthService.updateUser(UserInfo()));
      verify(() => mockAuthRepository.login()).called(1);
    });

    test('getUserInfo() should return Right(true) when successful', () async {
      // Arrange
      final Either<DataError, bool> expectedResponse = Right(true);
      final UserInfo repoResponseData = UserInfo();
      final Either<DataError, UserInfo> repoResponse = Right(repoResponseData);
      final UserInfo newUserInfo = repoResponseData.copyWith(
        accessToken: aToken,
        refreshToken: rToken,
      );
      when(() => mockAuthRepository.getUserInfo())
          .thenAnswer((_) async => repoResponse);
      when(() => mockAuthService.updateUser(newUserInfo))
          .thenAnswer((_) async => true);

      // Act
      final result = await loginUseCase.getUserInfo();

      // Assert
      expect(result, expectedResponse);
      verify(() => mockAuthRepository.getUserInfo()).called(1);
      verify(() => mockAuthService.updateUser(newUserInfo)).called(1);
    });

    test('getUserInfo() should return Left with DataError when unsuccessful',
        () async {
      // Arrange
      final Either<DataError, bool> expectedError = Left(DataError());
      final Either<DataError, UserInfo> repoResponse = Left(DataError());
      when(() => mockAuthRepository.getUserInfo())
          .thenAnswer((_) async => repoResponse);

      // Act
      final result = await loginUseCase.getUserInfo();

      // Assert
      expect(result, expectedError);
      verifyNever(() => mockAuthService.updateUser(UserInfo()));
      verify(() => mockAuthRepository.getUserInfo()).called(1);
    });
  });
}
