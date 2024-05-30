import 'package:app_user/core/core.dart';
import 'package:app_user/modules/auth/domain/usecases/login_usecase.dart';
import 'package:app_user/modules/auth/presentation/login_screen/cubit/login_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockLoginUseCase mockLoginUseCase;

  setUpAll(() {
    mockLoginUseCase = MockLoginUseCase();
  });

  group('LoginCubit', () {
    LoginCubit buildCubit() => LoginCubit(loginUseCase: mockLoginUseCase);

    group('constructor', () {
      test('works properly', () {
        expect(buildCubit, returnsNormally);
      });

      test('has correct initial state', () {
        expect(
          buildCubit().state,
          equals(const LoginState.initial()),
        );
      });
    });

    group('login', () {
      blocTest<LoginCubit, LoginState>(
        'Should emit [LoginState.loading(), LoginState.success()] when login successful',
        setUp: () {
          when(() => mockLoginUseCase.login()).thenAnswer(
            (_) async => Right(true),
          );
          when(() => mockLoginUseCase.getUserInfo()).thenAnswer(
            (_) async => Right(true),
          );
        },
        build: buildCubit,
        act: (cubit) => cubit.handleLogin(),
        expect: () => [
          const LoginState.loading(),
          const LoginState.success(),
        ],
        verify: (_) {
          verify(() => mockLoginUseCase.login()).called(1);
          verify(() => mockLoginUseCase.getUserInfo()).called(1);
        },
      );

      blocTest<LoginCubit, LoginState>(
        'Should emit [LoginState.loading(), LoginState.error()] when login error',
        setUp: () {
          when(() => mockLoginUseCase.login()).thenAnswer(
            (_) async => Left(DataError(code: 1, message: 'Login Error')),
          );
          when(() => mockLoginUseCase.getUserInfo()).thenAnswer(
            (_) async => Right(true),
          );
        },
        build: buildCubit,
        act: (cubit) => cubit.handleLogin(),
        expect: () => [
          const LoginState.loading(),
          const LoginState.error(DataError(
            code: 1,
            message: 'Login Error',
          )),
        ],
        verify: (_) {
          verify(() => mockLoginUseCase.login()).called(1);
          verifyNever(() => mockLoginUseCase.getUserInfo());
        },
      );

      blocTest<LoginCubit, LoginState>(
        'Should emit [LoginState.loading(), LoginState.error()] when get user info error',
        setUp: () {
          when(() => mockLoginUseCase.login()).thenAnswer(
            (_) async => Right(true),
          );
          when(() => mockLoginUseCase.getUserInfo()).thenAnswer(
            (_) async => Left(
              DataError(
                code: 1,
                message: 'Get user info Error',
              ),
            ),
          );
        },
        build: buildCubit,
        act: (cubit) => cubit.handleLogin(),
        expect: () => [
          const LoginState.loading(),
          const LoginState.error(
            DataError(
              code: 1,
              message: 'Get user info Error',
            ),
          ),
        ],
        verify: (_) {
          verify(() => mockLoginUseCase.login()).called(1);
          verify(() => mockLoginUseCase.getUserInfo()).called(1);
        },
      );
    });
  });
}
